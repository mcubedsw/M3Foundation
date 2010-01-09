//
//  M3IndexSetEnumerator.m
//  M3TableView
//
//  Created by Martin Pilkington on 27/07/2009.
//  Copyright 2009 M Cubed Software. All rights reserved.
//

#import "M3IndexSetEnumerator.h"


@implementation M3IndexSetEnumerator

+ (M3IndexSetEnumerator *)enumeratorWithIndexSet:(NSIndexSet *)anIndexSet {
	return [[[M3IndexSetEnumerator alloc] initWithIndexSet:anIndexSet ascending:YES] autorelease];
}

+ (M3IndexSetEnumerator *)reverseEnumeratorWithIndexSet:(NSIndexSet *)anIndexSet {
	return [[[M3IndexSetEnumerator alloc] initWithIndexSet:anIndexSet ascending:NO] autorelease];
}

- (id)initWithIndexSet:(NSIndexSet *)anIndexSet ascending:(BOOL)asc{
	if (self = [super init]) {
		indexSet = [anIndexSet copy];
		isAscending = asc;
		[self reset];
	}
	return self;
}

- (NSUInteger)nextIndex {
	if (remainingIndexes <= 0) {
		return NSNotFound;
	}
	NSUInteger index = [indexSet indexGreaterThanOrEqualToIndex:currentIndex];
	if (!isAscending) {
		index = [indexSet indexLessThanOrEqualToIndex:currentIndex];
	}
	currentIndex = index + (isAscending ? 1 : -1);
	remainingIndexes--;
	return index;
}

- (void)reset {
	if (isAscending) {
		currentIndex = 0;
	} else {
		currentIndex = [indexSet lastIndex];
	}
	remainingIndexes = [indexSet count];
}

@end
