//
//  UIViewController+SPExtensions.m
//  SP
//
//  Created by Jack Yang on 12/4/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import "UIViewController+SPExtensions.h"
#import "ProgressIndicator.h"

@implementation UIViewController (SPExtensions)

- (void) showProgressIndicator:(NSString *)msg {
    [ProgressIndicator showInView:self.view withMsg:msg];
}

- (void) hideProgressIndicator {
    [ProgressIndicator hide:YES];
}

@end
