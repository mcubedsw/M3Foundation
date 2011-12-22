/*****************************************************************
 NSObject+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 30/03/2011.
 
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

#import "NSObject+M3Extensions.h"
#import <objc/runtime.h>

@implementation NSObject (M3Extensions)

#pragma mark -
#pragma mark Perform blocks

//*****//
- (void)m3_performBlock:(void (^)(void))aBlock afterDelay:(NSTimeInterval)aInterval {
	[self performSelector:@selector(_m3_performBlock:) withObject:[aBlock copy] afterDelay:aInterval];
}

//*****//
- (void)m3_performBlock:(void (^)(void))aBlock afterDelay:(NSTimeInterval)aInterval inModes:(NSArray *)aArray {
	[self performSelector:@selector(_m3_performBlock:) withObject:[aBlock copy] afterDelay:aInterval inModes:aArray];
}

//*****//
- (void)_m3_performBlock:(void (^)(void))aBlock {
	aBlock();
}





#pragma mark -
#pragma mark Manipulating objects

//*****//
- (BOOL)m3_replaceImplementationOfMethodWithSelector:(SEL)aSelector with:(void *)aBlock {
	NSString *className = NSStringFromClass([self class]);
	NSArray *nameComponents = [className componentsSeparatedByString:@"_"];
	//Check if we're already a singleton
	if (![[nameComponents lastObject] hasPrefix:@"m3singleton"]) {
		//If not then get the subclass name to use
		NSString *newClassNamePrefix = [NSString stringWithFormat:@"%@_m3singleton", className];
		NSString *newClassName = newClassNamePrefix;
		NSInteger classNumber = 0;
		//While the class name is registered try the next number
		while (objc_getClass([newClassName cStringUsingEncoding:NSUTF8StringEncoding])) {
			classNumber++;
			newClassName = [NSString stringWithFormat:@"%@%d", newClassName, classNumber];
		}
		
		//Register the class with the runtime and then change our class
		const char *name = [newClassName cStringUsingEncoding:NSUTF8StringEncoding];
		Class newSubclass = objc_allocateClassPair([self class], name, 0);
		objc_registerClassPair(newSubclass);
		object_setClass(self, newSubclass);
	}
	IMP newIMP = imp_implementationWithBlock(aBlock);
	Method methodToReplace = class_getInstanceMethod([self class], aSelector);
	return class_addMethod([self class], aSelector, newIMP, method_getTypeEncoding(methodToReplace));
}





#pragma mark -
#pragma mark Key Value Observing

//*****//
- (void)m3_addObserver:(NSObject *)observer forKeyPathsInArray:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context {
	for (NSString *path in keyPaths) {
		[self addObserver:observer forKeyPath:path options:options context:context];
	}
}

//*****//
- (void)m3_removeObserver:(NSObject *)observer forKeyPathsInArray:(NSArray *)keyPaths {
	for (NSString *path in keyPaths) {
		[self removeObserver:observer forKeyPath:path];
	}
}

//*****//
- (void)m3_willChangeValueForKeys:(NSArray *)aKeys {
	for (NSString *key in aKeys) {
		[self willChangeValueForKey:key];
	}
}

//*****//
- (void)m3_didChangeValueForKeys:(NSArray *)aKeys {
	for (NSString *key in aKeys) {
		[self didChangeValueForKey:key];
	}
}

@end
