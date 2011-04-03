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

+ (NSPredicate *)m3_predicateFromXMLElement:(NSXMLElement *)aElement {
	NSMutableArray *subpredicates = [NSMutableArray array];
	for (NSXMLElement *subpred in [aElement elementsForName:@"predicate"]) {
		[subpredicates addObject:[NSPredicate m3_predicateFromXMLElement:subpred]];
	}
	for (NSXMLElement *subpred in [aElement elementsForName:@"predicates"]) {
		[subpredicates addObject:[NSPredicate m3_predicateFromXMLElement:subpred]];
	}
	
	NSString *type = [[aElement attributeForName:@"type"] stringValue];
	if ([type isEqualToString:@"and"]) {
		return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
	} else if ([type isEqualToString:@"or"]) {
		return [NSCompoundPredicate orPredicateWithSubpredicates:subpredicates];
	} else if ([type isEqualToString:@"not"] && [subpredicates count] == 1) {
		return [NSCompoundPredicate notPredicateWithSubpredicate:[subpredicates objectAtIndex:0]];
	}
	return nil;
}

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
