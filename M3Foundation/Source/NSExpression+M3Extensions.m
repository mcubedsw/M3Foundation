/*****************************************************************
 NSExpression+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 01/04/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSExpression+M3Extensions.h"


@implementation NSExpression (M3Extensions)


+ (NSExpression *)m3_expressionWithXMLElement:(NSXMLElement *)aElement {
	//Get the element type
	NSString *type = [aElement attributeForName:@"type"].stringValue;
	//If a constant, find the value
	if ([type isEqualToString:@"constant"]) {
		NSString *valueType = [aElement attributeForName:@"valueType"].stringValue;
		id constantValue = nil;
		if ([valueType isEqualToString:@"string"]) {
			constantValue = aElement.stringValue;
		} else if ([valueType isEqualToString:@"double"]) {
			constantValue = [NSNumber numberWithDouble:aElement.stringValue.doubleValue];
		} else if ([valueType isEqualToString:@"integer"]) {
			constantValue = [NSNumber numberWithInteger:aElement.stringValue.integerValue];
		}
		return [NSExpression expressionForConstantValue:constantValue];
	}
	//If a variable use directly
	if ([type isEqualToString:@"variable"]) {
		return [NSExpression expressionForVariable:aElement.stringValue];
	}
	//Same for key paths
	if ([type isEqualToString:@"keyPath"]) {
		return [NSExpression expressionForKeyPath:aElement.stringValue];
	}
	//If an aggregate, collect together the sub expressions
	if ([type isEqualToString:@"aggregate"]) {
		NSMutableArray *aggregate = [NSMutableArray array];
		for (NSXMLElement *element in aElement.children) {
			[aggregate addObject:[NSExpression m3_expressionWithXMLElement:element]];
		}
		return [NSExpression expressionForAggregate:aggregate];
	}
	//And if an evaluated object return
	if ([type isEqualToString:@"evaluatedObject"]) {
		return [NSExpression expressionForEvaluatedObject];
	}
	return nil;
}


- (void)p_addContentToElement:(NSXMLElement *)aElement {
	NSExpressionType type = self.expressionType;
	//Set the constant value and value type
	if (type == NSConstantValueExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"constant"]];
		
		NSString *valueType = @"string";
		if ([self.constantValue isKindOfClass:[NSNumber class]]) {
			if (strcmp([self.constantValue objCType], @encode(int)) == 0) {
				valueType = @"integer";
			} else if (strcmp([self.constantValue objCType], @encode(double)) == 0) {
				valueType = @"double";
			}
			
		}
		
		[aElement addAttribute:[NSXMLNode attributeWithName:@"valueType" stringValue:valueType]];
		
		[aElement setStringValue:[self.constantValue description]];
	//Set the variable value
	} else if (type == NSVariableExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"variable"]];
		[aElement setStringValue:self.variable];
	//Set the key path value
	} else if (type == NSKeyPathExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"keyPath"]];
		[aElement setStringValue:self.keyPath];
	//Set the aggregate value
	} else if (type == NSAggregateExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"aggregate"]];
		for (NSExpression *expression in self.collection) {
			[aElement addChild:expression.m3_xmlRepresentation];
		}
	//Other types
	} else if (type == NSEvaluatedObjectExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"evaluatedObject"]];
	} else if (type == NSFunctionExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"function"]];
	} else if (type == NSSubqueryExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"subquery"]];
	} else if (type == NSUnionSetExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"unionSet"]];
	} else if (type == NSIntersectSetExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"intersectSet"]];
	} else if (type == NSMinusSetExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"minusSet"]];
	} else if (type == NSBlockExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"block"]];
	}
}


- (NSXMLElement *)m3_xmlRepresentation {
	NSXMLElement *expressionElement = [NSXMLElement elementWithName:@"expression"];
	[self p_addContentToElement:expressionElement];
	return expressionElement;
}

@end
