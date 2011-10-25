//
//  CoreDataCoreDataStore.m
//  iBoost
//
//  iBoost - The iOS Booster!
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "CoreDataStore.h"
#import "Macros.h"

// global Core Data objects
static NSManagedObjectModel *gManagedObjectModel;
static NSPersistentStoreCoordinator *gPersistentStoreCoordinator;

// main thread singleton
static CoreDataStore *gMainStoreInstance;

@interface CoreDataStore ()

- (void)createManagedObjectContext;

@end

@implementation CoreDataStore

+ (CoreDataStore *)mainStore {
	@synchronized (self) {
		if (!gMainStoreInstance) {
			gMainStoreInstance = [[CoreDataStore alloc] init];
		}
	}
	
	return gMainStoreInstance;
}

+ (CoreDataStore *)createStore {
	return [[[CoreDataStore alloc] init] autorelease];
}

+ (void)initialize {
	NSError *error = nil;

	// create the global managed object model
	gManagedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    

	// create the global persistent store
    gPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:gManagedObjectModel];
	
	NSString *storeLocation = [DOCUMENTS_DIR stringByAppendingPathComponent:@"CoreDataStore.sqlite"];
	NSURL *storeURL = [NSURL fileURLWithPath:storeLocation];
	
	if (![gPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		NSLog(@"Error creating persistantStoreCoordinator: %@, %@", error, [error userInfo]);
		abort();
    }    
}

- (id)init {
	if ((self = [super init])) {
		[self createManagedObjectContext];
	}
	
	return self;
}
				 
- (void)dealloc {
    [_managedObjectContext release];
    
	[super dealloc];
}

#pragma mark -

- (NSManagedObjectContext *)context {
	return _managedObjectContext;
}

- (void)clearAllData {
	NSError *error = nil;
	
	// clear existing stack
	SAFE_RELEASE(gManagedObjectModel);
	SAFE_RELEASE(gPersistentStoreCoordinator);
	SAFE_RELEASE(_managedObjectContext);
	
	// remove persistence file
	NSString *storeLocation = [DOCUMENTS_DIR stringByAppendingPathComponent:@"CoreDataStore.sqlite"];
	NSURL *storeURL = [NSURL fileURLWithPath:storeLocation];
	
	// remove
	@try {
		[[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error];
	} @catch (NSException *exception) {
		// ignore, totally normal
	}
	
	// init again
	[CoreDataStore initialize];
	[self createManagedObjectContext];
}

/**
 Save the context.
 */
- (void)save { 
	NSError *error = nil;
	
	if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
		NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
		
		if(detailedErrors != nil && [detailedErrors count] > 0) {
			for(NSError* detailedError in detailedErrors) {
				NSLog(@"  DetailedError: %@", [detailedError userInfo]);
			}
		}
		else {
			NSLog(@"  %@", [error userInfo]);
		}
		
		abort();
	} 
}

#pragma mark - Deprecated Accessors (Use NSManagedObject+iBoost)

- (NSArray *)allForEntity:(NSString *)entityName error:(NSError **)error {
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	// entity
	[request setEntity:[self entityDescriptionForEntity:entityName]];
	
	// execute
	NSArray *ret = [_managedObjectContext executeFetchRequest:request error:error];

	return ret;
}

- (NSArray *)allForEntity:(NSString *)entityName predicate:(NSPredicate *)predicate error:(NSError **)error {
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	// entity
	[request setEntity:[self entityDescriptionForEntity:entityName]];
	[request setPredicate:predicate];
	
	// execute
	return [_managedObjectContext executeFetchRequest:request error:error];
}

- (NSArray *)allForEntity:(NSString *)entityName predicate:(NSPredicate *)predicate orderBy:(NSString *)key ascending:(BOOL)ascending error:(NSError **)error {
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key ascending:ascending] autorelease];
	
	// entity
	[request setEntity:[self entityDescriptionForEntity:entityName]];
	[request setPredicate:predicate];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	
	// execute
	return [_managedObjectContext executeFetchRequest:request error:error];
}

- (NSArray *)allForEntity:(NSString *)entityName orderBy:(NSString *)key ascending:(BOOL)ascending error:(NSError **)error {
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key ascending:ascending] autorelease];
	
	// entity
	[request setEntity:[self entityDescriptionForEntity:entityName]];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	 
	// execute
	return [_managedObjectContext executeFetchRequest:request error:error];
}

- (NSManagedObject *)entityByName:(NSString *)entityName error:(NSError **)error {
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	// entity
	[request setEntity:[self entityDescriptionForEntity:entityName]];
	
	// execute
	NSArray *values = [_managedObjectContext executeFetchRequest:request error:error];
	
	if (values.count > 0) {
		// this method is designed for accessing a single object, but if there's more just give the first
		return (NSManagedObject *)[values objectAtIndex:0];
	}
	
	return nil;
}

- (NSManagedObject *)entityByName:(NSString *)entityName key:(NSString *)key value:(NSObject *)value error:(NSError **)error {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", key, value];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setPredicate:predicate];
	 
	// entity
	[request setEntity:[self entityDescriptionForEntity:entityName]];
	
	// execute
	NSArray *values = [_managedObjectContext executeFetchRequest:request error:error];
	
	if (values.count > 0) {
		// this method is designed for accessing a single object, but if there's more just give the first
		return (NSManagedObject *)[values objectAtIndex:0];
	}
	
	return nil;
}

- (NSManagedObject *)entityByURI:(NSURL *)uri {
	NSManagedObjectID *oid = [gPersistentStoreCoordinator managedObjectIDForURIRepresentation:uri]; 

    return [self entityByObjectID:oid];
}

- (NSManagedObject *)entityByObjectID:(NSManagedObjectID *)oid {
	if (oid) {
		return [_managedObjectContext objectWithID:oid];
	}
    
	return nil;    
}

- (NSManagedObject *)createNewEntityByName:(NSString *)entityName {
	return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext]; 
}

- (void)removeEntity:(NSManagedObject *)entity {
	@try {
		[_managedObjectContext deleteObject:entity];
	} @catch(id exception) {}
}

/* Remove all objects of an entity. */
- (void)removeAllEntitiesByName:(NSString *)entityName {
	NSError *error = nil;
	
	// get all objects for entity
	// TODO: we can fetch these in a more minimalistic way, would be faster, so do it if we have time
	NSArray *objects = [self allForEntity:entityName error:&error];
	
	for (NSManagedObject *iObject in objects) {
		[_managedObjectContext deleteObject:iObject];
	}
}

- (NSEntityDescription *)entityDescriptionForEntity:(NSString *)entityName {
	return [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
}

#pragma mark -

- (void)createManagedObjectContext {
	_managedObjectContext = [[NSManagedObjectContext alloc] init];
	[_managedObjectContext setPersistentStoreCoordinator:gPersistentStoreCoordinator];
}

@end
