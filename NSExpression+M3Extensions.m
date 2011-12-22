/*****************************************************************
 NSExpression+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 01/04/2011.
 
 Copyright © 2006-2011 M Cubed Software.
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
  
*****************************************************************/

#import "NSExpression+M3Extensions.h"


@implementation NSExpression (M3Extensions)

+ (NSExpression *)m3_expressionFromXMLElement:(NSXMLElement *)aElement {
	NSString *type = [[aElement attributeForName:@"type"] stringValue];
	if ([type isEqualToString:@"constant"]) {
		NSString *valueType = [[aElement attributeForName:@"valueType"] stringValue];
		id constantValue = nil;
		if ([valueType isEqualToString:@"string"]) {
			constantValue = [aElement stringValue];
		} else if ([valueType isEqualToString:@"double"]) {
			constantValue = [NSNumber numberWithDouble:[[aElement stringValue] doubleValue]];
		} else if ([valueType isEqualToString:@"integer"]) {
			constantValue = [NSNumber numberWithInteger:[[aElement stringValue] integerValue]];
		}
		return [NSExpression expressionForConstantValue:constantValue];
	} else if ([type isEqualToString:@"variable"]) {
		return [NSExpression expressionForVariable:[aElement stringValue]];
	} else if ([type isEqualToString:@"keyPath"]) {
		return [NSExpression expressionForKeyPath:[aElement stringValue]];
	} else if ([type isEqualToString:@"aggregate"]) {
		NSMutableArray *aggregate = [NSMutableArray array];
		for (NSXMLElement *element in [aElement children]) {
			[aggregate addObject:[NSExpression m3_expressionFromXMLElement:element]];
		}
		return [NSExpression expressionForAggregate:aggregate];
	} else if ([type isEqualToString:@"evaluatedObject"]) {
		return [NSExpression expressionForEvaluatedObject];
	}
	return nil;
}

- (void)_m3_addContentToElement:(NSXMLElement *)aElement {
	NSExpressionType type = [self expressionType];
	//Set the constant value and value type
	if (type == NSConstantValueExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"constant"]];
		
		NSString *valueType = @"string";
		if ([[self constantValue] isKindOfClass:[NSNumber class]]) {
			if (strcmp([[self constantValue] objCType], @encode(int)) == 0) {
				valueType = @"integer";
			} else if (strcmp([[self constantValue] objCType], @encode(double)) == 0) {
				valueType = @"double";
			}
			
		}
		
		[aElement addAttribute:[NSXMLNode attributeWithName:@"valueType" stringValue:valueType]];
		
		[aElement setStringValue:[[self constantValue] description]];
	//Set the variable value
	} else if (type == NSVariableExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"variable"]];
		[aElement setStringValue:[self variable]];
	//Set the key path value
	} else if (type == NSKeyPathExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"keyPath"]];
		[aElement setStringValue:[self keyPath]];
	//Set the aggregate value
	} else if (type == NSAggregateExpressionType) {
		[aElement addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:@"aggregate"]];
		for (NSExpression *expression in [self collection]) {
			[aElement addChild:[expression m3_xmlRepresentation]];
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
	[self _m3_addContentToElement:expressionElement];
	return expressionElement;
}

@end
