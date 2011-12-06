//
//  SPUpdateItemRequest.m
//  SP
//
//  Created by spark pan on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPUpdateItemRequest.h"



@implementation SPUpdateItemRequest 

@synthesize taskInfo, listName;


#pragma mark - public methods
+ (SPUpdateItemRequest *) soapRequest {
    SPUpdateItemRequest * result = [[SPUpdateItemRequest alloc] init];
    return [result autorelease];
}


#pragma mark - overridden protected methods 

- (void) write:(XMLWriter *)writer {
    [super write:writer];
    
    [writer writeStartElement:@"UpdateListItems"];
    [writer writeElement:@"listName" withStringValue:[self listName]];
    
    [writer writeStartElement:@"updates"];
    [writer writeStartElement:@"Batch"];
    [writer writeAttribute:@"OnError" value:@"Continue"];
    [writer writeAttribute:@"ListVersion" value:@"1"];
    
    [writer writeStartElement:@"Method"];
    [writer writeAttribute:@"ID" value:@"1"];
    [writer writeAttribute:@"Cmd" value:@"Update"];
       
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"ID"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"Title"];
    [writer writeCharacters:[taskInfo title]];
    [writer writeEndElement];
    
    /**
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"Body"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"PercentComplete"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"Status"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"AssignedTo"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"StartDate"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"DueDate"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    
    [writer writeStartElement:@"Field"];
    [writer writeAttribute:@"Name" value:@"Priority"];
    [writer writeCharacters:@"1"];
    [writer writeEndElement];
    */
    [writer writeEndElement];
    [writer writeEndElement];
    [writer writeEndElement];
    [writer writeEndElement];
    [writer writeEndElement];
    
    NSLog(@"%@", writer.toString);
    
}
- (void) dealloc {
    [listName release];
    [taskInfo release];
    [super dealloc];
}

@end
