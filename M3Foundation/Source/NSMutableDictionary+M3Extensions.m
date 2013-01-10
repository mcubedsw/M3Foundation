/*****************************************************************
 NSMutableDictionary+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 15/04/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMutableDictionary+M3Extensions.h"


@implementation NSMutableDictionary (M3Extensions)


- (void)m3_safeSetObject:(id)aObject forKey:(id)aKey {
	if (aObject && aKey) {
		self[aKey] = aObject;
	}
}

@end
