/*****************************************************************
 NSCountedSet+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 11/02/2012.
 
 Please read the LICENCE.txt for licensing information
 *****************************************************************/

#import "NSCountedSet+M3Extensions.h"

@implementation NSCountedSet (M3Extensions)

//*****//
- (NSSet *)m3_objectsWithCount:(NSUInteger)aCount {
	NSMutableSet *returnSet = [NSMutableSet set];
	for (id obj in self) {
		if ([self countForObject:obj] == aCount) {
			[returnSet addObject:obj];
		}
	}
	return [returnSet copy];
}

//*****//
- (NSUInteger)m3_countedObjectTotal {
	NSUInteger totalCount = 0;
	for (id obj in self) {
		totalCount += [self countForObject:obj];
	}
	return totalCount;
}

@end
