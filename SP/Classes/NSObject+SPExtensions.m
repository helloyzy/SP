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

- (void) postNotification:(NSString *)msgName withValue:(id)value {
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:msgName object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:value, SP_NOTIFICATION_KEY_USERINFO, nil]];
}

@end
