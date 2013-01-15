/*****************************************************************
 NSKeyValueObserving+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 04/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSKeyValueObserving+M3Extensions.h"


@implementation NSObject (M3KeyValueObservingExtensions)

- (void)m3_addObserver:(NSObject *)aObserver forKeyPathsInArray:(NSArray *)aKeyPaths options:(NSKeyValueObservingOptions)aOptions context:(void *)aContext {
	for (NSString *path in aKeyPaths) {
		[self addObserver:aObserver forKeyPath:path options:aOptions context:aContext];
	}
}


- (void)m3_removeObserver:(NSObject *)aObserver forKeyPathsInArray:(NSArray *)aKeyPaths {
	for (NSString *path in aKeyPaths) {
		[self removeObserver:aObserver forKeyPath:path];
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
