/*****************************************************************
 NSMutableArray+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 21/05/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMutableArray+M3Extensions.h"


@implementation NSMutableArray(M3Extensions)

//*****//
- (void)m3_moveObject:(id)aObject toIndex:(NSUInteger)aIndex {
	id movingObject = aObject;
	[self removeObject:aObject];
	if (aIndex < [self count])
		[self insertObject:movingObject atIndex:aIndex];
	else 
		[self addObject:movingObject];
}
	 
@end
