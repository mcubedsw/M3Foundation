/*****************************************************************
 NSArray+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 10/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSArray+M3Extensions.h"

@implementation NSArray (M3Extensions)

//*****//
+ (NSArray *)m3_alphaNumericArray {
	return @[
		@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"a", @"b",
		@"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n",
		@"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"
	];
}

//*****//
+ (NSArray *)m3_arrayWithNumbersFrom:(NSInteger)aMinValue to:(NSInteger)aMaxValue {
	if (aMaxValue == aMinValue) {
		return nil;
	}
	
	NSMutableArray *returnArray = [NSMutableArray array];
	NSInteger i;
	//loop through the number sequence adding them to our array
	if (aMaxValue > aMinValue) {
		for (i = aMinValue; i <= aMaxValue; i++) {
			[returnArray addObject:[NSNumber numberWithInteger:i]];
		}
	} else {
		for (i = aMinValue; i >= aMaxValue; i--) {
			[returnArray addObject:[NSNumber numberWithInteger:i]];
		}
	}
	return [returnArray copy];
}

//*****//
- (id)m3_safeObjectAtIndex:(NSUInteger)aIndex {
	if (aIndex < self.count) {
		return self[aIndex];
	}
	return nil;
}

//*****//
- (id)m3_objectPassingTest:(BOOL (^)(id aObject))aTest {
	NSArray *objects = [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id aEvaluatedObject, NSDictionary *aBindings) {
		return aTest(aEvaluatedObject);
	}]];
	return [objects m3_safeObjectAtIndex:0];
}

@end