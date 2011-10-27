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
#import "RXMLElement.h"

@interface SoapServiceBase () 

@property (nonatomic, retain) NSMutableData * responseData;
@property (nonatomic, retain) NSURLConnection * connection;

- (void) fail:(NSString *)description;

@end

@implementation SoapServiceBase

@synthesize responseData;
@synthesize connection;

#pragma mark - public methods

- (void) sendSoapRequest:(NSURLRequest *)request {
    @try {
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    @catch (NSException *exception) {
        [self fail:[NSString stringWithFormat:@"%@%@", [exception name], [exception reason]]];
    }
}
         
#pragma mark - private methods
         
- (void) fail:(NSString *)description {
    UTLLog(@"Caught %@", description);
    self.responseData = nil;
    self.connection = nil;
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
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"%@", string);
    RXMLElement * rxml = [RXMLElement elementFromXMLString:string];
    RXMLElement * userInfo = [rxml child:@"soap:Body.GetUserInfoResponse.GetUserInfoResult.GetUserInfo.User"];
    NSLog(@"%@", [userInfo attribute:@"LoginName"]);
    [string release];
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
