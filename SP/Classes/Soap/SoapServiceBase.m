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

// Connection timeout setting (in seconds)
static int SP_CONNECTION_TIMEOUT = 20;

@interface SoapServiceBase () {
    BOOL isTimeoutTimerCancelled;
}

@property (nonatomic, retain) NSMutableData * responseData;
@property (nonatomic, retain) NSURLConnection * connection;

- (void) sendSoapRequest:(NSURLRequest *)request;
- (void) handleError:(NSError *)error;
- (void) handleException:(NSException *)exception;
- (void) timeout;

@end

@implementation SoapServiceBase

@synthesize errorObj;
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

#pragma mark - protected methods, default implementations, child classes need to override these methods to perform customized behaviours

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper {
    return nil;
}

- (void) sendNotificationOnSuccess:(id)value {
    
}

- (void) sendNotificationOnFailure:(id)errorInfo {
    
}

- (NSString *) parseError {
    return (NSString *) errorObj;
}
         
#pragma mark - protected methods, generic methods for child classes to use, do not override unless with designated purposes
         
- (void) fail:(NSString *)description {
    UTLLog(@"Exception caught: %@", description);
    [self failWithErrorInfo:description];
}

- (void) failWithErrorInfo:(id)errorInfo {
    [self sendNotificationOnFailure:errorInfo];
    self.responseData = nil;
    self.connection = nil;
}

#pragma mark - private methods

- (void) sendSoapRequest:(NSURLRequest *)request {
    @try {
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        isTimeoutTimerCancelled = NO;
        // schedule timeout checking
        [self performSelector:@selector(timeout) withObject:nil afterDelay:SP_CONNECTION_TIMEOUT];
    } @catch (NSException *exception) {
        [self handleException:exception];
    }
}

- (void) handleException:(NSException *)exception {
    UTLLog(@"Original exception information: %@", exception);
    NSString * parsedException = [NSString stringWithFormat:@"%@:%@", [exception name], [exception reason]];
    [self fail:parsedException];
}

- (void) handleError:(NSError *)error {
    UTLLog(@"Original error information: %@", error);
    [self fail:[error description]];
}

#pragma mark - NSURLConnection callbacks
         
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [NSMutableData data];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {  
    isTimeoutTimerCancelled = YES;
    // ignore the passed-in error if we have customized error information
    if (errorObj) {
        [self fail:[self parseError]];
    } else {
        [self handleError:error];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {	
    isTimeoutTimerCancelled = YES;
    NSString * responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    UTLLog(@"%@", responseString);
    id responseObject = [self parseResponse:responseString];
    [responseString release];
    // check whether there is error during parsing
    if (errorObj) {
        [self fail:[self parseError]];
    } else {
        [self sendNotificationOnSuccess:responseObject];
        self.responseData = nil;
        self.connection = nil;
    }
}

#pragma mark - timeout 

- (void) timeout {
    if (isTimeoutTimerCancelled) {
        return;
    }
    [self.connection cancel];
    [self fail:@"Time out error."];    
}

#pragma mark - destroy related

- (void) dealloc {
    self.errorObj = nil;
    self.soapRequestParam = nil;
    self.responseData = nil;
    self.connection = nil;
    [super dealloc];
}

@end
