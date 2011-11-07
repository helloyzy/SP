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
@synthesize serviceHost;

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
    return [NSURLCredential credentialWithUser:data.user password:data.pwd persistence:NSURLCredentialPersistenceNone];
}

+ (NSString *) serviceHost {
    NSString * result = [self sharedInstance].serviceHost;
    if(!result) {
        result = @"sharepoint.perficient.com";
    }
    return result;
}

#pragma destroy methods 

- (void) dealloc {
    self.user = nil;
    self.pwd = nil;
    self.serviceHost = nil;
    [super dealloc];
}

@end
