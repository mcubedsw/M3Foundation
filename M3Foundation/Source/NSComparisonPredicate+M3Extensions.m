/*****************************************************************
 NSComparisonPredicate+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 01/04/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSComparisonPredicate+M3Extensions.h"
#import "NSExpression+M3Extensions.h"
#import "NSXMLElement+M3Extensions.h"
#import "NSArray+M3Extensions.h"


@implementation NSComparisonPredicate (M3Extensions)


+ (NSPredicate *)m3_predicateWithXMLElement:(NSXMLElement *)aElement {
	//Get our expressions
	NSExpression *leftExpression = [NSExpression m3_expressionWithXMLElement:[aElement m3_elementForName:@"leftExpression"]];
	NSExpression *rightExpression = [NSExpression m3_expressionWithXMLElement:[aElement m3_elementForName:@"rightExpression"]];
	
	//Find our modifier value
	NSComparisonPredicateModifier modifier = NSDirectPredicateModifier;
	if ([aElement attributeForName:@"modifier"]) {
		NSString *attributeKey = [aElement attributeForName:@"modifier"].stringValue;
		NSNumber *value = [self modifierMap][attributeKey];
		modifier = value.integerValue;
	}
	
	//And our operator
	NSPredicateOperatorType operator = NSEqualToPredicateOperatorType;
	if ([aElement attributeForName:@"operatorType"]) {
		NSString *attributeKey = [aElement attributeForName:@"operatorType"].stringValue;
		NSNumber *value = [self operatorTypeMap][attributeKey];
		operator = value.integerValue;
	}
	
	//And our options
	NSUInteger options = 0;
	if ([aElement attributeForName:@"caseInsensitive"]) {
		options |= NSCaseInsensitivePredicateOption;
	}
	if ([aElement attributeForName:@"diacriticInsensitive"]) {
		options |= NSDiacriticInsensitivePredicateOption;
	}
	
	//Go go gadget predicate
	return [NSComparisonPredicate predicateWithLeftExpression:leftExpression
											  rightExpression:rightExpression
													 modifier:modifier
														 type:operator
													  options:options];
}


+ (NSDictionary *)modifierMap {
	return @{
		@"direct":[NSNumber numberWithInt:NSDirectPredicateModifier],
		@"any":[NSNumber numberWithInt:NSAnyPredicateModifier],
		@"all":[NSNumber numberWithInt:NSAllPredicateModifier]
	};
}


+ (NSDictionary *)operatorTypeMap {
	return @{
		@"lessThan":[NSNumber numberWithInt:NSLessThanPredicateOperatorType],
		@"lessThanOrEqualTo":[NSNumber numberWithInt:NSLessThanOrEqualToPredicateOperatorType],
		@"greaterThan":[NSNumber numberWithInt:NSGreaterThanPredicateOperatorType],
		@"greaterThanOrEqualTo":[NSNumber numberWithInt:NSGreaterThanOrEqualToPredicateOperatorType],
		@"equalTo":[NSNumber numberWithInt:NSEqualToPredicateOperatorType],
		@"matches":[NSNumber numberWithInt:NSMatchesPredicateOperatorType],
		@"like":[NSNumber numberWithInt:NSLikePredicateOperatorType],
		@"beginsWith":[NSNumber numberWithInt:NSBeginsWithPredicateOperatorType],
		@"endsWith":[NSNumber numberWithInt:NSEndsWithPredicateOperatorType],
		@"in":[NSNumber numberWithInt:NSInPredicateOperatorType],
		@"customSelector":[NSNumber numberWithInt:NSCustomSelectorPredicateOperatorType],
		@"contains":[NSNumber numberWithInt:NSContainsPredicateOperatorType],
		@"between":[NSNumber numberWithInt:NSBetweenPredicateOperatorType]
	};
}


- (NSString *)p_modifierString {
	return [[[self.class modifierMap] allKeysForObject:@(self.comparisonPredicateModifier)] m3_safeObjectAtIndex:0];;
}


- (NSString *)p_operatorTypeString {
	return [[[self.class operatorTypeMap] allKeysForObject:@(self.predicateOperatorType)] m3_safeObjectAtIndex:0];
}


- (NSXMLElement *)m3_xmlRepresentation {
	//Build a predicate element
	NSXMLElement *comparisonElement = [NSXMLElement elementWithName:@"predicate"];
	
	//Set all its attributes
	[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"operatorType" stringValue:self.p_operatorTypeString]];
	
	if ([self comparisonPredicateModifier] != NSDirectPredicateModifier) {
		[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"modifier" stringValue:self.p_modifierString]];
	}
	
	if ([self predicateOperatorType] == NSCustomSelectorPredicateOperatorType) {
		[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"selector" stringValue:NSStringFromSelector(self.customSelector)]];
	}

	if ([self options] & NSCaseInsensitivePredicateOption) {
		[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"caseInsensitive" stringValue:@"true"]];
	}
	
	if ([self options] & NSDiacriticInsensitivePredicateOption) {
		[comparisonElement addAttribute:[NSXMLNode attributeWithName:@"diacriticInsensitive" stringValue:@"true"]];
	}
	
	//And add its expressions
	NSXMLElement *leftExpressionElement = self.leftExpression.m3_xmlRepresentation;
	[leftExpressionElement setName:@"leftExpression"];
	[comparisonElement addChild:leftExpressionElement];
	
	NSXMLElement *rightExpressionElement = self.rightExpression.m3_xmlRepresentation;
	[rightExpressionElement setName:@"rightExpression"];
	[comparisonElement addChild:rightExpressionElement];
	
	return comparisonElement;
}

@end
