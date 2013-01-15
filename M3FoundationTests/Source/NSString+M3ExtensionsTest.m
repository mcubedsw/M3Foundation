/*****************************************************************
 NSString+M3ExtensionsTest.m
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSString+M3ExtensionsTest.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSString_M3ExtensionsTest

#pragma mark -
#pragma mark -m3_stringByRemovingCharactersFromEnd

- (void)test_removesCharactersFromEndOfString {
	assertThat([@"hello world" m3_stringByRemovingCharactersFromEnd:6], is(equalTo(@"hello")));
}

- (void)test_usingNegativeNumberOfCharactersToRemoveReturnsNil {
	assertThat([@"hello world" m3_stringByRemovingCharactersFromEnd:-6], is(nilValue()));
}





#pragma mark -
#pragma mark -m3_containsString

- (void)test_returnsNOIfSuppliedStringNotContainedInReceiver {
	assertThatBool([@"foobar" m3_containsString:@"bars"], is(equalToBool(NO)));
	assertThatBool([@"foobar" m3_containsString:@"afoo"], is(equalToBool(NO)));
}

- (void)test_returnsYESIfSuppliedStringIsContainedInReceiver {
	assertThatBool([@"foobar" m3_containsString:@"bar"], is(equalToBool(YES)));
	assertThatBool([@"foobar" m3_containsString:@"foo"], is(equalToBool(YES)));
	assertThatBool([@"foobar" m3_containsString:@"oba"], is(equalToBool(YES)));
}

- (void)test_returnsNOIfReceiverIsEmpty {
	assertThatBool([@"" m3_containsString:@"bar"], is(equalToBool(NO)));
}

@end
