/*****************************************************************
 NSXMLNode+M3ExtensionsTests.m
 M3Foundation
 
 Created by Martin Pilkington on 15/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSXMLNode+M3ExtensionsTests.h"

#import <M3Foundation/M3Foundation.h>

@implementation NSXMLNode_M3ExtensionsTests

#pragma mark -
#pragma mark Basic queries

- (void)test_returnsFloatValue {
	NSXMLNode *node = [NSXMLNode new];
	[node setStringValue:@"1.23"];
	
	assertThatFloat(node.m3_floatValue, is(equalToFloat(1.23)));
}

- (void)test_returnsIntegerValue {
	NSXMLNode *node = [NSXMLNode new];
	[node setStringValue:@"987"];
	
	assertThatInteger(node.m3_integerValue, is(equalToInteger(987)));
}

@end
