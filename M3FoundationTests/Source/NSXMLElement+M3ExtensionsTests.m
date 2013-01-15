/*****************************************************************
 NSXMLElement+M3ExtensionsTests.m
 M3Foundation
 
 Created by Martin Pilkington on 15/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSXMLElement+M3ExtensionsTests.h"

#import <M3Foundation/M3Foundation.h>

@implementation NSXMLElement_M3ExtensionsTests

- (void)test_returnsNilIfThereAreNoChildElements {
	NSXMLElement *element = [NSXMLElement new];
	
	assertThat([element m3_elementForName:@"foobar"], is(nilValue()));
}

- (void)test_returnsFirstChildElementMatchingName {
	NSXMLElement *child1 = [NSXMLElement new];
	[child1 setName:@"foobar"];
	NSXMLElement *child2 = [NSXMLElement new];
	[child2 setName:@"baz"];
	NSXMLElement *child3 = [NSXMLElement new];
	[child2 setName:@"foobar"];
	
	NSXMLElement *element = [NSXMLElement new];
	[element addChild:child1];
	[element addChild:child2];
	[element addChild:child3];
	
	assertThat([element m3_elementForName:@"foobar"], is(sameInstance(child1)));
}

@end
