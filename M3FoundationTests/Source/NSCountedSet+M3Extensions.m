/*****************************************************************
 NSCountedSet+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 14/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSCountedSet+M3Extensions.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSCountedSet_M3Extensions {
	NSCountedSet *countedSet;
}

- (void)setUp {
	[super setUp];
	
	countedSet = [NSCountedSet new];
	[countedSet addObjectsFromArray:@[@1, @1, @2, @3, @4, @4, @4, @5, @5, @6, @6, @6, @6, @6]];
}





#pragma mark -
#pragma mark -m3_objectsWithCount

- (void)test_returnsEmptySetIfNoObjectsMatchCount {
	assertThat([countedSet m3_objectsWithCount:4], hasCountOf(0));
}

- (void)test_returnsOnlyObjectsMatchingCountIfSomeMatch {
	NSSet *actualSet = [countedSet m3_objectsWithCount:2];
	NSSet *expectedSet = [NSSet setWithObjects:@1, @5, nil];
	assertThat(actualSet, is(equalTo(expectedSet)));
}





#pragma mark -
#pragma mark -m3_countedObjectTotal

- (void)test_returnsCorrectTotalObjectCount {
	assertThatInteger(countedSet.m3_countedObjectTotal, is(equalToInteger(14)));
}

@end
