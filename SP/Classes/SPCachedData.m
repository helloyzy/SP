//
//  SPCachedData.m
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPCachedData.h"
#import "SPCommon.h"
#import "SPCoreDataUtil.h"
#import "SPSettings.h"
#import "NSManagedObject+SPExtensions.h"

static SPCachedData * sharedInstance;

@interface SPCachedData()

+ (NSString *) stringIfNotEmpty:(NSString *)value defaultIfEmpty:(NSString *)defaultValue;
+ (void) translateSiteUrl:(NSString *)siteUrl;

@end

@implementation SPCachedData

@synthesize settings;

@synthesize serviceUrlPrefix, serviceHost, serviceHostUrl, serviceRelativePath;

#pragma public methods

+ (SPCachedData *) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[SPCachedData alloc] init];
    }
    return sharedInstance;
}

+ (void) loadSettings {
    SPSettings * settings = [SPCoreDataUtil settingsInfo];
    [self sharedInstance].settings = settings;
    [self translateSiteUrl:settings.siteUrl];
}

#pragma mark - authentication related

+ (void) fillCredentialWithUser:(NSString *)user password:(NSString *)pwd {
    SPCachedData * data = [self sharedInstance];
    data.settings.userName = user;
    data.settings.password = pwd;
    [data.settings save];
}

+ (NSURLCredential *) credential {
    SPCachedData * data = [self sharedInstance];
    return [NSURLCredential credentialWithUser:data.settings.userName password:data.settings.password persistence:NSURLCredentialPersistenceNone];
}

#pragma mark - site url related

// Precondition: the siteUrl has been verified as a valid URL
+ (void) fillSiteInfo:(NSString *)siteUrl {
    [self sharedInstance].settings.siteUrl = siteUrl;
    [[self sharedInstance].settings save];
    [self translateSiteUrl:siteUrl];
}

+ (void) translateSiteUrl:(NSString *)siteUrl {
    SPCachedData * sharedInstance = [self sharedInstance];

    NSString * site = siteUrl;
    NSURL * url = [NSURL URLWithString:site];
    NSString * host = [url host];
    // E.g. take "sharepoint.perficient.com" from "https://sharepoint.perficient.com/sites/SP"
    sharedInstance.serviceHost = host; 
    // E.g. take "sites/SP" from "https://sharepoint.perficient.com/sites/SP"
    NSString * relativePath = [url relativePath];
    if (relativePath && relativePath.length > 0) {
        sharedInstance.serviceRelativePath = [[url relativePath] substringFromIndex:1];
    } else {
        sharedInstance.serviceRelativePath = @"";
    }
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
}

+ (NSString *) userInputSite {
    return [self sharedInstance].settings.siteUrl;
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
    self.serviceHostUrl = nil;
    self.serviceUrlPrefix = nil;
    self.serviceHost = nil;
    self.serviceRelativePath = nil;
    self.settings = nil;
    [super dealloc];
}

@end
