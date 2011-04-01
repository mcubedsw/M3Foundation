//
//  NSPredicate+M3ExtensionsTests.m
//  M3Foundation
//
//  Created by Martin Pilkington on 31/03/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSPredicate+M3ExtensionsTests.h"


@implementation NSPredicate_M3ExtensionsTests

- (void)setUp {
	[super setUp];
	
	// Set-up code here.
}

- (void)tearDown {
	// Tear-down code here.
	
	[super tearDown];
}


- (void)testPredicate {
	NSLog(@"=============================\n");
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"name ==[cd] 'Fred' AND ($EMAIL_KEY BEGINSWITH 'fred*bloggs' OR person.name IN {'Bob', 'Mike', 'Fred', $LAST_NAME}) AND (ANY children.age < $CHILD_AGE)"];	
	NSLog(@"\n%@", [[pred m3_xmlRepresentation] XMLStringWithOptions:NSXMLNodePrettyPrint]);
	
	NSLog(@"=============================\n");
	NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"name = 'Bob' AND @avg.children.age > 15"];
	NSLog(@"\n%@", [[pred2 m3_xmlRepresentation] XMLStringWithOptions:NSXMLNodePrettyPrint]);
	
	NSLog(@"\n=============================");
}

- (void)logExpression:(NSExpression *)aExpression {
	switch ([aExpression expressionType]) {
		case NSConstantValueExpressionType:
			NSLog(@"constantValue:%@", [aExpression constantValue]);
			break;
		case NSEvaluatedObjectExpressionType:
			NSLog(@"evaluatedObject");
			break;
		case NSVariableExpressionType:
			NSLog(@"variable:%@", [aExpression variable]);
			break;
		case NSKeyPathExpressionType:
			NSLog(@"keypath:%@", [aExpression keyPath]);
			break;
		case NSFunctionExpressionType:
			NSLog(@"function");
			break;
		case NSAggregateExpressionType:
			NSLog(@"aggregate:%@", [aExpression collection]);
			break;
		case NSSubqueryExpressionType:
			NSLog(@"subquery");
			break;
		case NSUnionSetExpressionType:
			NSLog(@"unionSet");
			break;
		case NSIntersectSetExpressionType:
			NSLog(@"intersectSet");
			break;
		case NSMinusSetExpressionType:
			NSLog(@"minusSet");
			break;
		case NSBlockExpressionType:
			NSLog(@"block");
			break;
	}
//	NSLog(@"args=%@ collection=%@ constant=%@ expressionType=%lu function=%@ keyPath=%@ operand=%@ variable=%@", [aExpression arguments], [aExpression collection], [aExpression constantValue], [aExpression expressionType], [aExpression function], [aExpression keyPath], [aExpression operand], [aExpression variable]);
}

- (void)logComparisonPred:(NSComparisonPredicate *)aPred {
	NSLog(@"%@: modifier=%lu selector=%@ options=(ci:%lu, d:%lu) operatorType=%lu", aPred, [aPred comparisonPredicateModifier], NSStringFromSelector([aPred customSelector]), [aPred options] & NSCaseInsensitivePredicateOption, [aPred options] & NSDiacriticInsensitivePredicateOption, [aPred predicateOperatorType]);
	[self logExpression:[aPred leftExpression]];
	[self logExpression:[aPred rightExpression]];
}

- (void)logCompoundPred:(NSCompoundPredicate *)aPred {
	NSLog(@"%lu", [aPred compoundPredicateType]);
	for (id pred in [aPred subpredicates]) {
		if ([pred isKindOfClass:[NSCompoundPredicate class]]) {
			[self logCompoundPred:pred];
		} else {
			[self logComparisonPred:pred];
		}
	}
}

@end
