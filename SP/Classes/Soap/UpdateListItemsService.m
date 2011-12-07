//
//  UpdateListItemsService.m
//  SP
//
//  Created by spark pan on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UpdateListItemsService.h"
#import "NSObject+SPExtensions.h"

@implementation UpdateListItemsService

- (void) prepareUrlAndHeadProps {
    // self.serviceUrl = SP_SOAP_URL_LISTS;
    [self buildServiceUrlWithName:SP_SOAP_URL_LISTS];
    [self addSoapActionHeadProp:@"UpdateListItems"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    NSMutableArray * listOfItems = [NSMutableArray arrayWithObjects:@"T1",@"T2", nil];
    return listOfItems;
}

- (void) sendNotificationOnSuccess:(id)value {
    [self postNotification:SP_NOTIFICATION_UPDATEITEM_SUCCESS withValue:value];
}

- (void) sendNotificationOnFailure:(id)errorInfo {
    [self postNotification:SP_NOTIFICATION_UPDATEITEM_FAILURE withValue:errorInfo];
}
- (void) dealloc {
    [super dealloc];
}
@end
