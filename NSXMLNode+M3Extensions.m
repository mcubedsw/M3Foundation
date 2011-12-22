/*****************************************************************
 NSXMLNode+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 19/03/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSXMLNode+M3Extensions.h"


@implementation NSXMLNode (M3Extensions)

//*****//
- (NSInteger)m3_integerValue {
	return [[self stringValue] integerValue];
}

//*****//
- (CGFloat)m3_floatValue {
	return [[self stringValue] floatValue];
}

//*****//
- (NSXMLNode *)m3_nodeForXPath:(NSString *)xPath error:(NSError **)error {
	NSArray *nodes = [self nodesForXPath:xPath error:&*error];
	if ([nodes count]) {
		return [nodes objectAtIndex:0];
	}
	return nil;
}

@end
