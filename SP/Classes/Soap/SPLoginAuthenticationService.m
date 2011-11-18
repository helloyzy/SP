//
//  SPLoginAuthenticationService.m
//  SP
//
//  Created by Whitman Yang on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPLoginAuthenticationService.h"
#import "UTLDebug.h"

@implementation SPLoginAuthenticationService 

#pragma mark - public methods 

+ (void) resetAuthentication {
    // reset the credentials cache...
    NSDictionary *credentialsDict = [[NSURLCredentialStorage sharedCredentialStorage] allCredentials];
    
    if ([credentialsDict count] > 0) {
        // the credentialsDict has NSURLProtectionSpace objs as keys and dicts of userName => NSURLCredential
        NSEnumerator *protectionSpaceEnumerator = [credentialsDict keyEnumerator];
        id urlProtectionSpace;
        
        // iterate over all NSURLProtectionSpaces
        while (urlProtectionSpace = [protectionSpaceEnumerator nextObject]) {
            NSEnumerator *userNameEnumerator = [[credentialsDict objectForKey:urlProtectionSpace] keyEnumerator];
            id userName;
            
            // iterate over all usernames for this protectionspace, which are the keys for the actual NSURLCredentials
            while (userName = [userNameEnumerator nextObject]) {
                NSURLCredential *cred = [[credentialsDict objectForKey:urlProtectionSpace] objectForKey:userName];
                UTLLog(@"cred to be removed: %@", cred);
                [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:cred forProtectionSpace:urlProtectionSpace];
            }
        }
    }
}


#pragma mark - protected methods implementations

- (void) prepareUrlAndHeadProps {
    // self.serviceUrl = SP_SOAP_URL_AUTHENTICATION;
    [self buildServiceUrlWithName:SP_SOAP_URL_AUTHENTICATION];
    [self addSoapActionHeadProp:@"Login"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    return xml;
}

- (void) sendNotificationOnSuccess:(id)value {
    
}

#pragma mark - destroy methods

- (void) dealloc {
    [super dealloc];
}

@end
