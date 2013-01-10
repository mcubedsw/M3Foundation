/*****************************************************************
 NSCountedSet+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 11/02/2012.
 
 Please read the LICENCE.txt for licensing information
 *****************************************************************/

#import "NSCountedSet+M3Extensions.h"

@implementation NSCountedSet (M3Extensions)


- (NSSet *)m3_objectsWithCount:(NSUInteger)aCount {
	NSMutableSet *returnSet = [NSMutableSet set];
	for (id object in self) {
		if ([self countForObject:object] == aCount) {
			[returnSet addObject:object];
		}
	}
	return [returnSet copy];
}


- (NSUInteger)m3_countedObjectTotal {
	NSUInteger totalCount = 0;
	for (id object in self) {
		totalCount += [self countForObject:object];
	}
	return totalCount;
}

@end
