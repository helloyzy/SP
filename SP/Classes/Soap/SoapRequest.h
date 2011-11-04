//
//  SoapRequest.h
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLSerializable.h"
#import "XMLWriter.h"

@interface XMLWriter (Extentions) 

- (void) writeElement:(NSString *)tagName withStringValue:(NSString *)value;

@end

@interface SoapRequest : NSObject <XMLSerializable>

@end
