//
//  GetListItemsService.m
//  SP
//
//  Created by spark pan on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetListItemsService.h"
#import "ListInfo.h"
#import "NSObject+SPExtensions.h"

@implementation GetListItemsService


- (void) prepareUrlAndHeadProps {
    // self.serviceUrl = SP_SOAP_URL_LISTS;
    [self buildServiceUrlWithName:SP_SOAP_URL_LISTS];
    [self addSoapActionHeadProp:@"GetListItems"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    NSMutableArray * listOfItems = [NSMutableArray array];
    [xml iterate:@"soap:Body.GetListItemsResponse.GetListItemsResult.listitems.rs:data.z:row" with:^(RXMLElement * listEle) {
        
        ListInfo * list = [[ListInfo alloc] init];
        NSString * fileName = [listEle attribute:@"ows_LinkFilename"];
        list.title = fileName;
        
        if (!fileName) {
            list.title = [listEle attribute:@"ows_LinkTitle"];
            list.assignTo = [listEle attribute:@"ows_AssignedTo"];
            list.status= [listEle attribute:@"ows_Status"];
            list.priority = [listEle attribute:@"ows_Priority"];
            list.dueDate  = [listEle attribute:@"ows_DueDate"];
            list.percentComplete   = [listEle attribute:@"ows_PercentComplete"];     
            list.listItemID = [listEle attribute:@"ows_ID"];
        }
        
        NSString* fileType = [listEle attribute:@"ows_FSObjType"];
        list.type = [[fileType componentsSeparatedByString:@"#"] objectAtIndex:1];
        
        NSString * fileRef = [listEle attribute:@"ows_FileRef"];
        list.fileRef = [[fileRef componentsSeparatedByString:@"#"] objectAtIndex:1];
                
        [listOfItems addObject:list];
        [list release];
    }];
    return listOfItems;
}

- (void) sendNotificationOnSuccess:(id)value {
    [self postNotification:SP_NOTIFICATION_GETLISTITEMS_SUCCESS withValue:value];
}

- (void) sendNotificationOnFailure:(id)errorInfo {
    [self postNotification:SP_NOTIFICATION_GETLISTITEMS_FAILURE withValue:errorInfo];
}

- (void) dealloc {
    [super dealloc];
}
@end
