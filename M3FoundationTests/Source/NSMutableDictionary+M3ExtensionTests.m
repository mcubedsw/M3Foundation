/*****************************************************************
 NSMutableDictionary+M3ExtensionTests.m
 M3Foundation
 
 Created by Martin Pilkington on 10/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMutableDictionary+M3ExtensionTests.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSMutableDictionary_M3ExtensionTests

- (void)test_settingObjectSetsObject {
	NSDictionary *expectedDictionary = @{@"bar" : @"foo"};
	
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary m3_safeSetObject:@"foo" forKey:@"bar"];
	assertThat(dictionary, is(equalTo(expectedDictionary)));
}

- (void)test_settingNilDoesNothing {
	NSDictionary *expectedDictionary = @{};
	
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary m3_safeSetObject:nil forKey:@"bar"];
	assertThat(dictionary, is(equalTo(expectedDictionary)));
}

@end
