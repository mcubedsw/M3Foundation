/*****************************************************************
 NSMutableArray+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 21/05/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMutableArray+M3Extensions.h"


@implementation NSMutableArray (M3Extensions)


- (void)m3_moveObjectAtIndex:(NSUInteger)aIndex toIndex:(NSUInteger)aNewIndex {
	id movingObject = [self objectAtIndex:aIndex];
	[self removeObjectAtIndex:aIndex];
	if (aNewIndex < self.count) {
		[self insertObject:movingObject atIndex:aNewIndex];
	} else {
		[self addObject:movingObject];
	}
}
	 
@end
