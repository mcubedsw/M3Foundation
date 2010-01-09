/*****************************************************************
 M3Date.h
 M3Extensions
 
 Created by Martin Pilkington on 06/04/2008.
 
 Copyright (c) 2006-2009 M Cubed Software
 
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

#import <Foundation/Foundation.h>


/**
 @class M3Date
 @discussion An NSCalendarDate subclass that improves on the natural language processing and provides some useful extras. 
 
 Some examples of the new capabilites for natural language dates include:
 
 - 6 in the morning
 - last night
 - 3 years ago
 - 5 months before now
 - 7 hours before tomorrow at noon
 
 These are called through the standard + (id)dateWithNaturalLanguageString:(NSString *)string method from NSDate.
 */
@interface M3Date : NSCalendarDate {

}


/**
 @abstract Returns an M3Date a set number of days after the supplied date
 @param days The number of days to add
 @param start The date to start from
 @result A newly initialised NSCalendarDate object set to the specified number of days after the start date
 */
+ (id)dateByAddingDays:(NSInteger)days toDate:(NSDate *)start;

/**
 @abstract Works out if the supplied year is a leap year
 @param year The year to test
 @result True if the supplied year is a leap year
 */
+ (BOOL)isLeapYear:(NSInteger)year;

/**
 @abstract Returns an range of dates between which the supplied natural language string refers to
 @param string The natural language string
 @result And NSDictionary with two keys. M3StartDate is the M3Date object marking the start of the range, M3EndDate is the M3Date object marking the end of the range
 */
+ (NSDictionary *)dateRangeWithNaturalLanguageString:(NSString *)string;


@end
