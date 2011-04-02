//
//  NSPredicate+M3ExtensionsTests.m
//  M3Foundation
//
//  Created by Martin Pilkington on 31/03/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

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
	STAssertEqualObjects(xmlString, dataString, @"Predicate XML did not match.");
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
	return [NSPredicate m3_predicateFromXMLElement:[document rootElement]];
}

- (void)testInputTruePredicate {
	STAssertTrue([[self _predicateForMethod:_cmd] isKindOfClass:NSClassFromString(@"NSTruePredicate")], @"Parsed predicate isn't a true predicate");
}

- (void)testInputFalsePredicate {
	STAssertTrue([[self _predicateForMethod:_cmd] isKindOfClass:NSClassFromString(@"NSFalsePredicate")], @"Parsed predicate isn't a false predicate");
}

- (void)testInputEqualTo {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	STAssertTrue([predicate isKindOfClass:[NSComparisonPredicate class]], @"Parsed predicate isn't a comparison predicate");
	STAssertTrue([predicate predicateOperatorType] == NSEqualToPredicateOperatorType, @"Parsed predicate isn't an equal to predicate");
}

- (void)testInputLessThan {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	STAssertTrue([predicate isKindOfClass:[NSComparisonPredicate class]], @"Parsed predicate isn't a comparison predicate");
	STAssertTrue([predicate predicateOperatorType] == NSLessThanPredicateOperatorType, @"Parsed predicate isn't a less than predicate");
}

- (void)testInputLessThanOrEqualTo {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	STAssertTrue([predicate isKindOfClass:[NSComparisonPredicate class]], @"Parsed predicate isn't a comparison predicate");
	STAssertTrue([predicate predicateOperatorType] == NSLessThanOrEqualToPredicateOperatorType, @"Parsed predicate isn't a less than or equal to predicate");
}

- (void)testInputGreaterThan {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	STAssertTrue([predicate isKindOfClass:[NSComparisonPredicate class]], @"Parsed predicate isn't a comparison predicate");
	STAssertTrue([predicate predicateOperatorType] == NSGreaterThanPredicateOperatorType, @"Parsed predicate isn't a greater than predicate");
}

- (void)testInputGreaterThanOrEqualTo {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	STAssertTrue([predicate isKindOfClass:[NSComparisonPredicate class]], @"Parsed predicate isn't a comparison predicate");
	STAssertTrue([predicate predicateOperatorType] == NSGreaterThanOrEqualToPredicateOperatorType, @"Parsed predicate isn't a greater than or equal to predicate");
}

- (void)testInputBetween {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	STAssertTrue([predicate isKindOfClass:[NSComparisonPredicate class]], @"Parsed predicate isn't a comparison predicate");
	STAssertTrue([predicate predicateOperatorType] == NSBetweenPredicateOperatorType, @"Parsed predicate isn't a between predicate");
}

- (void)testInputMatches {
	NSComparisonPredicate *predicate = [self _predicateForMethod:_cmd];
	STAssertTrue([predicate isKindOfClass:[NSComparisonPredicate class]], @"Parsed predicate isn't a comparison predicate");
	STAssertTrue([predicate predicateOperatorType] == NSMatchesPredicateOperatorType, @"Parsed predicate isn't a matches predicate");
}

- (void)testInputLike {
	
}

- (void)testInputBeginsWith {
	
}

- (void)testInputEndsWith {
	
}

- (void)testInputContains {
	
}

- (void)testInputIn {
	
}

- (void)testInputNoOptions {
	
}

- (void)testInputCaseInsensitive {
	
}

- (void)testInputDiacriticInsensitive {
	
}

- (void)testInputCaseAndDiacriticInsensitive {
	
}

- (void)testInputNoModifier {
	
}

- (void)testInputAnyModifier {
	
}

- (void)testInputAllModifier {
	
}

- (void)testInputNoneModifier {
	
}

- (void)testInputStringConstant {
	
}

- (void)testInputIntegerConstant {
	
}

- (void)testInputDoubleConstant {
	
}

- (void)testInputVariable {
	
}

- (void)testInputKeyPath {
	
}

- (void)testInputAggregate {
	
}

- (void)testInputAndCompoundType {
	
}

- (void)testInputOrCompoundType {
	
}

- (void)testInputNotCompoundType {
	
}

- (void)testInputOrAndNestedCompoundType {
	
}

- (void)testInputNotAndNestedCompoundType {
	
}

@end
