//
//  NSObject+M3Extensions.m
//  M3Foundation
//
//  Created by Martin Pilkington on 30/03/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSObject+M3Extensions.h"

@implementation NSObject (M3Extensions)

- (void)m3_performBlock:(void (^)(void))aBlock afterDelay:(NSTimeInterval)aInterval {
	[self performSelector:@selector(_m3_performBlock:) withObject:[aBlock copy] afterDelay:aInterval];
}

- (void)_m3_performBlock:(void (^)(void))aBlock {
	aBlock();
}

@end
