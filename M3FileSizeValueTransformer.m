//
//  M3FileSizeValueTransformer.m
//  Minim
//
//  Created by Martin Pilkington on 16/08/2009.
//  Copyright 2009 M Cubed Software. All rights reserved.
//

#import "M3FileSizeValueTransformer.h"


@implementation M3FileSizeValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

/**
 Transforms value to the appropriate units
 */
- (id)transformedValue:(id)value {
	if ([value isKindOfClass:[NSNumber class]]) {
		double fileSize = [value doubleValue];
		NSArray *units = [NSArray arrayWithObjects:@"bytes", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", @"ZB", @"YB", nil];
		NSInteger currentIndex = 0;
		while (fileSize > 1000) {
			currentIndex++;
			fileSize /= 1000;
		}
		if (currentIndex == 0) {
			return [NSString stringWithFormat:@"%.0f %@", fileSize, [units objectAtIndex:currentIndex]];
		}
		return [NSString stringWithFormat:@"%.2f %@", fileSize, [units objectAtIndex:currentIndex]];
	}
	return nil;
}

@end
