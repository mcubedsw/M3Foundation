//
//  M3KeyValueObserving.m
//  Storyboards
//
//  Created by Martin Pilkington on 10/07/2010.
//  Copyright 2010 M Cubed Software. All rights reserved.
//

#import "M3KeyValueObserving.h"


@implementation NSObject (M3KeyValueObserving)

- (void)m3_addObserver:(NSObject *)observer forKeyPathsInArray:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context {
	for (NSString *path in keyPaths) {
		[self addObserver:observer forKeyPath:path options:options context:context];
	}
}

- (void)m3_removeObserver:(NSObject *)observer forKeyPathsInArray:(NSArray *)keyPaths {
	for (NSString *path in keyPaths) {
		[self removeObserver:observer forKeyPath:path];
	}
}

- (void)m3_willChangeValueForKeys:(NSArray *)aKeys {
	for (NSString *key in aKeys) {
		[self willChangeValueForKey:key];
	}
}

- (void)m3_didChangeValueForKeys:(NSArray *)aKeys {
	for (NSString *key in aKeys) {
		[self didChangeValueForKey:key];
	}
}

@end
