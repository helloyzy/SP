//
//  XMLSerializable.h
//
//  Created by Whitman Yang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMLWriter;

@protocol XMLSerializable <NSObject>

@required
- (void) write:(XMLWriter *)writer;

@end
