/*****************************************************************
 NSPredicate+M3ExtensionsTests.m
 M3Foundation
 
 Created by Martin Pilkington on 31/03/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSPredicate+M3ExtensionsTests.h"

static NSDictionary *testData;

@implementation NSPredicate_M3ExtensionsTests

+ (void)initialize {
	if (!testData) {
		NSMutableDictionary *tempTestData = [NSMutableDictionary dictionary];
		NSString *dataPath = [[NSBundle bundleWithIdentifier:@"com.mcubedsw.M3FoundationTests"] pathForResource:@"NSPredicateXMLTestData" ofType:@"txt"];
		NSArray *dataArray = [[NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:NULL] componentsSeparatedByString:@"\n====\n"];
		for (NSUInteger i = 0; i < [dataArray count]; i+=2) {
			[tempTestData setObject:[dataArray objectAtIndex:i+1] forKey:[dataArray objectAtIndex:i]];
		}
		testData = [tempTestData copy];
	}
}

- (void)_testPredicate:(NSPredicate *)aPred forMethod:(SEL)aMethod {
	NSString *dataString = [testData objectForKey:[NSStringFromSelector(aMethod) substringFromIndex:10]];
	NSXMLDocument *document = [NSXMLDocument documentWithRootElement:[aPred m3_xmlRepresentation]];
	NSString *xmlString = [[document XMLStringWithOptions:NSXMLNodePrettyPrint|NSXMLNodeCompactEmptyElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	assertThat(xmlString, is(equalTo(dataString)));
}

#pragma mark -
#pragma mark Output Tests

- (void)testOutputTruePredicate {
	[self _testPredicate:[NSPredicate predicateWithValue:YES]forMethod:_cmd];
}

- (void)testOutputFalsePredicate {
	[self _testPredicate:[NSPredicate predicateWithValue:NO] forMethod:_cmd];
}

- (void)testOutputEqualTo {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = 'Bob'"] forMethod:_cmd];
}

- (void)testOutputLessThan {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.age < 15"] forMethod:_cmd];
}

- (void)testOutputLessThanOrEqualTo {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.age <= 15"] forMethod:_cmd];
}

- (void)testOutputGreaterThan {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.age > 15"] forMethod:_cmd];
}

- (void)testOutputGreaterThanOrEqualTo {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.age >= 15"] forMethod:_cmd];
}

- (void)testOutputBetween {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.age BETWEEN {10, 21}"] forMethod:_cmd];
}

- (void)testOutputMatches {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.name MATCHES 'F.{1,3}k'"] forMethod:_cmd];
}

- (void)testOutputLike {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.name LIKE 'S????'"] forMethod:_cmd];
}

- (void)testOutputBeginsWith {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.name BEGINSWITH 'A'"] forMethod:_cmd];
}

- (void)testOutputEndsWith {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.name ENDSWITH 'E'"] forMethod:_cmd];
}

- (void)testOutputContains {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.name CONTAINS 'l'"] forMethod:_cmd];
}

- (void)testOutputIn {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"children.name IN {'Frank', 'Sally', 'Steve', 'Alice'}"] forMethod:_cmd];
}

- (void)testOutputNoOptions {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = 'Bob'"] forMethod:_cmd];
}

- (void)testOutputCaseInsensitive {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name =[c] 'Bob'"] forMethod:_cmd];
}

- (void)testOutputDiacriticInsensitive {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name =[d] 'Bob'"] forMethod:_cmd];
}

- (void)testOutputCaseAndDiacriticInsensitive {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name =[cd] 'Bob'"] forMethod:_cmd];
}

- (void)testOutputNoModifier {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"age = 18"] forMethod:_cmd];
}

- (void)testOutputAnyModifier {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"ANY children.age < 18"] forMethod:_cmd];
}

- (void)testOutputAllModifier {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"ALL children.age < 18"] forMethod:_cmd];
}

- (void)testOutputNoneModifier {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"NONE children.age < 18"] forMethod:_cmd];
}

- (void)testOutputStringConstant {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = 'Bob'"] forMethod:_cmd];
}

- (void)testOutputIntegerConstant {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = 42"] forMethod:_cmd];
}

- (void)testOutputDoubleConstant {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = 3.14"] forMethod:_cmd];
}

- (void)testOutputVariable {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = $VARIABLE"] forMethod:_cmd];
}

- (void)testOutputKeyPath {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = children.parent.name"] forMethod:_cmd];
}

- (void)testOutputAggregate {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = {'X', 'Y', 'Z'}"] forMethod:_cmd];
}

- (void)testOutputAndCompoundType {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = 'Bob' AND age = 18"] forMethod:_cmd];
}

- (void)testOutputOrCompoundType {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"name = 'Bob' OR age = 18"] forMethod:_cmd];
}

- (void)testOutputNotCompoundType {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"NOT (name = 'Bob')"] forMethod:_cmd];
}

- (void)testOutputOrAndNestedCompoundType {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"(name = 'Bob' AND age = 18) OR (name = 'Steve' AND age = 21)"] forMethod:_cmd];
}

- (void)testOutputNotAndNestedCompoundType {
	[self _testPredicate:[NSPredicate predicateWithFormat:@"NOT (name = 'Bob' AND age = 18)"] forMethod:_cmd];
}


#pragma mark -
#pragma mark Input Tests

- (id)_predicateForMethod:(SEL)aMethod {
	NSString *dataKey = [NSStringFromSelector(aMethod) substringFromIndex:9];
	NSXMLDocument *document = [[NSXMLDocument alloc] initWithXMLString:[testData objectForKey:dataKey] options:0 error:NULL];
	return [NSPredicate m3_predicateWithXMLElement:[document rootElement]];
}

- (void)testInputTruePredicate {
	assertThatBool([[self _predicateForMethod:_cmd] isKindOfClass:NSClassFromString(@"NSTruePredicate")], is(equalToBool(YES)));
}

- (void)testInputFalsePredicate {
	assertThatBool([[self _predicateForMethod:_cmd] isKindOfClass:NSClassFromString(@"NSFalsePredicate")], is(equalToBool(YES)));
}

- (void)testInputEqualTo {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSEqualToPredicateOperatorType)));
}

- (void)testInputLessThan {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSLessThanPredicateOperatorType)));
}

- (void)testInputLessThanOrEqualTo {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSLessThanOrEqualToPredicateOperatorType)));
}

- (void)testInputGreaterThan {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSGreaterThanPredicateOperatorType)));
}

- (void)testInputGreaterThanOrEqualTo {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSGreaterThanOrEqualToPredicateOperatorType)));
}

- (void)testInputBetween {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSBetweenPredicateOperatorType)));
}

- (void)testInputMatches {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSMatchesPredicateOperatorType)));
}

- (void)testInputLike {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSLikePredicateOperatorType)));
}

- (void)testInputBeginsWith {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSBeginsWithPredicateOperatorType)));
}

- (void)testInputEndsWith {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSEndsWithPredicateOperatorType)));
}

- (void)testInputContains {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSContainsPredicateOperatorType)));
}

- (void)testInputIn {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.predicateOperatorType, is(equalToInteger(NSInPredicateOperatorType)));
}

- (void)testInputNoOptions {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([predicate options] == 0, is(equalToBool(YES)));
}

- (void)testInputCaseInsensitive {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([predicate options] & NSCaseInsensitivePredicateOption, is(equalToBool(YES)));
}

- (void)testInputDiacriticInsensitive {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([predicate options] & NSDiacriticInsensitivePredicateOption, is(equalToBool(YES)));
}

- (void)testInputCaseAndDiacriticInsensitive {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([predicate options] & NSDiacriticInsensitivePredicateOption && [predicate options] & NSCaseInsensitivePredicateOption, is(equalToBool(YES)));
}

- (void)testInputNoModifier {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.comparisonPredicateModifier, is(equalToInteger(NSDirectPredicateModifier)));
}

- (void)testInputAnyModifier {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.comparisonPredicateModifier, is(equalToInteger(NSAnyPredicateModifier)));
}

- (void)testInputAllModifier {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatInteger(predicate.comparisonPredicateModifier, is(equalToInteger(NSAllPredicateModifier)));
}

- (void)testInputNoneModifier {
	NSCompoundPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate subpredicates] count] == 1, is(equalToBool(YES)));
	assertThatBool([predicate compoundPredicateType] == NSNotPredicateType, is(equalToBool(YES)));
	
	assertThatInteger([predicate.subpredicates[0] comparisonPredicateModifier], is(equalToInteger(NSAnyPredicateModifier)));
}

- (void)testInputStringConstant {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate rightExpression] expressionType] == NSConstantValueExpressionType, is(equalToBool(YES)));
	assertThat(predicate.rightExpression.constantValue, is(equalTo(@"Bob")));
}

- (void)testInputIntegerConstant {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate rightExpression] expressionType] == NSConstantValueExpressionType, is(equalToBool(YES)));
	assertThat(predicate.rightExpression.constantValue, is(equalTo(@42)));
}

- (void)testInputDoubleConstant {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate rightExpression] expressionType] == NSConstantValueExpressionType, is(equalToBool(YES)));
	assertThat(predicate.rightExpression.constantValue, is(equalTo(@3.14)));
}

- (void)testInputVariable {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate rightExpression] expressionType] == NSVariableExpressionType, is(equalToBool(YES)));
	assertThat(predicate.rightExpression.variable, is(equalTo(@"VARIABLE")));
}

- (void)testInputKeyPath {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate rightExpression] expressionType] == NSKeyPathExpressionType, is(equalToBool(YES)));
	assertThat(predicate.rightExpression.keyPath, is(equalTo(@"children.parent.name")));
}

- (void)testInputAggregate {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSComparisonPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate rightExpression] expressionType] == NSAggregateExpressionType, is(equalToBool(YES)));
	NSArray *collection = [[predicate rightExpression] collection];
	assertThatBool([collection count] == 3, is(equalToBool(YES)));
	
	assertThat([collection valueForKey:@"constantValue"], contains(@"X", @"Y", @"Z", nil));
}

- (void)testInputAndCompoundType {
	NSCompoundPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate subpredicates] count] == 2, is(equalToBool(YES)));
	assertThatBool([predicate compoundPredicateType] == NSAndPredicateType, is(equalToBool(YES)));
}

- (void)testInputOrCompoundType {
	NSCompoundPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate subpredicates] count] == 2, is(equalToBool(YES)));
	assertThatBool([predicate compoundPredicateType] == NSOrPredicateType, is(equalToBool(YES)));
}

- (void)testInputNotCompoundType {
	NSCompoundPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate subpredicates] count] == 1, is(equalToBool(YES)));
	assertThatBool([predicate compoundPredicateType] == NSNotPredicateType, is(equalToBool(YES)));
}

- (void)testInputOrAndNestedCompoundType {
	NSCompoundPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate subpredicates] count] == 2, is(equalToBool(YES)));
	assertThatBool([predicate compoundPredicateType] == NSOrPredicateType, is(equalToBool(YES)));
	
	for (NSCompoundPredicate *subpredicate in [predicate subpredicates]) {
		assertThatBool([subpredicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
		assertThatBool([[subpredicate subpredicates] count] == 2, is(equalToBool(YES)));
		assertThatBool([subpredicate compoundPredicateType] == NSAndPredicateType, is(equalToBool(YES)));
	}
}

- (void)testInputNotAndNestedCompoundType {
	NSCompoundPredicate *predicate = [self _predicateForMethod:_cmd];
	assertThatBool([predicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
	assertThatBool([[predicate subpredicates] count] == 1, is(equalToBool(YES)));
	assertThatBool([predicate compoundPredicateType] == NSNotPredicateType, is(equalToBool(YES)));
	
	for (NSCompoundPredicate *subpredicate in [predicate subpredicates]) {
		assertThatBool([subpredicate isKindOfClass:[NSCompoundPredicate class]], is(equalToBool(YES)));
		assertThatBool([[subpredicate subpredicates] count] == 2, is(equalToBool(YES)));
		assertThatBool([subpredicate compoundPredicateType] == NSAndPredicateType, is(equalToBool(YES)));
	}
}

@end
