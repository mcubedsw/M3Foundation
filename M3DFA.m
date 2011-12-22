/*****************************************************************
 M3DFA.m
 M3Foundation
 
 Created by Martin Pilkington on 17/12/2009.
 
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

#import "M3DFA.h"

#if NS_BLOCKS_AVAILABLE

@interface M3DFA ()

- (NSDictionary *)parseAutomata:(NSString *)aut error:(NSError **)error;
- (id)parseRule:(NSString *)rule;

@end


@implementation M3DFA

//*****//
- (id)initWithAutomaton:(NSString *)aut error:(NSError **)error {
	if ((self = [super init])) {
		initialState = NSNotFound;
		endStates = [[NSMutableArray alloc] init];
		automata = [[self parseAutomata:aut error:&*error] retain];
	}
	return self;
}

//*****//
- (void)dealloc {
	[endStates release];
	[automata release];
	[super dealloc];
}

//*****//
- (NSDictionary *)parseAutomata:(NSString *)aut error:(NSError **)error {
	NSMutableDictionary *parsedAutomata = [NSMutableDictionary dictionary];
	[aut enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
		NSInteger split = [line rangeOfString:@":"].location;
		NSInteger state = [[line substringToIndex:split] integerValue];
		if (initialState == NSNotFound) {
			initialState = state;
		}
		NSMutableArray *transitions = [NSMutableArray array];
		
		NSString *temp = nil;
		//Get individual transitions
		for (NSString *str in [[line substringFromIndex:split+1] componentsSeparatedByString:@","]) {
			while ([str hasPrefix:@" "]) {
				str = [str substringFromIndex:1];
			}
			if ([str hasSuffix:@"\""]) {
				temp = str;
			} else if (temp) {
				[transitions addObject:[NSString stringWithFormat:@"%@,%@", temp, str]];
				temp = nil;
			} else {
				[transitions addObject:str];
			}
		}
		
		NSMutableArray *finishedTransitions = [NSMutableArray array];
		for (NSString *str in transitions) {
			str = [str stringByReplacingOccurrencesOfString:@"\">\"" withString:@"{{{{GREATERTHAN}}}}"];
			str = [str stringByReplacingOccurrencesOfString:@"\">>\"" withString:@"{{{{2GREATERTHAN}}}}"];
			str = [str stringByReplacingOccurrencesOfString:@">>" withString:@">OUTPUT"];
			NSArray *components = [str componentsSeparatedByString:@">"];
			
			NSString *rule = [components objectAtIndex:0];
			NSString *newState = nil;
			
			if ([components count] > 1) {
				newState = [components objectAtIndex:1];
			}
			
			rule = [rule stringByReplacingOccurrencesOfString:@"{{{{GREATERTHAN}}}}" withString:@"\">\""];
			rule = [rule stringByReplacingOccurrencesOfString:@"{{{{2GREATERTHAN}}}}" withString:@"\">>\""];
			
			id parsedRule = [self parseRule:rule];
			BOOL output = NO;
			if ([newState hasPrefix:@"OUTPUT"]) {
				output = YES;
				newState = [newState substringFromIndex:6];
			}
			if (parsedRule) {
				[finishedTransitions addObject:[NSDictionary dictionaryWithObjectsAndKeys:parsedRule, @"rule", [NSNumber numberWithBool:output], @"output", [NSNumber numberWithInteger:[newState integerValue]], @"newState", nil]];
			} else {
				[endStates addObject:[NSNumber numberWithInteger:state]];
			}
		}
		[parsedAutomata setObject:finishedTransitions forKey:[NSNumber numberWithInteger:state]];
	}];
	return parsedAutomata;
}

//*****//
- (id)parseRule:(NSString *)rule {
	while ([rule hasPrefix:@" "]) {
		rule = [rule substringFromIndex:1];
	}
	while ([rule hasSuffix:@" "]) {
		rule = [rule substringToIndex:[rule length]-1];
	}
	
	if ([rule isEqualToString:@"END"]) {
		return nil;
	} else if ([rule hasPrefix:@"\""] && [rule hasSuffix:@"\""]) {
		return [rule substringWithRange:NSMakeRange(1, [rule length] - 2)];
	} else if ([rule hasPrefix:@"["] && [rule hasSuffix:@"]"]) {
		NSMutableString *str = [NSMutableString stringWithString:rule];
		NSMutableCharacterSet *characterSet = [[NSMutableCharacterSet alloc] init];
		NSRange lowerCase = [str rangeOfString:@"a-z"];
		if (lowerCase.location != NSNotFound) {
			[characterSet formUnionWithCharacterSet:[NSCharacterSet lowercaseLetterCharacterSet]];
			[str deleteCharactersInRange:lowerCase];
		}
		NSRange upperCase = [str rangeOfString:@"A-Z"];
		if (upperCase.location != NSNotFound) {
			[characterSet formUnionWithCharacterSet:[NSCharacterSet uppercaseLetterCharacterSet]];
			[str deleteCharactersInRange:upperCase];
		}
		NSRange whitespace = [str rangeOfString:@"\\w"];
		if (whitespace.location != NSNotFound) {
			[characterSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
			[str deleteCharactersInRange:whitespace];
		}
		NSRange numbers = [str rangeOfString:@"0-9"];
		if (numbers.location != NSNotFound) {
			[characterSet formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
			[str deleteCharactersInRange:numbers];
		}
		

		
		
		
		[characterSet addCharactersInString:str];
		return [characterSet autorelease];
		
	} else if ([rule isEqualToString:@"."]) {
		return @"";
	}

	return rule;
}

//*****//
- (BOOL)parseString:(NSString *)str outputBlock:(void (^)(NSString *output, NSInteger state))block {
	NSInteger currentState = initialState;
	
	NSInteger index = 0;
	NSMutableString *outputString = [NSMutableString string];
	while (index < [str length]) {
		NSString *character = [str substringWithRange:NSMakeRange(index, 1)];
		NSArray *rules = [automata objectForKey:[NSNumber numberWithInteger:currentState]];
		for (NSDictionary *rule in rules) {
			id ruleObject = [rule objectForKey:@"rule"];
			NSInteger newState = [[rule objectForKey:@"newState"] integerValue];
			BOOL output = [[rule objectForKey:@"output"] boolValue];
			if ([ruleObject isKindOfClass:[NSCharacterSet class]]) {
				if ([ruleObject characterIsMember:[character characterAtIndex:0]]) {
					currentState = newState;
					if (output)
						[outputString appendString:character];
					else {
						if ([outputString length]) {
							block(outputString, currentState);
							[outputString setString:@""];
						}
					}
						
					break;
				}
			} else if ([ruleObject isEqualToString:@""]) {
				currentState = newState;
				if (output)
					[outputString appendString:character];
				else {
					if ([outputString length]) {
						block(outputString, currentState);
						[outputString setString:@""];
					}
				}
				break;
			} else if ([ruleObject isEqualToString:character]) {
				currentState = newState;
				if (output)
					[outputString appendString:character];
				else {
					if ([outputString length]) {
						block(outputString, currentState);
						[outputString setString:@""];
					}
				}
				break;
			}
		}
		index++;
	}
	return [endStates containsObject:[NSNumber numberWithInteger:currentState]];
}

@end

#endif