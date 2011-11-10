//
//  SPAppDelegate.h
//  SP
//
//  Created by Whitman Yang on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class FirstDetailViewController;

@interface SPAppDelegate : NSObject <UIApplicationDelegate> {
    UIView * window;
    UISplitViewController *splitViewController;
    FirstDetailViewController *firstDetailViewController;
    RootViewController * rootViewController;
    UITabBarController * tabBarController;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet FirstDetailViewController *firstDetailViewController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
