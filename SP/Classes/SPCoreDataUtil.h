//
//  SPCoreDataUtil.h
//  SP
//
//  Created by Jack Yang on 11/28/11.
//  Copyright 2011 Per. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSettings;

@interface SPCoreDataUtil : NSObject

+ (void) initCoreDataEnv;
+ (id) firstInstanceByEntityClass:(Class)entityClass;
+ (id) firstInstanceByEntityClass:(Class)entityClass key:(NSString *)key value:(NSObject *)value;
+ (id) createInstanceFromEntityClass:(Class)entityClass;
+ (NSArray *) allByEntityClass:(Class)entityClass;
+ (NSArray *) allByEntityClass:(Class)entityClass key:(NSString *)key value:(NSObject *)value;

// settings related methods
+ (SPSettings *) settingsInfo;

@end
