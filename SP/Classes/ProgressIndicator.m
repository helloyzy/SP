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

@interface ProgressIndicator ()

+ (BOOL) isIndicatorVisible;
+ (BOOL) isIndicatorInSuperView:(UIView *)superView;
+ (void) switchToMode:(MBProgressHUDMode)mode withMsg:(NSString *)msg withDetailedMsg:(NSString *)detailedMsg;

@end

@implementation ProgressIndicator

#pragma mark - class initialization

/**
+ (void) initialize {
    
}
*/

+ (MBProgressHUD *) sharedIndicator {
    return viewProgressIndicator;
}

#pragma mark - show 

/**
 * show the indicator within the view, with a black background, model.
 */
+ (void) showInView:(UIView *)view withMsg:(NSString *)msg withDetailedMsg:(NSString *)detailedMsg {
    if (!view) {  // no super view to be embedded, return
        return;
    }
    if ([self isIndicatorInSuperView:view]) {
        [self switchToMode:MBProgressHUDModeIndeterminate withMsg:msg withDetailedMsg:detailedMsg];
        return;
    } 
    // hide and release
    [self hide:NO];
    viewProgressIndicator = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:viewProgressIndicator];
    viewProgressIndicator.labelText = msg;
    viewProgressIndicator.detailsLabelText = detailedMsg;
    viewProgressIndicator.dimBackground = YES;
    [viewProgressIndicator show:YES];
}

/**
 * show in main window, model.
 * @param msg - text to display in the indicator
 */
+ (void) show:(NSString *)msg {
    UIWindow * mainWindow = [[UIApplication sharedApplication] keyWindow];
    [self showInView:mainWindow withMsg:msg withDetailedMsg:@""];
}

#pragma mark - switch modes

+ (void) switchToCustomViewModes:(NSString *)msg {
    if ([self isIndicatorVisible]) {
        viewProgressIndicator.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]] autorelease];	
        [self switchToMode:MBProgressHUDModeCustomView withMsg:msg withDetailedMsg:@""];
    }
}

+ (void) switchToNormalViewModes:(NSString *)msg {
    if ([self isIndicatorVisible]) {
        [self switchToMode:MBProgressHUDModeIndeterminate withMsg:msg withDetailedMsg:@""];
    }
}

+ (void) switchToMode:(MBProgressHUDMode)mode withMsg:(NSString *)msg withDetailedMsg:(NSString *)detailedMsg {
    viewProgressIndicator.mode = mode;
    viewProgressIndicator.labelText = msg;
    viewProgressIndicator.detailsLabelText = detailedMsg;
}

#pragma mark - hide

+ (void) hide {
    [self hide:YES];
}

+ (void) hide:(BOOL)animated {
    if ([self isIndicatorVisible]) {
        [viewProgressIndicator hide:animated];
        [viewProgressIndicator removeFromSuperview];
        [viewProgressIndicator release];
        viewProgressIndicator = nil;
    }
}

#pragma mark - delegate

+ (void) assignDelegate:(id<MBProgressHUDDelegate>)delegate {
    viewProgressIndicator.delegate = delegate;
}

+ (void) unassignDelegate {
    viewProgressIndicator.delegate = nil;
}

#pragma mark - private methods

+ (BOOL) isIndicatorVisible {
    return (viewProgressIndicator && !viewProgressIndicator.isHidden);
}

+ (BOOL) isIndicatorInSuperView:(UIView *)superView {
    return (viewProgressIndicator && viewProgressIndicator.superview == superView);
}

@end
