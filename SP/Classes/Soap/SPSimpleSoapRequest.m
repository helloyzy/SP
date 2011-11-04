//
//  SPSimpleSoapRequest.m
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPSimpleSoapRequest.h"
#import "SPConst.h"

@interface SPSimpleSoapRequest ()

@property (nonatomic, retain) NSMutableDictionary * elementsAndValues;

@end

@implementation SPSimpleSoapRequest

@synthesize rootTagName;
@synthesize elementsAndValues;

#pragma mark - public methods

+ (SPSimpleSoapRequest *) soapRequest {
    SPSimpleSoapRequest * result = [[SPSimpleSoapRequest alloc] init];
    return [result autorelease];
}

-(void) addElement:(NSString *)tagName withStringValue:(NSString *)value {
    if (!elementsAndValues) {
        self.elementsAndValues = [NSMutableDictionary dictionary];
    }
    [elementsAndValues setObject:value forKey:tagName];
}

#pragma mark - overridden protected methods 

- (void) write:(XMLWriter *)writer {
    [writer setDefaultNamespace:SP_SOAP_NS_DEFAULT];
    [writer writeStartElement:rootTagName];
    // add child elements if any
    if (elementsAndValues) {
        for (NSString * tagName in elementsAndValues.keyEnumerator) {
            [writer writeElement:tagName withStringValue:[elementsAndValues objectForKey:tagName]];
        }
    }
    [writer writeEndElement];
}

#pragma mark - destroy methods

- (void) dealloc {
    self.rootTagName = nil;
    self.elementsAndValues = nil;
    [super dealloc];
}

@end
