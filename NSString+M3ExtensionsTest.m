//
//  NSString+M3ExtensionsTest.m
//  M3Foundation
//
//  Created by Martin Pilkington on 09/01/2010.
//  Copyright 2010 M Cubed Software. All rights reserved.
//

#import "NSString+M3ExtensionsTest.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSString_M3ExtensionsTest

- (void)testStringByRemovingCharactersFromEnd {
	STAssertEquals((NSUInteger)14, [[@"12345678901234567890" m3_stringByRemovingCharactersFromEnd:6] length], @"");
	STAssertNil([@"12345678901234567890" m3_stringByRemovingCharactersFromEnd:-6], @"");
}

@end
