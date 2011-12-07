//
//  GetUserCollectionFromSiteService.m
//  SP
//
//  Created by spark pan on 12/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetUserCollectionFromSiteService.h"
#import "SoapUtil.h"
#import "SoapEnveloper.h"
#import "GDataXMLNode.h"
#import "RXMLElement.h"
#import "NSManagedObject+SPExtensions.h"
#import "NSObject+SPExtensions.h"
#import "SPConst.h"
#import "UserInfo.h"


@implementation GetUserCollectionFromSiteService

#pragma mark - protected methods implementations

- (void) prepareUrlAndHeadProps {
    [self buildServiceUrlWithName:SP_SOAP_URL_GETUSERINFO];    
    [self addSoapActionHeadProp:@"directory/GetUserCollectionFromSite"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    
    NSMutableArray * usersForSite = [NSMutableArray array];
    [xml iterate:@"soap:Body.GetUserCollectionFromSiteResponse.GetUserCollectionFromSiteResult.GetUserCollectionFromSite.Users.User" with:^(RXMLElement * listEle) {
        UserInfo * userInfo = [[UserInfo alloc] init];
        userInfo.userID = [listEle attribute:@"User ID"];
        userInfo.userName = [listEle attribute:@"Name"];
        userInfo.loginName = [listEle attribute:@"LoginName"];
        userInfo.email = [listEle attribute:@"Email"];
        [usersForSite addObject:userInfo];
        [userInfo release];
                
    }];
    return usersForSite;

}

- (void) sendNotificationOnSuccess:(id)value {
    [self postNotification:SP_NOTIFICATION_GETUSERCOLLCTION__SUCCESS withValue:value];
}

- (void) sendNotificationOnFailure:(id)errorInfo {
    [self postNotification:SP_NOTIFICATION_GETUSERCOLLCTION__FAILURE withValue:errorInfo];
}


- (void) dealloc {
    [super dealloc];
}

@end
