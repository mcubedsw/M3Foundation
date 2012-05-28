/*****************************************************************
 NSMutableSet+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 10/02/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMutableSet+M3Extensions.h"


@implementation NSMutableSet (M3Extensions)

//*****//
- (void)m3_differenceSet:(NSSet *)aSet {
	NSMutableSet *setB = [self mutableCopy];
	[self unionSet:aSet];
	[setB intersectSet:aSet];
	[self minusSet:setB];
}
	 
@end
