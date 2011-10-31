//
//  SoapEnveloper.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapEnveloper.h"
#import "XMLWriter.h"
#import "Macros.h"

@interface SoapEnveloper () 

- (void) writeSoapHead;
- (void) writeSoapTail;

@end

static NSString *const NS_XSI_PREFIX = @"xsi";
static NSString *const NS_XSI = @"http://www.w3.org/2001/XMLSchema-instance";
static NSString *const NS_XSD_PREFIX = @"xsd";
static NSString *const NS_XSD = @"http://www.w3.org/2001/XMLSchema";
static NSString *const NS_SOAP_PREFIX = @"soap";
static NSString *const NS_SOAP = @"http://schemas.xmlsoap.org/soap/envelope/";

@implementation SoapEnveloper

#pragma mark - init methods

- (id) init {
    return [self initWithNamespaces:nil];
}

- (id) initWithNamespaces:(NSDictionary *)namespaces {
    self = [super init];
    if (self) {
        writer = [[XMLWriter alloc] init];
        if (namespaces) {
            for (NSString * prefix in [namespaces keyEnumerator]) {
                [writer setPrefix:prefix namespaceURI:[namespaces objectForKey:prefix]];
            }
        }
        [self writeSoapHead];
    }
    return self;
}

#pragma mark - public methods
            
- (void) write:(id<XMLSerializable>)entity {
    [entity write:writer];
}

- (NSString *) toString {
    [self writeSoapTail];
    return [writer toString];
}
            
#pragma mark - private methods

- (void) writeSoapHead {
    // register default namespaces
    [writer setPrefix:NS_XSI_PREFIX namespaceURI:NS_XSI];
    [writer setPrefix:NS_XSD_PREFIX namespaceURI:NS_XSD];
    [writer setPrefix:NS_SOAP_PREFIX namespaceURI:NS_SOAP];
    [writer writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
    [writer writeStartElementWithNamespace:NS_SOAP localName:@"Envelope"];
    [writer writeStartElementWithNamespace:NS_SOAP localName:@"Body"];
    // write ">" for "<Body" so that the following content can register other namespaces;
    [writer writeCloseStartElement];
}

- (void) writeSoapTail {
    [writer writeEndDocument];
}

#pragma mark - destory methods

- (void) dealloc {
    SAFE_RELEASE(writer);
    [super dealloc];
}

@end
