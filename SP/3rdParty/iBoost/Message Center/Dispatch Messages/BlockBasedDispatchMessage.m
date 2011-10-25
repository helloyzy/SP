//
//  BlockBasedDispatchMessage.m
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

#import "BlockBasedDispatchMessage.h"

@implementation BlockBasedDispatchMessage

+ (id)messageWithName:(NSString *)name isAsynchronous:(BOOL)isAsync input:(void (^)(NSData *))inputBlock output:(NSData * (^)(void))outputBlock {
    BlockBasedDispatchMessage *msg = [[BlockBasedDispatchMessage alloc] initWithName:name userInfo:nil];
    msg.asynchronous = isAsync;
    
    msg->inputBlock_ = Block_copy(inputBlock);
    msg->outputBlock_ = Block_copy(outputBlock);
    
    return [msg autorelease];
}

- (void)dealloc {
    Block_release(inputBlock_);
    Block_release(outputBlock_);

    [super dealloc];
}

- (void)inputData:(NSData *)input {
    inputBlock_(input);
}

- (NSData *)outputData {
    return outputBlock_();    
}

@end
