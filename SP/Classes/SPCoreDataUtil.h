//
//  SPCoreDataUtil.h
//  SP
//
//  Created by Jack Yang on 11/28/11.
//  Copyright 2011 Per. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSettings, SPListItem;

@interface SPCoreDataUtil : NSObject

+ (void) initCoreDataEnv;
+ (id) firstInstanceByEntityClass:(Class)entityClass;
+ (id) firstInstanceByEntityClass:(Class)entityClass key:(NSString *)key value:(NSObject *)value;
+ (id) createInstanceFromEntityClass:(Class)entityClass;
+ (id) createInstanceFromEntityClass:(Class)entityClass autoSaveFlag:(BOOL)saveFlag;
+ (NSArray *) allByEntityClass:(Class)entityClass;
+ (NSArray *) allByEntityClass:(Class)entityClass key:(NSString *)key value:(NSObject *)value;
+ (NSArray *) allByEntityClass:(Class)entityClass filter:(NSPredicate *)filter;
+ (void)removeAllByEntityClass:(Class)entityClass;

// settings related methods
+ (SPSettings *) settingsInfo;

// lists related methods;
+ (SPListItem *) createListItem;
+ (void) removeTopLevelLists;
+ (NSArray *) topLevelLists;


@end
