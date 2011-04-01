//
//  NSExpression+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 01/04/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSExpression+M3Extensions.h"


@implementation NSExpression (M3Extensions)

- (id)_m3_contentObject {
	NSExpressionType type = [self expressionType];
	if (type == NSConstantValueExpressionType) {
		return [[self constantValue] description];
	} else if (type == NSEvaluatedObjectExpressionType) {
	} else if (type == NSVariableExpressionType) {
		return [self variable];
	} else if (type == NSKeyPathExpressionType) {
		return [self keyPath];
	} else if (type == NSFunctionExpressionType) {
	} else if (type == NSAggregateExpressionType) {
		return [[self collection] valueForKey:@"m3_xmlRepresentation"];
	} else if (type == NSSubqueryExpressionType) {
	} else if (type == NSUnionSetExpressionType) {
	} else if (type == NSIntersectSetExpressionType) {
	} else if (type == NSMinusSetExpressionType) {
	} else if (type == NSBlockExpressionType) {
	}
	return nil;
}

- (NSXMLElement *)m3_xmlRepresentation {
	NSXMLElement *expressionElement = [NSXMLElement elementWithName:@"expression"];
	NSString *typeString = nil;
	NSExpressionType type = [self expressionType];
	if (type == NSConstantValueExpressionType) {
		typeString = @"constantValue";
	} else if (type == NSEvaluatedObjectExpressionType) {
		typeString = @"evaluatedObject";
	} else if (type == NSVariableExpressionType) {
		typeString = @"variable";
	} else if (type == NSKeyPathExpressionType) {
		typeString = @"keypath";
	} else if (type == NSFunctionExpressionType) {
		typeString = @"function";
	} else if (type == NSAggregateExpressionType) {
		typeString = @"aggregate";
	} else if (type == NSSubqueryExpressionType) {
		typeString = @"subquery";
	} else if (type == NSUnionSetExpressionType) {
		typeString = @"unionSet";
	} else if (type == NSIntersectSetExpressionType) {
		typeString = @"intersectSet";
	} else if (type == NSMinusSetExpressionType) {
		typeString = @"minusSet";
	} else if (type == NSBlockExpressionType) {
		typeString = @"block";
	}
	[expressionElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:typeString]];
	
	id contentObject = [self _m3_contentObject];
	if ([contentObject isKindOfClass:[NSString class]]) {
		[expressionElement setStringValue:contentObject];
	} else if ([contentObject isKindOfClass:[NSArray class]]) {
		for (NSXMLNode *node in contentObject) {
			[expressionElement addChild:node];
		}
	}
	return expressionElement;
}

@end
