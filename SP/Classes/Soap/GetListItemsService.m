//
//  GetListItemsService.m
//  SP
//
//  Created by spark pan on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetListItemsService.h"
#import "ListInfo.h"

@implementation GetListItemsService

@synthesize delegate;

- (void) prepareUrlAndHeadProps {
    self.serviceUrl = SP_SOAP_URL_LISTS;
    [self addSoapActionHeadProp:@"GetListItems"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    NSMutableArray * listOfItems = [NSMutableArray array];
    [xml iterate:@"soap:Body.GetListItemsResponse.GetListItemsResult.listitems.rs:data.z:row" with:^(RXMLElement * listEle) {
       
        ListInfo * list = [[ListInfo alloc] init];
        list.title = [listEle attribute:@"ows_LinkFilename"];
        //list.description = [listEle attribute:@"Description"];
        [listOfItems addObject:list];
        [list release];
    }];
    return listOfItems;
}

- (void) sendNotificationOnSuccess:(id)value {
    //Is anyone listening
    if([delegate respondsToSelector:@selector(ListsReturn:)]) {
        //send the delegate function with the amount entered by the user
        [delegate ListsReturn:value];
    }
}

- (void) dealloc {
    [super dealloc];
}
@end
