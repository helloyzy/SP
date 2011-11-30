//
//  SPExtensions.m
//  SP
//
//  Created by Jack Yang on 11/28/11.
//  Copyright 2011 Per. All rights reserved.
//

#import "NSManagedObject+SPExtensions.h"
#import "CoreDataStore.h"

@implementation NSManagedObject (SPExtensions)

- (void) save {
    [[CoreDataStore mainStore] save];
}

- (void) remove {
    [self remove:NO];
}

- (void) remove:(BOOL)autoSaveFlag {
    [[CoreDataStore mainStore] removeEntity:self];
    if (autoSaveFlag) {
        [self save];
    }
}

@end
