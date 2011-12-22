/*****************************************************************
 NSString+M3ExtensionsTest.m
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

#import "NSString+M3ExtensionsTest.h"
#import <M3Foundation/M3Foundation.h>

@implementation NSString_M3ExtensionsTest

- (void)testStringByRemovingCharactersFromEnd {
	STAssertEquals((NSUInteger)14, [[@"12345678901234567890" m3_stringByRemovingCharactersFromEnd:6] length], @"");
	STAssertNil([@"12345678901234567890" m3_stringByRemovingCharactersFromEnd:-6], @"");
}

@end
