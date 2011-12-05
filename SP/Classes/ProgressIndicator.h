//
//  ProgressIndicator.h
//  SP
//
//  Created by Jack Yang on 12/2/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressIndicator : NSObject

+ (void) showInView:(UIView *)view withMsg:(NSString *)msg;
+ (void) show:(NSString *)msg;
+ (void) hide;
+ (void) hide:(BOOL)animated;

@end
