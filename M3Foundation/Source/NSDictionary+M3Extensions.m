/*****************************************************************
 NSDictionary+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 17/01/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSDictionary+M3Extensions.h"

@implementation NSDictionary (M3Extensions)


- (NSDictionary *)m3_dictionaryBySettingObject:(id)aObject forKey:(id<NSCopying>)aKey {
	NSMutableDictionary *newDictionary = [self mutableCopy];
	newDictionary[aKey] = aObject;
	return [newDictionary copy];
}

@end
