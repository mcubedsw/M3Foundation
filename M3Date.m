/*****************************************************************
 M3Date.m
 M3Foundation
 
 Created by Martin Pilkington on 06/04/2008.
 
 Copyright © 2006-2011 M Cubed Software.
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
  
*****************************************************************/

#import "M3Date.h"

@implementation M3Date

+ (id)dateWithNaturalLanguageString:(NSString *)string {
	return [M3Date dateWithNaturalLanguageString:string locale:nil];
}

+ (id)dateWithNaturalLanguageString:(NSString *)string locale:(id)localeDictionary {
	NSArray *stringComponents = [[string lowercaseString] componentsSeparatedByString:@" "];
	//Get the index of our items so we can remove them to get the start date
	NSInteger agoIndex = [stringComponents indexOfObject:@"ago"];
	if (agoIndex == NSNotFound) {
		agoIndex = [stringComponents indexOfObject:@"before"];
	}
	NSInteger location = 0, length = [stringComponents count];
	if (agoIndex != NSNotFound) {
		if (agoIndex < ([stringComponents count] - 1)) {
			location = agoIndex + 1;
			length = [stringComponents count] - agoIndex - 1;
		}
	}
	NSInteger fromIndex = [stringComponents indexOfObject:@"from"];
	if (fromIndex != NSNotFound) {
		if (fromIndex < ([stringComponents count] - 1)) {
			location = fromIndex + 1;
			length = [stringComponents count] - fromIndex - 1;
		}
	}
	
	NSString *timeString = [[stringComponents subarrayWithRange:NSMakeRange(location, length)] componentsJoinedByString:@" "];
	NSDate *now = [NSDate dateWithNaturalLanguageString:timeString];
	if (!now) {
		now = [NSDate date];
	}
	
	
	NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:now];
	
	if ([stringComponents containsObject:@"today"] || [stringComponents containsObject:@"yesterday"] || [stringComponents containsObject:@"tomorrow"] ||
		[stringComponents containsObject:@"night"] || [stringComponents containsObject:@"evening"] || [stringComponents containsObject:@"tonight"] ||
		[stringComponents containsObject:@"morning"] || [stringComponents containsObject:@"noon"]) {
		
		[nowComponents setHour:0];
		[nowComponents setMinute:0];
		[nowComponents setSecond:0];
		if ([stringComponents containsObject:@"morning"]) {
			[nowComponents setHour:10];
		}
		if ([stringComponents containsObject:@"noon"]) {
			[nowComponents setHour:12];
		}
		if ([stringComponents containsObject:@"night"] || [stringComponents containsObject:@"evening"] || [stringComponents containsObject:@"tonight"]) {
			[nowComponents setHour:18];
		}
		
		NSDate *returnDate = [[NSCalendar currentCalendar] dateFromComponents:nowComponents];
		nowComponents = [[[NSDateComponents alloc] init] autorelease];
		if ([stringComponents containsObject:@"tomorrow"] || [stringComponents containsObject:@"next"]) {
			[nowComponents setDay:1];
		}
		if ([stringComponents containsObject:@"yesterday"] || [stringComponents containsObject:@"last"]) {
			[nowComponents setDay:-1];
		}
		return [[NSCalendar currentCalendar] dateByAddingComponents:nowComponents toDate:returnDate options:0];
	}
	
	int multiple = 0;
	NSString *period = @"";
	int number = 0;
	//Handle move past
	if (agoIndex != NSNotFound && agoIndex > 1) {
		multiple = -1;
		number = [[stringComponents objectAtIndex:agoIndex - 2] integerValue];
		period = [stringComponents objectAtIndex:agoIndex - 1];
	}
	
	//Handle move forward
	if (fromIndex != NSNotFound && agoIndex > 1) {
		multiple = 1;
		number = [[stringComponents objectAtIndex:fromIndex - 2] integerValue];
		period = [stringComponents objectAtIndex:fromIndex - 1];
	}
	
	if ([[stringComponents objectAtIndex:0] isEqualToString:@"last"]) {
		number = 1;
		multiple = -1;
		period = [stringComponents objectAtIndex:1];
	}
	if ([[stringComponents objectAtIndex:0] isEqualToString:@"next"]) {
		number = 1;
		multiple = 1;
		period = [stringComponents objectAtIndex:1];
	}
	
	
	//NSDate *returnDate = [[NSCalendar currentCalendar] dateFromComponents:nowComponents];
	
	nowComponents = [[[NSDateComponents alloc] init] autorelease];
	
	if ([period hasPrefix:@"year"]) {
		[nowComponents setYear:number * multiple];
	} else if ([period hasPrefix:@"month"]) {
		[nowComponents setMonth:number * multiple];
	} else if ([period hasPrefix:@"day"]) {
		[nowComponents setDay:number * multiple];
	} else if ([period hasPrefix:@"hour"]) {
		[nowComponents setHour:number * multiple];
	} else if ([period hasPrefix:@"minute"]) {
		[nowComponents setMinute:number * multiple];
	} else if ([period hasPrefix:@"second"]) {
		[nowComponents setSecond:number * multiple];
	} else if ([period hasPrefix:@"week"]) {
		[nowComponents setWeek:number * multiple];
	}
	
	return [[NSCalendar currentCalendar] dateByAddingComponents:nowComponents toDate:now options:0];
}


