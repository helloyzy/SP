//
//  NSObject+SPExtensions.m
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObject+SPExtensions.h"
#import "SPConst.h"

@implementation NSObject (SPExtensions)

#pragma mark - notification extensions

- (void) postNotification:(NSString *)msgName withValue:(id)value {
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:msgName object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:value, SP_NOTIFICATION_KEY_USERINFO, nil]];
}

- (void) registerNotification:(NSString *)msgName withSelector:(SEL)selector {
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:selector name:msgName object:nil];
}

- (void) unregisterNotification {
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void) unregisterNotification:(NSString *)msgName {
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:msgName object:nil];
}

// retrieve the userinfo object from a given notification

- (id) valueFromSPNotification:(NSNotification *)notification {
    NSDictionary * dict = [notification userInfo];
    id result = [dict objectForKey:SP_NOTIFICATION_KEY_USERINFO];
    return result;
}

@end
