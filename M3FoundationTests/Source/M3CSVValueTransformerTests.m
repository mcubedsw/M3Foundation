/*****************************************************************
 M3CSVValueTransformerTests.m
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3CSVValueTransformerTests.h"
#import <M3Foundation/M3Foundation.h>

@implementation M3CSVValueTransformerTests

- (void)testForwardTransform {
	M3CSVValueTransformer *transform = [[M3CSVValueTransformer alloc] init];
	NSArray *expectedArray = [NSArray arrayWithObjects:@"42", @"possums", @"went", @"on", @"holiday", nil];
	assertThat([transform transformedValue:@"42,possums,went,on,holiday"], is(equalTo(expectedArray)));
}

- (void)testReverseTransform {
	M3CSVValueTransformer *transform = [[M3CSVValueTransformer alloc] init];
	NSArray *componentsArray = [NSArray arrayWithObjects:@"42", @"possums", @"went", @"on", @"holiday", nil];
	assertThat([transform reverseTransformedValue:componentsArray], is(equalTo(@"42,possums,went,on,holiday")));
}

@end
