//
//  M3FileSizeValueTransformerTests.m
//  M3Foundation
//
//  Created by Martin Pilkington on 09/01/2010.
//  Copyright 2010 M Cubed Software. All rights reserved.
//

#import "M3FileSizeValueTransformerTests.h"
#import <M3Foundation/M3Foundation.h>

@implementation M3FileSizeValueTransformerTests

- (void)testTransform {
	M3FileSizeValueTransformer *transform = [[M3FileSizeValueTransformer alloc] init];
	STAssertEqualObjects(@"602 bytes", [transform transformedValue:[NSNumber numberWithInteger:602]], @"");
	STAssertEqualObjects(@"14.39 KB", [transform transformedValue:[NSNumber numberWithLong:14394]], @"");
	STAssertEqualObjects(@"53.55 MB", [transform transformedValue:[NSNumber numberWithLong:53545329]], @"");
	STAssertEqualObjects(@"28.96 GB", [transform transformedValue:[NSNumber numberWithLong:28958816993]], @"");
	STAssertEqualObjects(@"14.29 TB", [transform transformedValue:[NSNumber numberWithLong:14293651161088]], @"");
	[transform release];
}

@end
