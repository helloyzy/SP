//
//  NSObject+AssociativeReferences.m
//  SP
//
//  Created by Whitman Yang on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObject+AssociativeReferences.h"
#import <objc/runtime.h>

@implementation NSObject (AssociativeReferences)

- (void) associateRetainedObject:(id)objToRetain withKey:(char *)key {
    objc_setAssociatedObject(self, key, objToRetain, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id) associatedObject:(char *)key {
    return objc_getAssociatedObject(self, key);
}

- (void) removeAssociatedObject:(char *)key {
    // since we set the value to nil, the policy here does not make sense
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

- (void) removeAllAssociatedObject {
    objc_removeAssociatedObjects(self);
}

@end
