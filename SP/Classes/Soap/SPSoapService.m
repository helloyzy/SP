//
//  SPSoapService.m
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPSoapService.h"
#import "SoapUtil.h"
#import "SPCachedData.h"
#import "UTLDebug.h"

@implementation SPSoapService

@synthesize headProps;
@synthesize serviceUrl;

#pragma mark - protected methods implementations

- (void) addHeadProp:(NSString *)key withValue:(id)value {
    if (!headProps) {
        self.headProps = [NSMutableDictionary dictionary];
    }
    [headProps setObject:value forKey:key];
}

- (void) addSoapActionHeadProp:(NSString *)soapAction {
    NSString * soapActionUrl = [SP_SOAP_HEAD_SOAPACTION_PREFIX stringByAppendingString:soapAction];
    [self addHeadProp:SP_SOAP_HEAD_KEY_SOAPACTION withValue:soapActionUrl];
}

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper {
    [self prepareUrlAndHeadProps];
    // add host header property
    [self addHeadProp:@"Host" withValue:[SPCachedData serviceHost]];
    return [SoapUtil buildRequestWithUrl:serviceUrl soapMsg:enveloper headProps:headProps];
}

- (id) parseResponse:(NSString *)responseString {
    RXMLElement * xml = [RXMLElement elementFromXMLString:responseString];
    return [self parseResponseWithXml:xml];
}

#pragma mark - connection callbacks 

- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge*)challenge {
    if ([challenge previousFailureCount] == 0) {
        UTLLog(@"Receive new authentication challenge");
        [[challenge sender] useCredential:[SPCachedData credential] forAuthenticationChallenge:challenge];
        return;
    }     
    NSLog(@"Authentication failure!");
    [[challenge sender] cancelAuthenticationChallenge:challenge];
    // inform the user that the user name and password in the preferences are incorrect
}


#pragma mark - destroy methods

- (void) dealloc {
    self.headProps = nil;
    self.serviceUrl = nil;
    [super dealloc];
}

@end
