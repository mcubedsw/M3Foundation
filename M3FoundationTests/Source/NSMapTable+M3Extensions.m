/*****************************************************************
 NSMapTable+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 15/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMapTable+M3Extensions.h"

#import <M3Foundation/M3Foundation.h>

@implementation NSMapTable_M3Extensions

- (void)test_accessingObjectUsingSubscripting {
	NSMapTable *table = [NSMapTable strongToStrongObjectsMapTable];
	[table setObject:@"foo" forKey:@"bar"];
	
	assertThat(table[@"bar"], is(equalTo(@"foo")));
}

- (void)test_settingObjectUsingSubscripting {
	NSMapTable *table = [NSMapTable strongToStrongObjectsMapTable];
	
	table[@"baz"] = @"possum";
	
	assertThat([table objectForKey:@"baz"], is(equalTo(@"possum")));
}

@end
