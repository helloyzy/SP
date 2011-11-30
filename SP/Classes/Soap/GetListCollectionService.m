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

@implementation GetListCollectionService 

@synthesize delegate;

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
        list.listName = list.title;
        list.fileRef = [NSString stringWithFormat:@"%@/%@", [SPCachedData serviceRelativePath], list.title];
        list.description = [listEle attribute:@"Description"];
        
        
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
    //Is anyone listening
    if([delegate respondsToSelector:@selector(dataSourceReturn:)]) {
        //send the delegate function with the amount entered by the user
        [delegate dataSourceReturn:value];
    }
}

- (void) dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
