//
//  SPCachedData.m
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPCachedData.h"

static SPCachedData * sharedInstance;

@implementation SPCachedData

@synthesize user;
@synthesize pwd;

#pragma public methods

+ (SPCachedData *) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[SPCachedData alloc] init];
    }
    return sharedInstance;
}

+ (NSURLCredential *) credential {
    SPCachedData * data = [self sharedInstance];
    if (!data.user || !data.pwd) {
        data.user = @"Perficient\\spark.pan";
        data.pwd = @"zhe@812Bl";
    }
    return [NSURLCredential credentialWithUser:data.user password:data.pwd persistence:NSURLCredentialPersistenceForSession];
}

#pragma destroy methods 

- (void) dealloc {
    self.user = nil;
    self.pwd = nil;
    [super dealloc];
}

@end