+ (NSDictionary *)dateRangeWithNaturalLanguageString:(NSString *)string {
	NSDateComponents *now = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
	
	NSInteger year = [now year];
	NSInteger month = [now month];
	NSInteger day = [now day];
	
	NSDate *startDate = [M3Date dateWithNaturalLanguageString:string locale:nil];
	NSDate *endDate = nil;
	NSDateComponents *startComponents = [[[NSDateComponents alloc] init] autorelease]; 
	NSDateComponents *endComponents = [[[NSDateComponents alloc] init] autorelease]; 
	if ([string isEqualToString:@"today"]) {
		[startComponents setYear:year];
		[startComponents setMonth:month];
		[startComponents setDay:day];
		[startComponents setHour:0];
		[startComponents setMinute:0];
		[startComponents setSecond:0];
		
		[endComponents setYear:year];
		[endComponents setMonth:month];
		[endComponents setDay:day];
		[endComponents setHour:23];
		[endComponents setMinute:59];
		[endComponents setSecond:59];
		startDate = [[NSCalendar currentCalendar] dateFromComponents:startComponents];
		endDate = [[NSCalendar currentCalendar] dateFromComponents:endComponents];
	}
	if ([string isEqualToString:@"yesterday"]) {
		[startComponents setYear:year];
		[startComponents setMonth:month];
		[startComponents setDay:day-1];
		[startComponents setHour:0];
		[startComponents setMinute:0];
		[startComponents setSecond:0];
		
		[endComponents setYear:year];
		[endComponents setMonth:month];
		[endComponents setDay:day-1];
		[endComponents setHour:23];
		[endComponents setMinute:59];
		[endComponents setSecond:59];
		startDate = [[NSCalendar currentCalendar] dateFromComponents:startComponents];
		endDate = [[NSCalendar currentCalendar] dateFromComponents:endComponents];
	}
	if ([string isEqualToString:@"tomorrow"]) {
		[startComponents setYear:year];
		[startComponents setMonth:month];
		[startComponents setDay:day+1];
		[startComponents setHour:0];
		[startComponents setMinute:0];
		[startComponents setSecond:0];
		
		[endComponents setYear:year];
		[endComponents setMonth:month];
		[endComponents setDay:day+1];
		[endComponents setHour:23];
		[endComponents setMinute:59];
		[endComponents setSecond:59];
		startDate = [[NSCalendar currentCalendar] dateFromComponents:startComponents];
		endDate = [[NSCalendar currentCalendar] dateFromComponents:endComponents];
	}
	if ([string hasPrefix:@"since"]) {
		startDate = [M3Date dateWithNaturalLanguageString:[string substringFromIndex:6] locale:nil];
		endDate = [NSDate date];
	}
	if ([string hasPrefix:@"before"]) {
		startDate = [NSDate dateWithTimeIntervalSince1970:0];
		endDate = [M3Date dateWithNaturalLanguageString:string locale:nil];
	}
	
	return [NSDictionary dictionaryWithObjectsAndKeys:startDate, @"M3StartDate", endDate, @"M3EndDate", nil];
}


+ (id)dateByAddingDays:(NSInteger)days toDate:(NSDate *)start {
	/*NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:start];
	NSInteger year = [components year];
	NSInteger month = [components month];
	NSInteger day = [components day];
	NSArray *daysInMonth = [NSArray arrayWithObjects:@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31", nil];
	day += days;
	//Deal with going backwards
	if (day < 0) {
		while (day < 1) {
			month -= 1;
			//Go to previous year
			if (month == 0) {
				month = 12;
				year -= 1;
			}
			day += [[daysInMonth objectAtIndex:month - 1] integerValue];
			//Handle leap years
			if (month == 2 && [M3Date isLeapYear:year]) {
				day += 1;
			}
		}
	} else {
		while (day > [[daysInMonth objectAtIndex:month - 1] integerValue]) {
			day -= [[daysInMonth objectAtIndex:month - 1] integerValue];
			//Handle leap years
			if (month == 2 && [M3Date isLeapYear:year]) {
				day -= 1;
			}
			month += 1;
			//Go to next year
			if (month == 13) {
				month = 1;
				year += 1;
			}
		}
	}
	return [[NSDate date] dateByAddingComponents: toDate: options:];*/
	return nil;
}

+ (BOOL)isLeapYear:(NSInteger)year {
	if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
		return YES;
	}
	return NO;
}

/*- (NSString *)descriptionWithCalendarFormat:(NSString *)formatString timeZone:(NSTimeZone *)aTimeZone locale:(id)localeDictionary {
 NSString *suffix = @"th";
 switch ([self dayOfMonth]) {
 case 1: case 21: case 31:
 suffix = @"st";
 break;
 case 2: case 22:
 suffix = @"nd";
 break;
 }
 formatString = [formatString stringByReplacingOccurrencesOfString:@"%k" withString:suffix];
 return [super descriptionWithCalendarFormat:formatString timeZone:aTimeZone locale:localeDictionary];
 }*/

@end
