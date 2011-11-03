//
//  SoapEntity.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLSerializable.h"
#import "XMLWriter.h"

@interface SoapEntity : NSObject <XMLSerializable>

- (void) writeElement:(XMLWriter *)writer tagName:(NSString *)tagName withStringValue:(NSString *)value;

@end
