//
//  ReachabilityMgr.m
//  SP
//
//  Created by Whitman Yang on 12/9/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import "ReachabilityMgr.h"
#import "NSObject+SPExtensions.h"
#import "ReachabilityEx.h"
#import "SPCachedData.h"

static ReachabilityMgr * sharedInstance;

@interface ReachabilityMgr() {
    ReachabilityEx * _reach;
    BOOL _initialized; 
}

@property (nonatomic, retain) ReachabilityEx * reach;
@property (nonatomic, assign) BOOL initialized;

- (void) monitorHostActivity;
- (void) hostChanged:(NSNotification *)notification;

@end

@implementation ReachabilityMgr

@synthesize reach = _reach;
@synthesize initialized = _initialized;

#pragma mark - public

+ (void) initReachabiliity {
    sharedInstance = [[ReachabilityMgr alloc] init];
    [sharedInstance registerNotification:SP_NOTIFICATION_SITESETTINGS_CHANGED withSelector:@selector(hostChanged:)];
    [sharedInstance monitorHostActivity];
}

+ (BOOL) isNetworkAvailable {
    // not initialized, the status is not trustable
    if (sharedInstance.initialized) {
        return [sharedInstance.reach isReachable]; 
    }
    // just return YES for untrustable status
    return YES;
}

#pragma mark - private

- (void) hostChanged:(NSNotification *)notification {
    [self monitorHostActivity];
}

- (void) monitorHostActivity {
    self.initialized = NO;
    self.reach = [ReachabilityEx reachabilityWithHostname:[SPCachedData serviceHost]];    
    self.reach.reachableBlock = ^(ReachabilityEx * reachability)
    {
        self.initialized = YES;
        [self postNotification:SP_NOTIFICATION_NETWORK_NORMAL withValue:nil];
    };
    
    self.reach.unreachableBlock = ^(ReachabilityEx * reachability)
    {
        self.initialized = YES;
        [self postNotification:SP_NOTIFICATION_NETWORK_DISCONNECTED withValue:nil];
    };
    [self.reach startNotifier];
}

#pragma mark - destroy

- (void) dealloc {
    [self unregisterNotification];
    self.reach = nil;
}

@end
