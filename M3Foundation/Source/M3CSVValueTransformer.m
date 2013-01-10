/*****************************************************************
 M3CSVValueTransformer.m
 M3Foundation
 
 Created by Martin Pilkington on 02/08/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3CSVValueTransformer.h"


@implementation M3CSVValueTransformer


+ (Class)transformedValueClass {
    return [NSString class];
}


+ (BOOL)allowsReverseTransformation {
    return YES;
}


- (id)transformedValue:(id)aValue {
	if (![aValue isKindOfClass:[NSString class]]) {
		return nil;
	}
	if (![aValue length]) {
		return nil;
	}
	return [aValue componentsSeparatedByString:@","];
}


- (id)reverseTransformedValue:(id)aValue {
	if (![aValue isKindOfClass:[NSArray class]]) {
		return nil;
	}
	if(![aValue count]) {
		return nil;
	}
	return [aValue componentsJoinedByString:@","];
}

@end
