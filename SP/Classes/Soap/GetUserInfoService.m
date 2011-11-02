//
//  GetUserInfoService.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetUserInfoService.h"
#import "GetUserInfo.h"
#import "SoapUtil.h"
#import "SoapEnveloper.h"
#import "RXMLElement.h"

@implementation GetUserInfoService

@synthesize userInfo;

#pragma mark - default implementations for protected methods

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper {
    if (userInfo) {
        [enveloper write:userInfo];
        NSURLRequest * request = [SoapUtil buildRequestWithUrl:@"https://sharepoint.perficient.com/sites/gdc/_vti_bin/UserGroup.asmx" soapMsg:enveloper headProps:nil];
        return request;
    } else {
        return nil;
    }
}

- (id) parseResponse:(NSString *)responseString {
    RXMLElement * rxml = [RXMLElement elementFromXMLString:responseString];
    RXMLElement * userEle = [rxml child:@"soap:Body.GetUserInfoResponse.GetUserInfoResult.GetUserInfo.User"];
    NSLog(@"%@", [userEle attribute:@"LoginName"]);
    return userEle;
}

- (void) sendNotificationOnSuccess:(id)value {
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"UserInfo" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:value, @"value", nil]];
}

#pragma mark - destroy methods

- (void) dealloc {
    self.userInfo = nil;
    [super dealloc];
}

@end
