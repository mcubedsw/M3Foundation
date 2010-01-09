//
//  M3IndexSetEnumerator.h
//  M3TableView
//
//  Created by Martin Pilkington on 27/07/2009.
//  Copyright 2009 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 @class M3IndexSetEnumerator
 @discussion Simplifies the enumeration of NSIndexSet
 */
@interface M3IndexSetEnumerator : NSObject {
	NSUInteger currentIndex;
	NSInteger remainingIndexes;
	NSIndexSet *indexSet;
	BOOL isAscending;
}

/**
 @abstract Returns a newly initialised enumerator that will travel forwards through the index set
 @param anIndexSet The index set to enumerate
 @return A newly initialised enumerator
 */
+ (M3IndexSetEnumerator *)enumeratorWithIndexSet:(NSIndexSet *)anIndexSet;

/**
 @abstract Returns a newly initialised enumerator that will travel backwards through the index set
 @param anIndexSet The index set to enumerate
 @return A newly initialised enumerator
 */
+ (M3IndexSetEnumerator *)reverseEnumeratorWithIndexSet:(NSIndexSet *)anIndexSet;

/**
 @abstract Initialises an enumerator with the supplied set and direction
 @param anIndexSet The index set to enumerate
 @param asc YES if the enumerator should travel forwards, NO if it should travel backwards through the index set
 @return A newly initialised enumerator
 */
- (id)initWithIndexSet:(NSIndexSet *)anIndexSet ascending:(BOOL)asc;

/**
 @abstract Returns the next index from the set
 @return The next index in the set, or NSNotFound if the end of the set is reached
 */
- (NSUInteger)nextIndex;

/**
 @abstract Resets the internal state of the enumerator back to its initial state
 */
- (void)reset;

@end
