/*****************************************************************
 M3FileSizeValueTransformer.m
 M3Foundation
 
 Created by Martin Pilkington on 16/08/2009.
 
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

#import "M3FileSizeValueTransformer.h"


@implementation M3FileSizeValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

/***************************
 Transforms value to the appropriate units
***************************/
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
