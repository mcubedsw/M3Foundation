/*****************************************************************
 NSDictionary+M3ExtensionsTests.m
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSDictionary+M3ExtensionsTests.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSDictionary_M3ExtensionsTests

- (void)test_settingObjectForNonexistentKeyAddsItToTheReturnedDictionary {
	NSDictionary *startingDictionary = @{};
	NSDictionary *expectedDictionary = @{@"bar" : @"foo"};
	
	NSDictionary *actualDictionary = [startingDictionary m3_dictionaryBySettingObject:@"foo" forKey:@"bar"];
	
	assertThat(actualDictionary, is(equalTo(expectedDictionary)));
}

- (void)test_settingObjectForExistingKeyReplacesObjectInReturnedDictionary {
	NSDictionary *startingDictionary = @{@"foo" : @"1", @"bar" : @"2"};
	NSDictionary *expectedDictionary = @{@"foo" : @"1", @"bar" : @"6"};
	
	NSDictionary *actualDictionary = [startingDictionary m3_dictionaryBySettingObject:@"6" forKey:@"bar"];
	
	assertThat(actualDictionary, is(equalTo(expectedDictionary)));
}

@end
