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

@interface ReachabilityCheck : NSObject {
    @private
    NSCondition * _condition;
}

@property (nonatomic, retain) NSCondition * condition;

@end

@implementation ReachabilityCheck

@synthesize condition = _condition;

- (id) init {
    if (self = [super init]) {
        _condition = [[NSCondition alloc] init];
    }
    return self;
}

- (void) dealloc {
    self.condition = nil;
    [super dealloc];
}

@end

@interface ReachabilityMgr() {
    ReachabilityEx * _reach;
    BOOL _initialized; 
}

@property (nonatomic, retain) ReachabilityEx * reach;
@property (nonatomic, assign) BOOL initialized;

- (void) monitorHostActivity;
- (void) monitorNetworkActivity;
- (void) hostChanged:(NSNotification *)notification;

@end

@implementation ReachabilityMgr

@synthesize reach = _reach;
@synthesize initialized = _initialized;

#pragma mark - init

- (id) init {
    return [super init];
}

#pragma mark - public

+ (void) initReachabiliity {
    sharedInstance = [[ReachabilityMgr alloc] init];
    // [sharedInstance registerNotification:SP_NOTIFICATION_SITESETTINGS_CHANGED withSelector:@selector(hostChanged:)];
    [sharedInstance monitorNetworkActivity];
}

+ (BOOL) isNetworkAvailable {
    // not initialized, the status is not trustable
    if (sharedInstance.initialized) {
        return [sharedInstance.reach isReachable]; 
    }
    // just return YES for untrustable status
    return YES;
}

+ (BOOL) isNetworkAvailableForUrl:(NSString *)urlStr {
    NSURL * url = [NSURL URLWithString:urlStr];
    NSString * host = [url host];
    ReachabilityCheck * reachCheck = [[ReachabilityCheck alloc] init];
    ReachabilityEx * reachEx = [ReachabilityEx reachabilityWithHostname:host];
    reachEx.reachableBlock = ^ (ReachabilityEx * instance) {
        [reachCheck.condition lock];
        [reachCheck.condition signal];
        [reachCheck.condition unlock];
    };
    reachEx.unreachableBlock = ^ (ReachabilityEx * instance) {
        [reachCheck.condition lock];
        [reachCheck.condition signal];
        [reachCheck.condition unlock];
    };
    
    // wait until waken up by the ReachabilityEx
    [reachCheck.condition lock];
    [reachEx startNotifier];
    [reachCheck.condition wait];
    [reachCheck.condition unlock];
    
    [reachEx stopNotifier];
    [reachCheck release];
    return [reachEx isReachable];
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

- (void) monitorNetworkActivity {
    self.initialized = NO;
    self.reach = [ReachabilityEx reachabilityForInternetConnection];    
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
    [super dealloc];
}

@end
