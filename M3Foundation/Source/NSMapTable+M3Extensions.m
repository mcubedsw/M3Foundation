/*****************************************************************
 NSMapTable+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 15/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMapTable+M3Extensions.h"

@implementation NSMapTable (M3Extensions)

- (id)objectForKeyedSubscript:(id)aKey {
	return [self objectForKey:aKey];
}

- (void)setObject:(id)aObject forKeyedSubscript:(id)aKey {
	[self setObject:aObject forKey:aKey];
}

@end
