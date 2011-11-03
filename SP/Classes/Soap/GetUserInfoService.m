//
//  GetUserInfoService.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetUserInfoService.h"
#import "NSObject+SPExtensions.h"

@implementation GetUserInfoService

#pragma mark - protected methods implementations
 
- (void) prepareUrlAndHeadProps {
    self.serviceUrl = SP_SOAP_URL_GETUSERINFO;
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    RXMLElement * userEle = [xml child:@"soap:Body.GetUserInfoResponse.GetUserInfoResult.GetUserInfo.User"];
    return userEle;
}

- (void) sendNotificationOnSuccess:(id)value {
    [self postNotification:SP_NOTIFICATION_GETUSERINFO_SUCCESS withValue:value];
}

#pragma mark - destroy methods

- (void) dealloc {
    [super dealloc];
}

@end
