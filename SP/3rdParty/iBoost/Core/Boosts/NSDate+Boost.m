//
//  NSDate+Boost.m
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

#import "NSDate+Boost.h"
#import <time.h>
#import "Constants.h"

@implementation NSDate (Boost)

- (NSInteger)utcYear {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = gmtime(&rawTime);
	return time->tm_year + 1900;
}

- (NSInteger)utcMonth {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = gmtime(&rawTime);
	return time->tm_mon + 1;
}

- (NSInteger)utcDay {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = gmtime(&rawTime);
	return time->tm_mday;
}

- (NSInteger)utcHour {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = gmtime(&rawTime);
	return time->tm_hour;
}

- (NSInteger)utcMinute {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = gmtime(&rawTime);
	return time->tm_min;
}

- (NSInteger)utcSecond {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = gmtime(&rawTime);
	return time->tm_sec;
}

- (NSInteger)year {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = localtime(&rawTime);
	return time->tm_year + 1900;
}

- (NSInteger)month {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = localtime(&rawTime);
	return time->tm_mon + 1;
}

- (NSInteger)day {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = localtime(&rawTime);
	return time->tm_mday;
}

- (NSInteger)hour {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = localtime(&rawTime);
	return time->tm_hour;
}

- (NSInteger)minute {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = localtime(&rawTime);
	return time->tm_min;
}

- (NSInteger)second {
	time_t rawTime = [self timeIntervalSince1970];
	struct tm *time = localtime(&rawTime);
	return time->tm_sec;
}

- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle {
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateStyle:dateStyle];
	[format setTimeStyle:NSDateFormatterNoStyle];
	[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	
	return [format stringFromDate:self];
}

- (NSString *)formattedUTCTimeStyle:(NSDateFormatterStyle)timeStyle {
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateStyle:NSDateFormatterNoStyle];
	[format setTimeStyle:timeStyle];
	[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	
	return [format stringFromDate:self];
}

- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateStyle:dateStyle];
	[format setTimeStyle:timeStyle];
	[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	
	return [format stringFromDate:self];
}

- (NSString *)formattedUTCDatePattern:(NSString *)datePattern {
	//
	// format document: http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns
	//
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateFormat:datePattern];
	[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	
	return [format stringFromDate:self];
}

- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle {
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateStyle:dateStyle];
	[format setTimeStyle:NSDateFormatterNoStyle];
	
	return [format stringFromDate:self];
}

- (NSString *)formattedTimeStyle:(NSDateFormatterStyle)timeStyle {
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateStyle:NSDateFormatterNoStyle];
	[format setTimeStyle:timeStyle];

	return [format stringFromDate:self];
}

- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateStyle:dateStyle];
	[format setTimeStyle:timeStyle];
	
	return [format stringFromDate:self];
}

- (NSString *)formattedDatePattern:(NSString *)datePattern {
	//
	// format document: http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns
	//
	NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
	[format setDateFormat:datePattern];
	
	return [format stringFromDate:self];
}

- (NSDate *)dateAsMidnight {
	return [NSDate dateWithTimeIntervalSince1970:((long)[self timeIntervalSince1970] / (long)SECONDS_IN_DAY * (long)SECONDS_IN_DAY)];
}
@end

