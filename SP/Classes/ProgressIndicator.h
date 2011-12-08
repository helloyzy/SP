//
//  ProgressIndicator.h
//  SP
//
//  Created by Jack Yang on 12/2/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;
@protocol MBProgressHUDDelegate;

@interface ProgressIndicator : NSObject

+ (MBProgressHUD *) sharedIndicator;
+ (void) showInView:(UIView *)view withMsg:(NSString *)msg withDetailedMsg:(NSString *)detailedMsg;
+ (void) show:(NSString *)msg;
+ (void) hide;
+ (void) hide:(BOOL)animated;
+ (void) switchToCustomViewModes:(NSString *)msg;
+ (void) switchToNormalViewModes:(NSString *)msg;

+ (void) assignDelegate:(id<MBProgressHUDDelegate>)delegate;
+ (void) unassignDelegate;

@end
