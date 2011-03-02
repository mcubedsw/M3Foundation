//
//  M3KeyValueObserving.h
//  Storyboards
//
//  Created by Martin Pilkington on 10/07/2010.
//  Copyright 2010 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (M3KeyValueObserving)

- (void)m3_addObserver:(NSObject *)observer forKeyPathsInArray:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)m3_removeObserver:(NSObject *)observer forKeyPathsInArray:(NSArray *)keyPaths;
- (void)m3_willChangeValueForKeys:(NSArray *)aKeys;
- (void)m3_didChangeValueForKeys:(NSArray *)aKeys;

@end
