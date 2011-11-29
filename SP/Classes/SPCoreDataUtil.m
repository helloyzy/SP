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
    CoreDataStore * mainStore = [CoreDataStore mainStore];
    NSManagedObject * result = [mainStore createNewEntityByName:NSStringFromClass(entityClass)];
    [mainStore save];
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

#pragma mark - setting related methods

+ (SPSettings *) settingsInfo {
    Class classInfo = [SPSettings class];
    SPSettings * settings = [self firstInstanceByEntityClass:classInfo];
    if (!settings) {
        settings = [self createInstanceFromEntityClass:classInfo];
    }
    return settings;
}

@end
