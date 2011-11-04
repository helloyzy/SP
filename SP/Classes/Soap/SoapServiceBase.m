//
//  SoapServiceBase.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapServiceBase.h"
#import "SoapRequest.h"
#import "UTLDebug.h"

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
        UTLLog(@"Request to send: %@", [soapEnveloper toString]);
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
        self.responseData = nil;
        self.connection = nil;
    } else {
        [self fail:@"Failure during convert response string to object"];
    }
}

#pragma mark - destroy related

- (void) dealloc {
    self.soapRequestParam = nil;
    self.responseData = nil;
    self.connection = nil;
    [super dealloc];
}

@end
