//
//  M3TagListValueTransformer.m
//  Minim
//
//  Created by Martin Pilkington on 02/08/2009.
//  Copyright 2009 M Cubed Software. All rights reserved.
//

#import "M3CSVValueTransformer.h"


@implementation M3CSVValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
	if ([value isKindOfClass:[NSString class]]) {
		return [value componentsSeparatedByString:@","];
	}
	return nil;
}

- (id)reverseTransformedValue:(id)value {
	if ([value isKindOfClass:[NSArray class]]) {
		return [value componentsJoinedByString:@","];
	}
	return nil;
}

@end
