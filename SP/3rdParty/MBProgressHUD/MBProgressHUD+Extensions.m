//
//  MBProgressHUD+Extensions.m
//  SP
//
//  Created by Whitman Yang on 12/2/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import "MBProgressHUD+Extensions.h"

@implementation MBProgressHUD (Extensions)

#pragma mark - confirmation using MBProgressHUD

/**
 * internal use
 */
+ (void)hideAndReleaseMBProgressHUD:(MBProgressHUD *)HUD {    
    [HUD hide:YES];
    [HUD removeFromSuperview];
    [HUD release];
}

+ (void) showConfirmationMsg:(NSString *)msg withDelegate:(id<MBProgressHUDDelegate>)delegate {
    UIWindow * mainWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithWindow:mainWindow];
	[mainWindow addSubview:HUD];
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]] autorelease];	
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = msg;
	HUD.dimBackground = YES;
    if (delegate) {
        HUD.delegate = delegate;
    }
	[HUD show:YES];
    [self performSelector:@selector(hideAndReleaseMBProgressHUD:)  withObject:HUD afterDelay:2];
}

@end
