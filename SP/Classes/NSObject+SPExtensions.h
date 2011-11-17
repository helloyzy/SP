//
//  NSObject+SPExtensions.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SPExtensions)

// section for notification related ----------
- (void) postNotification:(NSString *)msgName withValue:(id)value;

- (void) registerNotification:(NSString *)msgName withSelector:(SEL)selector;

- (void) unregisterNotification;

- (void) unregisterNotification:(NSString *)msgName;

- (id) valueFromSPNotification:(NSNotification *)notification;
// section for notification related ----------

@end
