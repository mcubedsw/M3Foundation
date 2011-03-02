/*****************************************************************
 M3IndexSetEnumerator.m
 M3Extensions
 
 Created by Martin Pilkington on 27/07/2009.
 
 Copyright (c) 2006-2010 M Cubed Software
 
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

#import "M3IndexSetEnumerator.h"


@implementation M3IndexSetEnumerator

+ (M3IndexSetEnumerator *)enumeratorWithIndexSet:(NSIndexSet *)anIndexSet {
	return [[[M3IndexSetEnumerator alloc] initWithIndexSet:anIndexSet ascending:YES] autorelease];
}

+ (M3IndexSetEnumerator *)reverseEnumeratorWithIndexSet:(NSIndexSet *)anIndexSet {
	return [[[M3IndexSetEnumerator alloc] initWithIndexSet:anIndexSet ascending:NO] autorelease];
}

- (id)initWithIndexSet:(NSIndexSet *)anIndexSet ascending:(BOOL)asc{
	if ((self = [super init])) {
		indexSet = [anIndexSet copy];
		isAscending = asc;
		[self reset];
	}
	return self;
}

- (void)dealloc {
	[indexSet release];
	[super dealloc];
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
