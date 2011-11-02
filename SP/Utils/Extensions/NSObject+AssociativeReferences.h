//
//  NSObject+AssociativeReferences.h
//  SP
//
//  Created by Whitman Yang on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociativeReferences)

// Remember to call removeAssociatedObject: in dealloc or when in a proper timing, else it will cause memory leak
- (void) associateRetainedObject:(id)objToRetain withKey:(char *)key;

- (id) associatedObject:(char *)key;

- (void) removeAssociatedObject:(char *)key;
- (void) removeAllAssociatedObject;

@end
