/*****************************************************************
 NSPredicate+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 31/03/2011.
 
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

#import "NSPredicate+M3Extensions.h"


@implementation NSPredicate (M3Extensions)

//*****//
+ (NSPredicate *)m3_predicateFromXMLElement:(NSXMLElement *)aElement {
	if ([[aElement name] isEqualToString:@"truePredicate"]) {
		return [NSPredicate predicateWithValue:YES];
	} else if ([[aElement name] isEqualToString:@"falsePredicate"]) {
		return [NSPredicate predicateWithValue:NO];
	} else if ([[aElement name] isEqualToString:@"predicates"]) {
		return [NSCompoundPredicate m3_predicateFromXMLElement:aElement];
	} else if ([[aElement name] isEqualToString:@"predicate"]) {
		return [NSComparisonPredicate m3_predicateFromXMLElement:aElement];
	}
	return nil;
}

//*****//
- (NSXMLElement *)m3_xmlRepresentation {
	if ([self isKindOfClass:NSClassFromString(@"NSTruePredicate")]) {
		return [NSXMLElement elementWithName:@"truePredicate"];
	} else if ([self isKindOfClass:NSClassFromString(@"NSFalsePredicate")]) {
		return [NSXMLElement elementWithName:@"falsePredicate"];
	}
	return nil;
}

@end
