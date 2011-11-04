//
//  SoapRequest.m
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapRequest.h"

@implementation XMLWriter (Extentions) 

- (void) writeElement:(NSString *)tagName withStringValue:(NSString *)value {
    [self writeStartElement:tagName];
    [self writeCharacters:value];
    [self writeEndElement];
}

@end

@implementation SoapRequest

- (void) write:(XMLWriter *)writer {
    
}

@end
