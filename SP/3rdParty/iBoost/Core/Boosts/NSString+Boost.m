//
//  NSString+Boost.m
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

#import "NSString+Boost.h"


@implementation NSString (Boost)

- (NSComparisonResult)diacriticInsensitiveCaseInsensitiveSort:(NSString *)rhs {
	return [self compare:rhs options:NSDiacriticInsensitiveSearch | NSCaseInsensitiveSearch];	
}

- (NSComparisonResult)diacriticInsensitiveSort:(NSString *)rhs {
	return [self compare:rhs options:NSDiacriticInsensitiveSearch];	
}

- (NSComparisonResult)caseInsensitiveSort:(NSString *)rhs {
	return [self compare:rhs options:NSCaseInsensitiveSearch];	
}

- (NSString *)asBundlePath {
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	return [resourcePath stringByAppendingPathComponent:self];
}

- (NSString *)asDocumentsPath {
	static NSString* documentsPath = nil;

	if (!documentsPath) {
		NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		documentsPath = [[dirs objectAtIndex:0] retain];
	}
	
	return [documentsPath stringByAppendingPathComponent:self];
}

- (BOOL)contains:(NSString *)substring {
    return ([self rangeOfString:substring].location != NSNotFound);
}

- (BOOL)contains:(NSString *)substring options:(NSStringCompareOptions)options {
    return ([self rangeOfString:substring options:options].location != NSNotFound);
}

- (NSString *)trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
