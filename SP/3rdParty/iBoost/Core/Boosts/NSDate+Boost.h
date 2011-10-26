//
//  NSDate+Boost.h
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

#import <UIKit/UIKit.h>


@interface NSDate (Boost)

@property (nonatomic, readonly) NSInteger utcYear;
@property (nonatomic, readonly) NSInteger utcMonth;
@property (nonatomic, readonly) NSInteger utcDay;
@property (nonatomic, readonly) NSInteger utcHour;
@property (nonatomic, readonly) NSInteger utcMinute;
@property (nonatomic, readonly) NSInteger utcSecond;

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;

- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle;
- (NSString *)formattedTimeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedDatePattern:(NSString *)datePattern;

- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle;
- (NSString *)formattedUTCTimeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedUTCDatePattern:(NSString *)datePattern;

- (NSDate *)dateAsMidnight;

@end
