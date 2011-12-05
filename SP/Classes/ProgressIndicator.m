//
//  ProgressIndicator.m
//  SP
//
//  Created by Jack Yang on 12/2/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import "ProgressIndicator.h"
#import "MBProgressHUD.h"

static MBProgressHUD * viewProgressIndicator;

@implementation ProgressIndicator

#pragma mark - class initialization

/**
+ (void) initialize {
    
}
*/

+ (void) showInView:(UIView *)view withMsg:(NSString *)msg {
    [self hide:NO];
    viewProgressIndicator = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:viewProgressIndicator];
    viewProgressIndicator.labelText = msg;
    viewProgressIndicator.detailsLabelText = @"Please wait...";
    viewProgressIndicator.dimBackground = YES;
    [viewProgressIndicator show:YES];
}

+ (void) show:(NSString *)msg {
    UIWindow * mainWindow = [[UIApplication sharedApplication] keyWindow];
    [self showInView:mainWindow withMsg:msg];
}

+ (void) hide {
    [self hide:YES];
}

+ (void) hide:(BOOL)animated {
    if (viewProgressIndicator && ![viewProgressIndicator isHidden]) {
        [viewProgressIndicator hide:animated];
        [viewProgressIndicator removeFromSuperview];
        [viewProgressIndicator release];
        viewProgressIndicator = nil;
    }
}



@end
