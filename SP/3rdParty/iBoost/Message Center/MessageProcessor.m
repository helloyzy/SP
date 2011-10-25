//
//  MessageProcessor.m
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

#import "MessageProcessor.h"
#import "DispatchMessage.h"

@implementation MessageProcessor

- (id)initWithMessage:(DispatchMessage *)message targetActions:(NSArray *)targetActions {
	self = [super init];
	
	if (self) {
		_message = [message retain];
		_targetActions = [targetActions copy];
	}
	
	return self;
}

- (void)dealloc {
	[_message release];
	[_targetActions release];
	[super dealloc];
}

- (void)process {
	// process
	[_message inputData:nil];
	
	// dispatch for all target/action pairs
	for (NSInteger i = _targetActions.count - 1; i >= 0; --i) {
		NSDictionary *iDictionary = (NSDictionary *)[_targetActions objectAtIndex:i];
		NSObject *iTarget = (NSObject *)[iDictionary objectForKey:@"target"];
		SEL iAction = NSSelectorFromString((NSString *)[iDictionary objectForKey:@"action"]);
		
		// perform on main thread
		if (_message.isAsynchronous) {
			[iTarget performSelectorOnMainThread:iAction withObject:_message waitUntilDone:NO];
		} else {
			[iTarget performSelector:iAction withObject:_message];			
		}
	}
}

- (void)processInThread {
}

@end
