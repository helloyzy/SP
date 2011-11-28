//
//  SPAppDelegate.m
//  SP
//
//  Created by Whitman Yang on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPAppDelegate.h"

#import "SPViewController.h"
#import "SPAuthenticationView.h"
#import "SPCoreDataUtil.h"

@interface SPAppDelegate ()

- (void) setupTabView;
- (void) initCoreDataEnv;

@end

@implementation SPAppDelegate

@synthesize window = _window;
@synthesize splitViewController;
@synthesize tabBarController;
@synthesize rootViewController;
@synthesize firstDetailViewController;

- (void)dealloc
{
    [_window release];
    [tabBarController release];
    [splitViewController release];
    [super dealloc];
}

- (void) setupTabView {
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    SPViewController * viewController = [[[SPViewController alloc] initWithNibName:@"SPViewController" bundle:nil] autorelease];
    SPAuthenticationView * authView = [[[SPAuthenticationView alloc] initWithNibName:@"SPAuthenticationView" bundle:nil] autorelease];
    tabBarController.viewControllers = [NSArray arrayWithObjects:viewController, authView, nil];
    tabBarController.selectedIndex = 0;
    self.window.rootViewController = tabBarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[SPViewController alloc] initWithNibName:@"SPViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];*/
    
    [SPCoreDataUtil initCoreDataEnv];
    
    [self.window addSubview:splitViewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - private methods

- (void)initCoreDataEnv {
    [SPCoreDataUtil initCoreDataEnv];
}

@end
