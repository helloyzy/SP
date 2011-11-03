//
//  SoapEntity.m
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapEntity.h"

@implementation SoapEntity

- (void) write:(XMLWriter *)writer {
    [writer setDefaultNamespace:@"http://schemas.microsoft.com/sharepoint/soap/directory/"];
}

- (void) writeElement:(XMLWriter *)writer tagName:(NSString *)tagName withStringValue:(NSString *)value {
    [writer writeStartElement:tagName];
    [writer writeCharacters:value];
    [writer writeEndElement];
}

@end
