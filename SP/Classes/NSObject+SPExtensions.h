//
//  NSObject+SPExtensions.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SPExtensions)

- (void) postNotification:(NSString *)msgName withValue:(id)value;

@end
