//
//  NSDictionary+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 17/01/2012.
//  Copyright 2012 M Cubed Software. All rights reserved.
//

#import "NSDictionary+M3Extensions.h"

@implementation NSDictionary (M3Extensions)

//*****//
- (NSDictionary *)m3_dictionaryBySettingObject:(id)aObject forKey:(id)aKey {
	NSMutableDictionary *newDictionary = [self mutableCopy];
	newDictionary[aKey] = aObject;
	return [newDictionary copy];
}

@end
