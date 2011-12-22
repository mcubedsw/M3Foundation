/*****************************************************************
 M3KeyValueObserving.m
 M3Foundation
 
 Created by Martin Pilkington on 10/07/2010.
 
 Copyright © 2006-2011 M Cubed Software.
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
  
*****************************************************************/

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
