/*****************************************************************
 NSArray+M3ExtensionsTests.m
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSArray+M3ExtensionsTests.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSArray_M3ExtensionsTests

#pragma mark -
#pragma mark +m3_alphaNumericArray

- (void)test_returnsAlphaNumericArray {
	assertThat([NSArray m3_alphaNumericArray], hasCountOf(36));
}

- (void)test_alphaNumericArrayContents {
	assertThat([NSArray m3_alphaNumericArray][0], is(equalTo(@"0")));
	assertThat([NSArray m3_alphaNumericArray][3], is(equalTo(@"3")));
	assertThat([NSArray m3_alphaNumericArray][8], is(equalTo(@"8")));
	assertThat([NSArray m3_alphaNumericArray][14], is(equalTo(@"e")));
	assertThat([NSArray m3_alphaNumericArray][10], is(equalTo(@"a")));
	assertThat([NSArray m3_alphaNumericArray][22], is(equalTo(@"m")));
	assertThat([NSArray m3_alphaNumericArray][13], is(equalTo(@"d")));
	assertThat([NSArray m3_alphaNumericArray][31], is(equalTo(@"v")));
	assertThat([NSArray m3_alphaNumericArray][24], is(equalTo(@"o")));
	assertThat([NSArray m3_alphaNumericArray][21], is(equalTo(@"l")));
}





#pragma mark -
#pragma mark +m3_arrayWithNumbersFrom:to:

- (void)test_arrayFromAndToNumbersReturnsCorrectNumberOfElements {
	assertThat([NSArray m3_arrayWithNumbersFrom:1 to:10], hasCountOf(10));
	assertThat([NSArray m3_arrayWithNumbersFrom:-4 to:-8], hasCountOf(5));
	assertThat([NSArray m3_arrayWithNumbersFrom:20 to:-21], hasCountOf(42));
}

- (void)test_arrayFromAndToTheSameNumberReturnsNil {
	assertThat([NSArray m3_arrayWithNumbersFrom:42 to:42], is(nilValue()));
}





#pragma mark -
#pragma mark -m3_safeObjectAtIndex:

- (void)test_returnsObjectAtSuppliedIndexIfOneExists {
	NSArray *array = @[@"1", @"2", @"3"];
	assertThat([array m3_safeObjectAtIndex:0], is(equalTo(@"1")));
	assertThat([array m3_safeObjectAtIndex:1], is(equalTo(@"2")));
	assertThat([array m3_safeObjectAtIndex:2], is(equalTo(@"3")));
}

- (void)test_returnsNilIfNoObjectExistsAtSuppliedIndex {
	assertThat([@[] m3_safeObjectAtIndex:0], is(nilValue()));
	assertThat([@[@"1"] m3_safeObjectAtIndex:1], is(nilValue()));
}





#pragma mark -
#pragma mark -m3_firstObjectPassingTest:

- (void)test_returnsNilIfTestIsNil {
	assertThat([@[] m3_firstObjectPassingTest:nil], is(nilValue()));
}

- (void)test_returnsNilIfNoObjectPassesTest {
	NSArray *array = @[@1, @2, @3, @4, @5];
	id object = [array m3_firstObjectPassingTest:^BOOL(NSNumber *aObject) {
		return aObject.integerValue > 5;
	}];
	assertThat(object, is(nilValue()));
}

- (void)test_returnsObjectIfSingleObjectPasses {
	NSArray *array = @[@1, @2, @3, @4, @5];
	id object = [array m3_firstObjectPassingTest:^BOOL(NSNumber *aObject) {
		return aObject.integerValue > 4;
	}];
	assertThat(object, is(equalTo(@5)));
}

- (void)test_returnsFirstObjectIfMultipleObjectsPassTest {
	NSArray *array = @[@1, @2, @3, @4, @5];
	id object = [array m3_firstObjectPassingTest:^BOOL(NSNumber *aObject) {
		return aObject.integerValue > 3;
	}];
	assertThat(object, is(equalTo(@4)));
}

@end
