//
//  NSMutableDictionary+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 15/04/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSMutableDictionary+M3Extensions.h"


@implementation NSMutableDictionary (M3Extensions)

- (void)m3_safeSetObject:(id)aObj forKey:(id)aKey {
	if (aObj && aKey) {
		[self setObject:aObj forKey:aKey];
	}
}

@end
