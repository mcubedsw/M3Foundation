//
//  NSObject+M3ExtensionsTests.m
//  M3Foundation
//
//  Created by Martin Pilkington on 15/01/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSObject+M3ExtensionsTests.h"

#import <M3Foundation/M3Foundation.h>
#import "M3TestObject.h"

@implementation NSObject_M3ExtensionsTests {
	M3TestObject *testObject;
}

- (void)setUp {
	testObject = [M3TestObject new];
}





#pragma mark -
#pragma mark -m3_replaceImplementationOfMethodWithSelector:withBlock:

- (void)test_replacesImplementationOfSelector {
	[testObject updateStoredValue];
	assertThat(testObject.storedValue, is(equalTo(@"foo")));
	
	[testObject m3_replaceImplementationOfMethodWithSelector:@selector(updateStoredValue) withBlock:^(id self) {
		[self setStoredValue:@"bar"];
	}];
	
	[testObject updateStoredValue];
	assertThat(testObject.storedValue, is(equalTo(@"bar")));
}

- (void)test_replacesImplementationOnlyOnThisInstance {
	M3TestObject *existingObject = [M3TestObject new];
	
	[testObject m3_replaceImplementationOfMethodWithSelector:@selector(updateStoredValue) withBlock:^(id self) {
		[self setStoredValue:@"bar"];
	}];
	
	M3TestObject *newObject = [M3TestObject new];
	
	[testObject updateStoredValue];
	[existingObject updateStoredValue];
	[newObject updateStoredValue];
	
	assertThat(testObject.storedValue, is(equalTo(@"bar")));
	assertThat(existingObject.storedValue, is(equalTo(@"foo")));
	assertThat(newObject.storedValue, is(equalTo(@"foo")));
}

@end
