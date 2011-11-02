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
#import "SoapEnveloper.h"

@interface SoapServiceBase () 

@property (nonatomic, retain) NSMutableData * responseData;
@property (nonatomic, retain) NSURLConnection * connection;

- (void) fail:(NSString *)description;
- (void) sendSoapRequest:(NSURLRequest *)request;

@end

@implementation SoapServiceBase

@synthesize responseData;
@synthesize connection;

#pragma mark - public methods

- (void) request {
    SoapEnveloper * soapEnveloper = [[SoapEnveloper alloc] init];
    NSURLRequest * request = [self buildRequest:soapEnveloper];
    [soapEnveloper release];
    if (request) {
        [self sendSoapRequest:request];
    } else {
        [self fail:@"Failed to build the request"];
    }
}

#pragma mark - default implementations for protected methods

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper {
    return nil;
}

- (id) parseResponse:(NSString *)responseString {
    return nil;
}

- (void) sendNotificationOnSuccess:(id)value {
    // empty implementation
}
         
#pragma mark - private methods
         
- (void) fail:(NSString *)description {
    UTLLog(@"Caught %@", description);
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
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:@"Perficient\\spark.pan" password:@"zhe@812Bl" persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // inform the user that the user name and password
        // in the preferences are incorrect
        //[self showPreferencesCredentialsAreIncorrectPanel:self];
    }
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
    NSString * responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
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
    SAFE_RELEASE(responseData);
    SAFE_RELEASE(connection);
    [super dealloc];
}


@end
