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

@implementation GetUserInfoService

@synthesize userInfo;

- (void) request {
    if (userInfo) {
        SoapEnveloper * soapEnveloper = [[SoapEnveloper alloc] init];
        [soapEnveloper write:userInfo];
        NSURLRequest * request = [SoapUtil buildRequestWithUrl:@"https://sharepoint.perficient.com/sites/gdc/_vti_bin/UserGroup.asmx" soapMsg:soapEnveloper headProps:nil];
        [soapEnveloper release];
        [self sendSoapRequest:request];
    }
}

- (void) dealloc {
    self.userInfo = nil;
    [super dealloc];
}

@end
