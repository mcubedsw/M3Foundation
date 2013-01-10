/*****************************************************************
 NSString+M3ExtensionsTest.m
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSString+M3ExtensionsTest.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSString_M3ExtensionsTest

- (void)test_removesCharactersFromEndOfString {
	assertThat([@"hello world" m3_stringByRemovingCharactersFromEnd:6], is(equalTo(@"hello")));
}

- (void)test_usingNegativeNumberOfCharactersToRemoveReturnsNil {
	assertThat([@"hello world" m3_stringByRemovingCharactersFromEnd:-6], is(nilValue()));
}

@end
