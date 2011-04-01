//
//  NSObject+M3Extensions.h
//  M3Foundation
//
//  Created by Martin Pilkington on 30/03/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (M3Extensions)

- (void)m3_performBlock:(void (^)(void))aBlock afterDelay:(NSTimeInterval)aInterval;

@end
