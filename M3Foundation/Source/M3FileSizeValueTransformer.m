/*****************************************************************
 M3FileSizeValueTransformer.m
 M3Foundation
 
 Created by Martin Pilkington on 16/08/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3FileSizeValueTransformer.h"


@implementation M3FileSizeValueTransformer

//*****//
+ (Class)transformedValueClass {
    return [NSString class];
}

//*****//
+ (BOOL)allowsReverseTransformation {
    return NO;
}

//*****//
- (id)transformedValue:(id)aValue {
	if (![aValue isKindOfClass:[NSNumber class]]) {
		return nil;
	}
	
	double fileSize = [aValue doubleValue];
	NSArray *units = @[ @"bytes", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", @"ZB", @"YB" ];
	NSInteger currentIndex = 0;
	while (fileSize > 1000) {
		currentIndex++;
		fileSize /= 1000;
	}
	if (currentIndex == 0) {
		return [NSString stringWithFormat:@"%.0f %@", fileSize, units[currentIndex]];
	}
	return [NSString stringWithFormat:@"%.2f %@", fileSize, units[currentIndex]];
}

@end
