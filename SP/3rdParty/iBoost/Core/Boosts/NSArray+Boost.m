//
//  NSArray+Boost.m
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

#import "NSArray+Boost.h"
#import "NSString+Boost.h"
#import "NSMutableArray+Boost.h"

@implementation NSArray (Boost)

- (NSArray *)sortedArrayAsDiacriticInsensitiveCaseInsensitive {
	return [self sortedArrayUsingSelector:@selector(diacriticInsensitiveCaseInsensitiveSort:)];
}

- (NSArray *)sortedArrayAsDiacriticInsensitive {
	return [self sortedArrayUsingSelector:@selector(diacriticInsensitiveSort:)];
}

- (NSArray *)sortedArrayAsCaseInsensitive {
	return [self sortedArrayUsingSelector:@selector(caseInsensitiveSort:)];
}

- (NSArray *)sortedArray {
	return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)reversedArray {
    NSMutableArray *reversedArray = [NSMutableArray arrayWithCapacity:self.count];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id iObject in enumerator) {
        [reversedArray addObject:iObject];
    }
    
    return [[reversedArray copy] autorelease];
}

- (NSArray *)shuffledArray {
    NSMutableArray *shuffledArray = [NSMutableArray arrayWithArray:self];
    
    [shuffledArray shuffle];
    
    return [[shuffledArray copy] autorelease];
}

- (id)firstObject {
    return (self.count > 0) ? [self objectAtIndex:0] : nil;
}

#pragma mark -


- (NSArray *)map:(ib_enum_id_t)blk {
    NSMutableArray *mappedArray = [NSMutableArray array];
    
    for (NSInteger i = (self.count - 1); i >= 0; --i) {
        [mappedArray unshiftObject:blk([self objectAtIndex:i])];
    }
    
    return mappedArray;
}

@end
