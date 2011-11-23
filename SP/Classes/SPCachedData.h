//
//  SPCachedData.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCachedData : NSObject

@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSString * pwd;

@property (nonatomic, retain) NSString * userInputSite;
@property (nonatomic, retain) NSString * serviceUrlPrefix;
@property (nonatomic, retain) NSString * serviceHost;
@property (nonatomic, retain) NSString * resDownloadHost;

+ (SPCachedData *) sharedInstance;
// current login credential for all the SP services
+ (NSURLCredential *) credential;
+ (void) fillCredentialWithUser:(NSString *)user password:(NSString *)pwd;

+ (void) fillSiteInfo:(NSString *)siteUrl;
+ (NSString *) userInputSite; // site url the user input in the authentication form
+ (NSString *) serviceUrlPrefix;
+ (NSString *) serviceHost;
+ (NSString *) resDownloadHost;

@end
