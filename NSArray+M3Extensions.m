/*****************************************************************
NSArray+M3Extensions.m
M3Extensions

Created by Martin Pilkington on 10/09/2006.

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

#import "NSArray+M3Extensions.h"


@implementation NSArray (M3Extensions)

+ (NSArray *)m3_alphaNumericArray {
	return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", 
		@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", 
		@"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
}

+ (NSArray *)m3_arrayWithNumbersTo:(NSInteger)maxValue from:(NSInteger)minValue {
	if (maxValue == minValue)
		return nil;
	
	NSMutableArray *returnArray = [NSMutableArray array];
	NSInteger i;
	//loop through the number sequence adding them to our array
	if (maxValue > minValue) {
		for (i = minValue; i <= maxValue; i++) {
			[returnArray addObject:[NSNumber numberWithInteger:i]];
		}
	} else {
		for (i = minValue; i >= maxValue; i--) {
			[returnArray addObject:[NSNumber numberWithInteger:i]];
		}
	}
	return [returnArray copy];
}

@end