//
//  NSCompoundPredicate+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 01/04/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSCompoundPredicate+M3Extensions.h"
#import "NSPredicate+M3Extensions.h"


@implementation NSCompoundPredicate (M3Extensions)

- (NSString *)_m3_compoundPredicateTypeString {
	switch ([self compoundPredicateType]) {
		case NSAndPredicateType:
			return @"and";
		case NSOrPredicateType:
			return @"or";
		case NSNotPredicateType:
			return @"not";
	}
	return @"";
}

- (NSXMLElement *)m3_xmlRepresentation {
	NSXMLElement *compoundElement = [NSXMLElement elementWithName:@"predicates"];
	[compoundElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:[self _m3_compoundPredicateTypeString]]];
	for (NSPredicate *subPred in [self subpredicates]) {
		[compoundElement addChild:[subPred m3_xmlRepresentation]];
	}
	return compoundElement;
}

@end
