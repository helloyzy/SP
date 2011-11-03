//
//  SoapServiceBase.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapServiceBase.h"
#import "Macros.h"
#import "UTLDebug.h"
#import "SPCachedData.h"

@interface SoapServiceBase () 

@property (nonatomic, retain) NSMutableData * responseData;
@property (nonatomic, retain) NSURLConnection * connection;

- (void) fail:(NSString *)description;
- (void) sendSoapRequest:(NSURLRequest *)request;

@end

@implementation SoapServiceBase

@synthesize soapRequestParam;
@synthesize responseData;
@synthesize connection;

#pragma mark - public methods

- (void) request {    
    if (soapRequestParam) {
        SoapEnveloper * soapEnveloper = [[SoapEnveloper alloc] init];
        [soapEnveloper write:soapRequestParam];
        NSURLRequest * request = [self buildRequest:soapEnveloper];
        [soapEnveloper release];
        if (request) {
            [self sendSoapRequest:request];
        } else {
            [self fail:@"Failed to build the request"];
        }
    } else {
        [self fail:@"Can not find SOAP request parameter to build up request"]; 
    }
}
         
#pragma mark - private methods
         
- (void) fail:(NSString *)description {
    UTLLog(@"Exception caught: %@", description);
    self.responseData = nil;
    self.connection = nil;
}

- (void) sendSoapRequest:(NSURLRequest *)request {
    @try {
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    @catch (NSException *exception) {
        [self fail:[NSString stringWithFormat:@"%@%@", [exception name], [exception reason]]];
    }
}
         
#pragma mark - connection callbacks 

- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge*)challenge {
    if ([challenge previousFailureCount] == 0) {
        [[challenge sender] useCredential:[SPCachedData credential] forAuthenticationChallenge:challenge];
        return;
    } 
    [[challenge sender] cancelAuthenticationChallenge:challenge];
    // inform the user that the user name and password
    // in the preferences are incorrect
    //[self showPreferencesCredentialsAreIncorrectPanel:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [NSMutableData data];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {    
    [self fail:[error description]];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {	
    NSString * responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    UTLLog(@"%@", responseString);
    id responseObject = [self parseResponse:responseString];
    [responseString release];
    if (responseObject) {
        [self sendNotificationOnSuccess:responseObject];
    } else {
        [self fail:@"Failure during convert response string to object"];
    }
    self.responseData = nil;
    self.connection = nil;
}

#pragma mark - destroy related

- (void) dealloc {
    self.soapRequestParam = nil;
    self.responseData = nil;
    self.connection = nil;
    [super dealloc];
}

@end
