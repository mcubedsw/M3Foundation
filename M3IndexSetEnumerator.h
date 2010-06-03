/*****************************************************************
M3IndexSetEnumerator.h
M3Extensions

Created by Martin Pilkington on 27/07/2009.

Copyright (c) 2006-2010 M Cubed Software

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

#import <Cocoa/Cocoa.h>

/**
 @class M3IndexSetEnumerator
 Simplifies the enumeration of NSIndexSet
 @since Available in M3Foundation 1.0 and later
 */
@interface M3IndexSetEnumerator : NSObject {
	NSUInteger currentIndex;
	NSInteger remainingIndexes;
	NSIndexSet *indexSet;
	BOOL isAscending;
}

/**
 Returns a newly initialised enumerator that will travel forwards through the index set
 @param anIndexSet The index set to enumerate
 @return A newly initialised enumerator
 @since Available in M3Foundation 1.0 and later
 */
+ (M3IndexSetEnumerator *)enumeratorWithIndexSet:(NSIndexSet *)anIndexSet;

/**
 Returns a newly initialised enumerator that will travel backwards through the index set
 @param anIndexSet The index set to enumerate
 @return A newly initialised enumerator
 @since Available in M3Foundation 1.0 and later
 */
+ (M3IndexSetEnumerator *)reverseEnumeratorWithIndexSet:(NSIndexSet *)anIndexSet;

/**
 Initialises an enumerator with the supplied set and direction
 @param anIndexSet The index set to enumerate
 @param asc YES if the enumerator should travel forwards, NO if it should travel backwards through the index set
 @return A newly initialised enumerator
 @since Available in M3Foundation 1.0 and later
 */
- (id)initWithIndexSet:(NSIndexSet *)anIndexSet ascending:(BOOL)asc;

/**
 Returns the next index from the set
 @return The next index in the set, or NSNotFound if the end of the set is reached
 @since Available in M3Foundation 1.0 and later
 */
- (NSUInteger)nextIndex;

/**
 Resets the internal state of the enumerator back to its initial state
 @since Available in M3Foundation 1.0 and later
 */
- (void)reset;

@end
