/*****************************************************************
 NSXMLElement+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 10/05/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSXMLElement+M3Extensions.h"


@implementation NSXMLElement (M3Extensions)

//*****//
- (NSXMLElement *)m3_elementForName:(NSString *)aName {
	NSArray *elements = [self elementsForName:aName];
	if (elements.count) {
		return elements[0];
	}
	return nil;
}

@end
