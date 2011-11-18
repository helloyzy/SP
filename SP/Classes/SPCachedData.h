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
@property (nonatomic, retain) NSString * serviceUrlPrefix;
@property (nonatomic, retain) NSString * serviceHost;

+ (SPCachedData *) sharedInstance;
// current login credential for all the SP services
+ (NSURLCredential *) credential;
+ (NSString *) serviceUrlPrefix;
+ (NSString *) serviceHost;

@end
