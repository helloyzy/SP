//
//  GetListCollectionService.m
//  SP
//
//  Created by spark pan on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetListCollectionService.h"
#import "SoapUtil.h"
#import "SoapEnveloper.h"
#import "ListInfo.h"
#import "GDataXMLNode.h"
#import "RXMLElement.h"
#import "SPCachedData.h"
#import "SPListItem.h"
#import "SPCoreDataUtil.h"
#import "NSManagedObject+SPExtensions.h"
#import "NSObject+SPExtensions.h"

@implementation GetListCollectionService 


#pragma mark - protected methods implementations

- (void) prepareUrlAndHeadProps {
    // self.serviceUrl = SP_SOAP_URL_LISTS;
    [self buildServiceUrlWithName:SP_SOAP_URL_LISTS];    
    [self addSoapActionHeadProp:@"GetListCollection"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    // remove all the top-level list items from data store
    [SPCoreDataUtil removeTopLevelLists];
    NSMutableArray * listOfItems = [NSMutableArray array];
    [xml iterate:@"soap:Body.GetListCollectionResponse.GetListCollectionResult.Lists.List" with:^(RXMLElement * listEle) {
        ListInfo * list = [[ListInfo alloc] init];
        list.title = [listEle attribute:@"Title"];
        list.listName =[listEle attribute:@"Name"];
        list.fileRef = [NSString stringWithFormat:@"%@/%@", [SPCachedData serviceRelativePath], list.title];
        list.listDescription = [listEle attribute:@"Description"];
        
        
        NSString *hidden=[listEle attribute:@"Hidden"];
        if([ hidden caseInsensitiveCompare:@"False"] == NSOrderedSame) {
            [listOfItems addObject:list];
            SPListItem * listItem = [SPCoreDataUtil createListItem];
            listItem.title = list.title;
            listItem.listName = list.listName;
            listItem.fileRef = list.fileRef;
            listItem.listDescription = list.description;
            [listItem save];
        }
        
        [list release];
        
        
    }];
    return listOfItems;
}

- (void) sendNotificationOnSuccess:(id)value {
    [self postNotification:SP_NOTIFICATION_GETLISTCOLLECTION_SUCCESS withValue:value];
}

- (void) sendNotificationOnFailure:(id)errorInfo {
    [self postNotification:SP_NOTIFICATION_GETLISTCOLLECTION_FAILURE withValue:errorInfo];
}


- (void) dealloc {
    [super dealloc];
}

@end
