//
//  NSComparisonPredicate+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 01/04/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSComparisonPredicate+M3Extensions.h"
#import "NSExpression+M3Extensions.h"

@implementation NSComparisonPredicate (NSComparisonPredicate_M3Extensions)

- (NSDictionary *)_m3_modifierMap {
	return [NSDictionary dictionaryWithObjectsAndKeys:@"direct", [NSNumber numberWithInt:NSDirectPredicateModifier], @"any", [NSNumber numberWithInt:NSAnyPredicateModifier], @"all", [NSNumber numberWithInt:NSAllPredicateModifier], nil];
}

- (NSDictionary *)_m3_operatorTypeMap {
	return [NSDictionary dictionaryWithObjectsAndKeys:@"lessThan", [NSNumber numberWithInt:NSLessThanPredicateOperatorType],
			@"lessThanOrEqualTo", [NSNumber numberWithInt:NSLessThanOrEqualToPredicateOperatorType],
			@"greaterThan", [NSNumber numberWithInt:NSGreaterThanPredicateOperatorType],
			@"greaterThanOrEqualTo", [NSNumber numberWithInt:NSGreaterThanOrEqualToPredicateOperatorType],
			@"equalTo", [NSNumber numberWithInt:NSEqualToPredicateOperatorType],
			@"matches", [NSNumber numberWithInt:NSMatchesPredicateOperatorType],
			@"like", [NSNumber numberWithInt:NSLikePredicateOperatorType],
			@"beginsWith", [NSNumber numberWithInt:NSBeginsWithPredicateOperatorType],
			@"endsWith", [NSNumber numberWithInt:NSEndsWithPredicateOperatorType],
			@"in", [NSNumber numberWithInt:NSInPredicateOperatorType],
			@"customSelector", [NSNumber numberWithInt:NSCustomSelectorPredicateOperatorType],
			@"contains", [NSNumber numberWithInt:NSContainsPredicateOperatorType],
			@"between", [NSNumber numberWithInt:NSBetweenPredicateOperatorType], nil];
}

- (NSString *)_m3_modifierString {
	return [[self _m3_modifierMap] objectForKey:[NSNumber numberWithInt:[self comparisonPredicateModifier]]];
}

- (NSString *)_m3_operatorTypeString {
	return [[self _m3_operatorTypeMap] objectForKey:[NSNumber numberWithInt:[self predicateOperatorType]]];
}


- (NSXMLElement *)m3_xmlRepresentation {
	NSXMLElement *comparisonElement = [NSXMLElement elementWithName:@"predicate"];
	
	[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"modifier" stringValue:[self _m3_modifierString]]];
	[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"operatorType" stringValue:[self _m3_operatorTypeString]]];
	[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"selector" stringValue:NSStringFromSelector([self customSelector])]];

	if ([self options] & NSCaseInsensitivePredicateOption) {
		[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"caseInsensitive" stringValue:@"true"]];
	}
	
	if ([self options] & NSDiacriticInsensitivePredicateOption) {
		[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"diacriticInsensitive" stringValue:@"true"]];
	}
	
	
	NSXMLElement *leftExpressionElement = [[self leftExpression] m3_xmlRepresentation];
	[leftExpressionElement setName:@"leftExpression"];
	[comparisonElement addChild:leftExpressionElement];
	
	NSXMLElement *rightExpressionElement = [[self rightExpression] m3_xmlRepresentation];
	[rightExpressionElement setName:@"rightExpression"];
	[comparisonElement addChild:rightExpressionElement];
	
	return comparisonElement;
}

@end
