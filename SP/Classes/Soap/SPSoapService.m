//
//  SPSoapService.m
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPSoapService.h"
#import "SoapUtil.h"

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
    return [SoapUtil buildRequestWithUrl:serviceUrl soapMsg:enveloper headProps:headProps];
}

- (id) parseResponse:(NSString *)responseString {
    RXMLElement * xml = [RXMLElement elementFromXMLString:responseString];
    return [self parseResponseWithXml:xml];
}

#pragma mark - destroy methods

- (void) dealloc {
    self.headProps = nil;
    self.serviceUrl = nil;
    [super dealloc];
}

@end
