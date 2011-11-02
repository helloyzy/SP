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

@implementation GetListCollectionService 

@synthesize listInfo;
@synthesize listOfItems;
@synthesize delegate;

#pragma mark - protected methods implementations

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper {
    if (listInfo) {
        [enveloper write:listInfo];
        NSDictionary * headProps = [NSDictionary dictionaryWithObjectsAndKeys:@"http://schemas.microsoft.com/sharepoint/soap/GetListCollection", @"SOAPAction", nil];
        NSURLRequest * request = [SoapUtil buildRequestWithUrl:@"https://sharepoint.perficient.com/sites/gdc/_vti_bin/Lists.asmx" soapMsg:enveloper headProps:headProps];
        return request;
    } else {
        return nil;
    }
}

- (id) parseResponse:(NSString *)responseString {    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];    
    NSDictionary *ns = [NSDictionary dictionaryWithObjectsAndKeys:@"http://schemas.microsoft.com/sharepoint/soap/", @"sp", nil];    
    
    static NSString *kXPath_Item = @"//sp:GetListCollectionResponse/sp:GetListCollectionResult/sp:Lists/sp:List";    
    NSArray *listsData = [doc nodesForXPath:kXPath_Item namespaces:ns error:nil];    
    NSLog(@"%d", [listsData count]);    
    self.listOfItems = [NSMutableArray array];
    
    for (GDataXMLElement *item in listsData) {
        ListInfo *listItem = [[ListInfo alloc] init];
        listItem.title = [[[item attributes] objectAtIndex:4] stringValue];
        listItem.description = [[[item attributes] objectAtIndex:5] stringValue];
        
        [listOfItems addObject:listItem];
    }
    NSLog(@"%@", listOfItems);
    [doc release];
    return listOfItems;
}

- (void) sendNotificationOnSuccess:(id)value {
    //Is anyone listening
    if([delegate respondsToSelector:@selector(dataSourceReturn:)])
    {
        //send the delegate function with the amount entered by the user
        [delegate dataSourceReturn:value];
    }
}

- (void) dealloc {
    self.listInfo = nil;
    self.listOfItems = nil;
    [super dealloc];
}
@end
