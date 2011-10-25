//
//  DispatchMessage.m
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

#import "DispatchMessage.h"
#import "MessageCenter.h"

@implementation DispatchMessage

@synthesize asynchronous = asynchronous_;
@synthesize name = name_;
@synthesize userInfo = userInfo_;

- (id)init {
	self = [super init];
	
	if (self) {
		name_ = nil;
		userInfo_ = nil;
		asynchronous_ = NO;
	}
	
	return self;
}

- (id)initWithName:(NSString *)name userInfo:(NSDictionary *)userInfo {
	self = [super init];

	if (self) {
		name_ = [name copy];
		userInfo_ = [userInfo mutableCopy];
	}
	
	return self;
}

- (id)initWithName:(NSString *)name andObjectsAndKeys:(id)firstObject, ... {
	self = [super init];
    
	if (self) {
        // construct user info
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        id currentObject = nil;
        id currentKey = nil;
        va_list argList;
        
        if (firstObject) {
            va_start(argList, firstObject);
            currentObject = firstObject;
            
            do {
                currentKey = va_arg(argList, id);
                [userInfo setObject:currentObject forKey:currentKey];
            } while ((currentObject = va_arg(argList, id)));
            
            va_end(argList);        
        }
        
		name_ = [name copy];
        userInfo_ = [userInfo mutableCopy];
	}
	
	return self;    
}

+ (id)messageWithName:(NSString *)name andObjectsAndKeys:(id)firstObject, ... {
    // construct user info
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    id currentObject = nil;
    id currentKey = nil;
    va_list argList;
    
    if (firstObject) {
        va_start(argList, firstObject);
        currentObject = firstObject;
        
        do {
            currentKey = va_arg(argList, id);
            [userInfo setObject:currentObject forKey:currentKey];
        } while ((currentObject = va_arg(argList, id)));
        
        va_end(argList);        
    }
    
	DispatchMessage *message = [[DispatchMessage alloc] initWithName:name userInfo:userInfo];
    
    va_end(argList);
    
	// autorelease
	return [message autorelease];
}

+ (id)messageWithName:(NSString *)name userInfo:(NSDictionary *)userInfo {
	DispatchMessage *message = [[DispatchMessage alloc] initWithName:name userInfo:userInfo];

	// autorelease
	return [message autorelease];
}

- (void)dealloc {
	[name_ release];
	[userInfo_ release];
	[super dealloc];
}

#pragma mark -

- (void)setUserInfo:(NSDictionary *)userInfo {
    NSDictionary *value = [userInfo copy];
    [userInfo_ release];
    userInfo_ = value;
}

#pragma mark -

- (void)inputData:(NSData *)input {
	// input and do nothing
}

- (NSData *)outputData {
	// output nothing
	return nil;
}

@end
