/*****************************************************************
 M3FileSizeValueTransformerTests.m
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3FileSizeValueTransformerTests.h"
#import <M3Foundation/M3Foundation.h>

@implementation M3FileSizeValueTransformerTests

- (void)test_transformFileSizesCorrectly {
	M3FileSizeValueTransformer *transform = [[M3FileSizeValueTransformer alloc] init];
	assertThat([transform transformedValue:@(602)], is(equalTo(@"602 bytes")));
	assertThat([transform transformedValue:@(14394)], is(equalTo(@"14.39 KB")));
	assertThat([transform transformedValue:@(53545329)], is(equalTo(@"53.55 MB")));
	assertThat([transform transformedValue:@(28958816993)], is(equalTo(@"28.96 GB")));
	assertThat([transform transformedValue:@(14293651161088)], is(equalTo(@"14.29 TB")));
}

@end
