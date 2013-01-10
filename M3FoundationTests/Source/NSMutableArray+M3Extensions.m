//
//  NSMutableArray+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 10/01/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSMutableArray+M3Extensions.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSMutableArray_M3Extensions {
	NSMutableArray *testArray;
}

- (void)setUp {
	[super setUp];
	testArray = [@[@1, @2, @3, @4, @5] mutableCopy];
}

- (void)test_movingObjectTo0MovesItToFrontOfArray {
	[testArray m3_moveObjectAtIndex:2 toIndex:0];
	NSArray *expectedArray = @[@3, @1, @2, @4, @5];
	assertThat(testArray, is(equalTo(expectedArray)));
}

- (void)test_movingObjectToCountMovesItToEndOfArray {
	[testArray m3_moveObjectAtIndex:1 toIndex:5];
	NSArray *expectedArray = @[@1, @3, @4, @5, @2];
	assertThat(testArray, is(equalTo(expectedArray)));
}

- (void)test_movingObjectUpAnIndexSwapsWithNextObject {
	[testArray m3_moveObjectAtIndex:2 toIndex:3];
	NSArray *expectedArray = @[@1, @2, @4, @3, @5];
	assertThat(testArray, is(equalTo(expectedArray)));
}

- (void)test_movingObjectDownAnIndexSwapsWithPreviousObject {
	[testArray m3_moveObjectAtIndex:4 toIndex:3];
	NSArray *expectedArray = @[@1, @2, @3, @5, @4];
	assertThat(testArray, is(equalTo(expectedArray)));
}

- (void)test_movingNonConcurrentObjectsWithinArrayCorrectlyMovesObject {
	[testArray m3_moveObjectAtIndex:1 toIndex:3];
	NSArray *expectedArray = @[@1, @3, @4, @2, @5];
	assertThat(testArray, is(equalTo(expectedArray)));
}

@end
