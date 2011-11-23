//
//  SPCachedData.m
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPCachedData.h"
#import "SPCommon.h"

static SPCachedData * sharedInstance;

@interface SPCachedData()

+ (NSString *) stringIfNotEmpty:(NSString *)value defaultIfEmpty:(NSString *)defaultValue;

@end

@implementation SPCachedData

@synthesize user, pwd;

@synthesize userInputSite, serviceUrlPrefix, serviceHost, serviceHostUrl, serviceRelativePath;

#pragma public methods

+ (SPCachedData *) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[SPCachedData alloc] init];
    }
    return sharedInstance;
}

#pragma mark - authentication related

+ (void) fillCredentialWithUser:(NSString *)user password:(NSString *)pwd {
    SPCachedData * data = [self sharedInstance];
    data.user = user;
    data.pwd = pwd;
}

+ (NSURLCredential *) credential {
    SPCachedData * data = [self sharedInstance];
    if (!data.user || !data.pwd) {
        data.user = @"Perficient\\spark.pan";
        data.pwd = @"zhe@812Bl";
    }
    return [NSURLCredential credentialWithUser:data.user password:data.pwd persistence:NSURLCredentialPersistenceNone];
}

#pragma mark - site url related

// Precondition: the siteUrl has been verified as a valid URL
+ (void) fillSiteInfo:(NSString *)siteUrl {
    SPCachedData * sharedInstance = [self sharedInstance];
    sharedInstance.userInputSite = siteUrl;
    
    NSString * site = siteUrl;
    NSURL * url = [NSURL URLWithString:site];
    NSString * host = [url host];
    // E.g. take "sharepoint.perficient.com" from "https://sharepoint.perficient.com/sites/SP"
    sharedInstance.serviceHost = host; 
    // E.g. take "sites/SP" from "https://sharepoint.perficient.com/sites/SP"
    sharedInstance.serviceRelativePath = [[url relativePath] substringFromIndex:1];
    NSRange range = [site rangeOfString:host];
    // E.g. take "https://sharepoint.perficient.com" from "https://sharepoint.perficient.com/sites/SP" and add the trailing "/"
    sharedInstance.serviceHostUrl = [[site substringToIndex:(range.location + range.length)] stringByAppendingString:@"/"];
       
    // add the trailing "/" for the url if necessary
    if (![site hasSuffix:@"/"]) {
        site = [site stringByAppendingString:@"/"];
    }
    // add the service suffix if necessary
    if (![site hasSuffix:@"_vti_bin/"]) {
        site = [site stringByAppendingString:@"_vti_bin/"];
    }
    // E.g. convert "https://sharepoint.perficient.com/sites/SP" to "https://sharepoint.perficient.com/sites/SP/_vti_bin/"
    sharedInstance.serviceUrlPrefix = [site stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@, %@", [url relativePath], [url relativeString]);
}

+ (NSString *) userInputSite {
    return [self stringIfNotEmpty:[self sharedInstance].userInputSite defaultIfEmpty:@"https://sharepoint.perficient.com/sites/SP"]; 
}

+ (NSString *) serviceUrlPrefix {
    return [self stringIfNotEmpty:[self sharedInstance].serviceUrlPrefix defaultIfEmpty:@"https://sharepoint.perficient.com/sites/SP/_vti_bin/"];
}

+ (NSString *) serviceHost {
    return [self stringIfNotEmpty:[self sharedInstance].serviceHost defaultIfEmpty:@"sharepoint.perficient.com"];
}

+ (NSString *) serviceHostUrl {
    return [self stringIfNotEmpty:[self sharedInstance].serviceHostUrl defaultIfEmpty:@"https://sharepoint.perficient.com/"];
}

+ (NSString *) serviceRelativePath {
    return [self stringIfNotEmpty:[self sharedInstance].serviceRelativePath defaultIfEmpty:@"sites/SP"];
}

#pragma mark - private methods

+ (NSString *) stringIfNotEmpty:(NSString *)value defaultIfEmpty:(NSString *)defaultValue {
    if (IS_EMPTY_STRING(value)) {
        return defaultValue;
    }
    return value;
}

#pragma destroy methods 

- (void) dealloc {
    self.user = nil;
    self.pwd = nil;
    self.userInputSite = nil;
    self.serviceHostUrl = nil;
    self.serviceUrlPrefix = nil;
    self.serviceHost = nil;
    self.serviceRelativePath = nil;
    [super dealloc];
}

@end
