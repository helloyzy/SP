//
//  SPCachedData.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSettings;

@interface SPCachedData : NSObject

@property (nonatomic, retain) SPSettings * settings;

@property (nonatomic, retain) NSString * serviceUrlPrefix;
@property (nonatomic, retain) NSString * serviceHost;
@property (nonatomic, retain) NSString * serviceHostUrl;
@property (nonatomic, retain) NSString * serviceRelativePath;

+ (SPCachedData *) sharedInstance;
+ (void) loadSettings;
// current login credential for all the SP services
+ (NSURLCredential *) credential;
+ (void) fillCredentialWithUser:(NSString *)user password:(NSString *)pwd;

+ (void) fillSiteInfo:(NSString *)siteUrl;

+ (NSString *) userInputSite; // site url the user input in the authentication form
// E.g. "https://sharepoint.perficient.com/sites/SP/_vti_bin/" from "https://sharepoint.perficient.com/sites/SP"
+ (NSString *) serviceUrlPrefix;
// E.g. "sharepoint.perficient.com" from "https://sharepoint.perficient.com/sites/SP"
+ (NSString *) serviceHost;
// E.g. "sites/SP" from "https://sharepoint.perficient.com/sites/SP"
+ (NSString *) serviceRelativePath;
// E.g. "https://sharepoint.perficient.com/" from "https://sharepoint.perficient.com/sites/SP"
+ (NSString *) serviceHostUrl;

@end
