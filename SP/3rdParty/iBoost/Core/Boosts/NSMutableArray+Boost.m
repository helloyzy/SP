//
//  NSMutableArray+Boost.m
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

#import "NSMutableArray+Boost.h"
#import "NSString+Boost.h"

// no-ops
static const void* IBRetainNoOp(CFAllocatorRef allocator, const void *value) { return value; }
static void IBReleaseNoOp(CFAllocatorRef allocator, const void *value) { }

@implementation NSMutableArray (Boost)

+ (NSMutableArray *)arrayUnretaining {
	CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
	callbacks.retain = IBRetainNoOp;
	callbacks.release = IBReleaseNoOp;
	return [(NSMutableArray*)CFArrayCreateMutable(nil, 0, &callbacks) autorelease];
}

- (void)sortDiacriticInsensitiveCaseInsensitive {
	[self sortUsingSelector:@selector(diacriticInsensitiveCaseInsensitiveSort:)];
}

- (void)sortDiacriticInsensitive {
	[self sortUsingSelector:@selector(diacriticInsensitiveSort:)];
}

- (void)sortCaseInsensitive {
	[self sortUsingSelector:@selector(caseInsensitiveSort:)];
}

#pragma mark -

- (void)pushObject:(id)obj {
    [self addObject:obj];
}

- (id)popObject {
    id pop = [[self lastObject] retain];
    [self removeLastObject];

    return [pop autorelease];
}

- (id)shiftObject {
    if (self.count > 0) {
        id shft = [[self objectAtIndex:0] retain];
        [self removeObjectAtIndex:0];
        return [shft autorelease];
    }

    return nil;
}

- (void)unshiftObject:(id)obj {
    [self insertObject:obj atIndex:0];
}

#pragma mark -

- (void)deleteIf:(ib_enum_bool_t)blk {
    for (NSInteger i = (self.count - 1); i >= 0; --i) {
        if (blk([self objectAtIndex:i])) {
            [self removeObjectAtIndex:i];
        }
    }
}

#pragma mark -

- (void)shuffle {
    // shuffle it 3 times because 3 is magical
    for (NSInteger times=0; times < 3; ++times) {
        for (NSInteger i=self.count - 1; i >= 0; --i) {
            NSInteger fromIndex = arc4random() % self.count;
            NSInteger toIndex = arc4random() % self.count;
            
            [self exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
        }
    }
}

- (void)reverse {
    for (NSInteger i=0, j=self.count - 1; i < j; ++i, --j) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
}

@end
