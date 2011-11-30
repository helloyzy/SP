//
//  SPCoreDataUtil.m
//  SP
//
//  Created by Jack Yang on 11/28/11.
//  Copyright 2011 Per. All rights reserved.
//

#import "SPCoreDataUtil.h"
#import "CoreDataStore.h"
#import "SPSettings.h"
#import "UTLDebug.h"
#import "NSManagedObject+SPExtensions.h"
#import "SPListItem.h"

@interface SPCoreDataUtil()

@end

@implementation SPCoreDataUtil

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark - public methods

/**
 * This method must be called before any other method could be used
 */
+ (void) initCoreDataEnv {
    // [[CoreDataStore mainStore] clearAllData];
    [CoreDataStore initCoreDataEnv];
}

+ (id) firstInstanceByEntityClass:(Class)entityClass {
    return [self firstInstanceByEntityClass:entityClass key:nil value:nil];
}

+ (id) firstInstanceByEntityClass:(Class)entityClass key:(NSString *)key value:(NSObject *)value {
    NSArray * instances = [self allByEntityClass:entityClass key:key value:value];
    if ([instances count] > 0) {
        return [instances objectAtIndex:0];
    } else {
        return nil;
    }
}

+ (id) createInstanceFromEntityClass:(Class)entityClass {
    return [self createInstanceFromEntityClass:entityClass autoSaveFlag:NO];
}


+ (id) createInstanceFromEntityClass:(Class)entityClass autoSaveFlag:(BOOL)saveFlag {
    CoreDataStore * mainStore = [CoreDataStore mainStore];
    NSManagedObject * result = [mainStore createNewEntityByName:NSStringFromClass(entityClass)];
    if (saveFlag) {
        [mainStore save];
    }
    return result;
}

+ (NSArray *) allByEntityClass:(Class)entityClass {
    return [self allByEntityClass:entityClass key:nil value:nil];
}

+ (NSArray *) allByEntityClass:(Class)entityClass key:(NSString *)key value:(NSObject *)value {
    CoreDataStore * mainStore = [CoreDataStore mainStore];
    NSError * error = nil;
    NSString * entityName = NSStringFromClass(entityClass);
    NSArray * result = nil;
    if (key && value) {
        UTLLog(@"Loading instances of %@, filter is %@ == %@.", entityName, key, value);
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"%K == %@", key, value];
        result = [mainStore allForEntity:entityName predicate:predicate error:&error];
    } else {
        UTLLog(@"Loading instances of %@.", entityName);
        result = [mainStore allForEntity:entityName error:&error];
    }
    if (error) {
        UTLLog(@"Failed to load %@ instances:%@", entityName, [error description]);
        return nil;
    }
    return result;
}

+ (NSArray *) allByEntityClass:(Class)entityClass filter:(NSPredicate *)filter {
    CoreDataStore * mainStore = [CoreDataStore mainStore];
    NSError * error = nil;
    NSString * entityName = NSStringFromClass(entityClass);
    NSArray * result = nil;
    UTLLog(@"Loading instances of %@, filter is %@", entityName, filter);
    result = [mainStore allForEntity:entityName predicate:filter error:&error];
    if (error) {
        UTLLog(@"Failed to load %@ instances:%@", entityName, [error description]);
        return nil;
    }
    return result;
}

+ (void)removeAllByEntityClass:(Class)entityClass {
    CoreDataStore * mainStore = [CoreDataStore mainStore];
    [mainStore removeAllEntitiesByName:NSStringFromClass(entityClass)];
}


#pragma mark - setting related methods

+ (SPSettings *) settingsInfo {
    Class classInfo = [SPSettings class];
    SPSettings * settings = [self firstInstanceByEntityClass:classInfo];
    if (!settings) {
        settings = [self createInstanceFromEntityClass:classInfo];
        settings.userName = @"Perficient\\spark.pan";
        settings.password = @"zhe@812Bl";
        settings.siteUrl = @"https://sharepoint.perficient.com/sites/SP";
        [settings save];
    }
    return settings;
}


#pragma mark - list related methods

+ (void) removeTopLevelLists {
    NSArray * topLevelLists = [self topLevelLists];
    for (SPListItem * topListItem in topLevelLists) {
        [topListItem remove];
        UTLLog(@"The list item to be deleted:%@", topListItem);
    }
    [[CoreDataStore mainStore] save];
}

+ (NSArray *) topLevelLists {
    /**
    NSPredicate * filter = [NSPredicate predicateWithFormat:@"%K == %@", @"parentItem", [NSNull null]];
    NSArray * result = [self allByEntityClass:[SPListItem class] filter:filter];
     */    
    
    NSArray * result = [self allByEntityClass:[SPListItem class] key:@"parentItem" value:[NSNull null]];
    return result;
}

+ (SPListItem *) createListItem {
    Class classInfo = [SPListItem class];
    return [self createInstanceFromEntityClass:classInfo];
}

@end
