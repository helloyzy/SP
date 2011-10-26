//
//  SoapEnveloper.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLSerializable.h"

@interface SoapEnveloper : NSObject

- (id) initWithNamespaces:(NSDictionary *)namespaces;
- (void) write:(id<XMLSerializable>)entity;
- (NSString *) toString;

@end
