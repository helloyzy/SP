//
//  NSArray+Boost.h
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

#import <Foundation/Foundation.h>
#import "Types.h"

@interface NSArray (Boost)

- (NSArray *)sortedArrayAsDiacriticInsensitiveCaseInsensitive;
- (NSArray *)sortedArrayAsDiacriticInsensitive;
- (NSArray *)sortedArrayAsCaseInsensitive;
- (NSArray *)sortedArray;

- (NSArray *)reversedArray;
- (NSArray *)shuffledArray;

- (id)firstObject;

- (NSArray *)map:(ib_enum_id_t)blk;

@end
