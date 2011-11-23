//
//  SPCommon.m
//  SP
//
//  Created by Jack Yang on 11/23/11.
//  Copyright 2011 Per. All rights reserved.
//

#import "SPCommon.h"
#import "UTLDebug.h"

@implementation SPCommon

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark - site related functions

+ (BOOL) isValidSite:(NSString *)siteUrl {
    if ([siteUrl hasPrefix:@"http://"] || [siteUrl hasPrefix:@"https://"]) {
        NSURL * url = [NSURL URLWithString:siteUrl];
        NSString * host = [url host];
        UTLLog(@"Host from site %@ is:%@", siteUrl, host);
        if (IS_POPULATED_STRING(host)) {
            return YES;
        }
    }
    return NO;
}

@end
