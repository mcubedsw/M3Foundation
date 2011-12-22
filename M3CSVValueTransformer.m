/*****************************************************************
 M3CSVValueTransformer.m
 M3Foundation
 
 Created by Martin Pilkington on 02/08/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3CSVValueTransformer.h"


@implementation M3CSVValueTransformer

//*****//
+ (Class)transformedValueClass {
    return [NSString class];
}

//*****//
+ (BOOL)allowsReverseTransformation {
    return YES;
}

//*****//
- (id)transformedValue:(id)value {
	if ([value isKindOfClass:[NSString class]]) {
		if ([value length])
			return [value componentsSeparatedByString:@","];
	}
	return nil;
}

//*****//
- (id)reverseTransformedValue:(id)value {
	if ([value isKindOfClass:[NSArray class]]) {
		if ([value count])
			return [value componentsJoinedByString:@","];
	}
	return nil;
}

@end
