//
//  ReachabilityMgr.h
//  SP
//
//  Created by Whitman Yang on 12/9/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachabilityMgr : NSObject

+ (BOOL) isNetworkAvailable;
+ (BOOL) isNetworkAvailableForUrl:(NSString *)urlStr;
+ (void) initReachabiliity;

@end
