//
//  NSPredicate+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 31/03/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSPredicate+M3Extensions.h"

@interface NSPredicate (M3ExtensionsPrivate) 

@end



@implementation NSPredicate (M3Extensions)

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

- (NSXMLElement *)m3_xmlRepresentation {
	if ([self isKindOfClass:NSClassFromString(@"NSTruePredicate")]) {
		return [NSXMLElement elementWithName:@"truePredicate"];
	} else if ([self isKindOfClass:NSClassFromString(@"NSFalsePredicate")]) {
		return [NSXMLElement elementWithName:@"falsePredicate"];
	}
	return nil;
}

@end
