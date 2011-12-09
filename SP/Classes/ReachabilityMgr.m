//
//  ReachabilityMgr.m
//  SP
//
//  Created by Jack Yang on 12/9/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import "ReachabilityMgr.h"
#import "NSObject+SPExtensions.h"

static ReachabilityMgr * sharedInstance;

@interface ReachabilityMgr() 

// + (void) monitorHostActivity;

@end

@implementation ReachabilityMgr

+ (void) initialize {
    sharedInstance = [[ReachabilityMgr alloc] init];
}



@end
