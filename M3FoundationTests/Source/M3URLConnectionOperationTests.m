//
//  M3URLConnectionOperationTests.m
//  M3Foundation
//
//  Created by Martin Pilkington on 15/01/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "M3URLConnectionOperationTests.h"

#import <M3Foundation/M3Foundation.h>

@implementation M3URLConnectionOperationTests

- (void)test_storesSuppliedURLRequest {
	NSURLRequest *request = [NSURLRequest new];
	M3URLConnectionOperation *operation = [[M3URLConnectionOperation alloc] initWithURLRequest:request];
	
	assertThat(operation.request, is(equalTo(request)));
}

@end
