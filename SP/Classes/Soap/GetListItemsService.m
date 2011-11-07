//
//  GetListItemsService.m
//  SP
//
//  Created by spark pan on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetListItemsService.h"


@implementation GetListItemsService

@synthesize delegate;
- (void) prepareUrlAndHeadProps {
    self.serviceUrl = SP_SOAP_URL_LISTS;
    [self addSoapActionHeadProp:@"GetListCollection"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    NSMutableArray * listOfItems = [NSMutableArray array];
    [xml iterate:@"soap:Body.GetListItemsResponse.GetListItemsResult.listitems.data.row" with:^(RXMLElement * listEle) {
        [listOfItems addObject:[listEle attribute:@"ows_LinkFilename"]];
    }];
    return listOfItems;
}

- (void) sendNotificationOnSuccess:(id)value {
    //Is anyone listening
    if([delegate respondsToSelector:@selector(ListItemsDelegate:)]) {
        //send the delegate function with the amount entered by the user
        [delegate ListItemsDelegate:value];
    }
}

- (void) dealloc {
    [super dealloc];
}
@end
