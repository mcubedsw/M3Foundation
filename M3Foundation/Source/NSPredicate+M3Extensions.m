/*****************************************************************
 NSPredicate+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 31/03/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSPredicate+M3Extensions.h"


@implementation NSPredicate (M3Extensions)

+ (NSPredicate *)m3_predicateWithXMLElement:(NSXMLElement *)aElement {
	if ([aElement.name isEqualToString:@"truePredicate"]) {
		return [NSPredicate predicateWithValue:YES];
	} else if ([aElement.name isEqualToString:@"falsePredicate"]) {
		return [NSPredicate predicateWithValue:NO];
	} else if ([aElement.name isEqualToString:@"predicates"]) {
		return [NSCompoundPredicate m3_predicateWithXMLElement:aElement];
	} else if ([aElement.name isEqualToString:@"predicate"]) {
		return [NSComparisonPredicate m3_predicateWithXMLElement:aElement];
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
