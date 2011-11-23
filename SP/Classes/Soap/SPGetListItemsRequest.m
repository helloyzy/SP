//
//  SPComplexSoapRequest.m
//  SP
//
//  Created by spark pan on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPGetListItemsRequest.h"
#import "SPCachedData.h"

@implementation SPGetListItemsRequest

@synthesize listName,folderName;

#pragma mark - public methods
+ (SPGetListItemsRequest *) soapRequest {
    SPGetListItemsRequest * result = [[SPGetListItemsRequest alloc] init];
    return [result autorelease];
}


#pragma mark - overridden protected methods 

- (void) write:(XMLWriter *)writer {
    [super write:writer];
   
    [writer writeStartElement:@"GetListItems"];
    [writer writeElement:@"listName" withStringValue:[self listName]];
    
    [writer writeStartElement:@"queryOptions"];
    [writer writeStartElement:@"QueryOptions"];
    [writer writeElement:@"IncludeMandatoryColumns" withStringValue:@"TRUE"];
    [writer writeElement:@"DateInUtc" withStringValue:@"TRUE"];
    [writer writeElement:@"Folder" withStringValue:[[SPCachedData serviceHostUrl] stringByAppendingString:[self folderName]]];
    [writer writeEndElement];
    [writer writeEndElement];
      
    [writer writeEndElement];
    
    NSLog(@"%@", writer.toString);
   
}
- (void) dealloc {
    [listName release];
    [super dealloc];
}


@end
