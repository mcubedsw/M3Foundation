/*****************************************************************
 NSCompoundPredicate+M3Extensions.m
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
