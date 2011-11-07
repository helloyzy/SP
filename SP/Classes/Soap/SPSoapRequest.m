//
//  SPSoapRequest.m
//  SP
//
//  Created by Whitman Yang on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPSoapRequest.h"
#import "SPConst.h"

@implementation SPSoapRequest

#pragma mark - overridden protected methods 

- (void) write:(XMLWriter *)writer {
    [writer setDefaultNamespace:SP_SOAP_NS_DEFAULT];
}

@end
