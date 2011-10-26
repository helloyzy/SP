//
//  SequencedMessage.m
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

#import "SequencedMessage.h"


@implementation SequencedMessage

- (id)initWithName:(NSString *)name userInfo:(NSDictionary *)userInfo sequence:(NSArray *)messageSequence {
	self = [super initWithName:name userInfo:userInfo];
	
	if (self) {
		_messageSequence = [messageSequence mutableCopy];

		// if any message in the sequence is asynchronous, the whole thing is asynchronous
		for (DispatchMessage *iMessage in _messageSequence) {
			if (iMessage.isAsynchronous) {
				self.asynchronous = YES;
				break;
			}
		}
	}
	
	return self;
}

+ (id)messageWithName:(NSString *)name userInfo:(NSDictionary *)userInfo sequence:(NSArray *)messageSequence {
	SequencedMessage *message = [[SequencedMessage alloc] initWithName:name userInfo:userInfo sequence:messageSequence];
	
	// autorelease
	return [message autorelease];
}

- (void)dealloc {
	[_messageSequence release];
    [_outputOfLastMessage release];
	[super dealloc];
}

#pragma mark -

- (void)inputData:(NSData *)input {
	_outputOfLastMessage = nil;
	
	// process each message in sequence
	for (DispatchMessage *iMessage in _messageSequence) {
		// process
		[iMessage inputData:_outputOfLastMessage];
		
		// release
		[_outputOfLastMessage release];
		
		// gather output
		_outputOfLastMessage = [[iMessage outputData] retain];
	}
}

- (NSData *)outputData {
	// this is the output of the last message we processed in inputData
	return _outputOfLastMessage;
}

@end
