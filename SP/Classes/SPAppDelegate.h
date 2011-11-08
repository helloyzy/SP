//
//  SPAppDelegate.h
//  SP
//
//  Created by Whitman Yang on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface SPAppDelegate : UIResponder <UIApplicationDelegate> 

@property (retain, nonatomic) IBOutlet UIWindow *window;

//@property (retain, nonatomic) SPViewController *viewController;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

@property (nonatomic, retain) UITabBarController * tabBarController;

@end
