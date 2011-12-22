/*****************************************************************
 NSArray+M3ExtensionsTests.m
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2010.
 
 Copyright © 2006-2011 M Cubed Software.
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
  
*****************************************************************/

#import "NSArray+M3ExtensionsTests.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSArray_M3ExtensionsTests

- (void)testAlphaNumericArray {
	STAssertEquals((NSUInteger)36, [[NSArray m3_alphaNumericArray] count], @"");
}

- (void)testAlphaNumericArrayContents {
	STAssertEqualObjects(@"0", [[NSArray m3_alphaNumericArray] objectAtIndex:0], @"");
	STAssertEqualObjects(@"3", [[NSArray m3_alphaNumericArray] objectAtIndex:3], @"");
	STAssertEqualObjects(@"8", [[NSArray m3_alphaNumericArray] objectAtIndex:8], @"");
	STAssertEqualObjects(@"e", [[NSArray m3_alphaNumericArray] objectAtIndex:14], @"");
	STAssertEqualObjects(@"a", [[NSArray m3_alphaNumericArray] objectAtIndex:10], @"");
	STAssertEqualObjects(@"m", [[NSArray m3_alphaNumericArray] objectAtIndex:22], @"");
	STAssertEqualObjects(@"d", [[NSArray m3_alphaNumericArray] objectAtIndex:13], @"");
	STAssertEqualObjects(@"v", [[NSArray m3_alphaNumericArray] objectAtIndex:31], @"");
	STAssertEqualObjects(@"o", [[NSArray m3_alphaNumericArray] objectAtIndex:24], @"");
	STAssertEqualObjects(@"l", [[NSArray m3_alphaNumericArray] objectAtIndex:21], @"");
}


- (void)testArrayWithNumberToFrom {
	STAssertEquals((NSUInteger)10, [[NSArray m3_arrayWithNumbersTo:10 from:1] count], @"");
	STAssertEquals((NSUInteger)5, [[NSArray m3_arrayWithNumbersTo:-8 from:-4] count], @"");
	STAssertEquals((NSUInteger)42, [[NSArray m3_arrayWithNumbersTo:-21 from:20] count], @"");
}

- (void)testArrayWithNumberToFrom2 {
	STAssertNil([NSArray m3_arrayWithNumbersTo:42 from:42], @"");
}

@end
