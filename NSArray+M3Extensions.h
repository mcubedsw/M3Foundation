/*****************************************************************
NSArray+M3Extensions.h
M3Extensions

Created by Martin Pilkington on 10/09/2006.

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
 @category NSArray(M3Extensions)
 This category adds some useful class methods for generating and accessing arrays.
 @since Available in M3Foundation 1.0 and later
 */
@interface NSArray(M3Extensions)

/**
 Creates and returns an array with strings for 0-9 a-z.
 @result An array containing strings for 0-9, a-z.
 @since Available in M3Foundation 1.0 and later
 */
+ (NSArray *)m3_alphaNumericArray;

/**
 Creates and returns an array or NSNumber objects increasing from minValue to maxValue in integer increments.
 If minValue is greater than maxValue then nil will be returned.
 @param maxValue The maximum value in the array
 @param minValue The minimum value in the array
 @result An array containing NSNumbers for the supplied values, or nil on error.
@since Available in M3Foundation 1.0 and later
 */
+ (NSArray *)m3_arrayWithNumbersTo:(NSInteger)maxValue from:(NSInteger)minValue;

/**
 A safer version of objectAtIndex: which returns nil for an out of bounds index.
 @param aIndex The index of the object to retrieve 
 @result The object at the supplied index, or nil if the index is out of bounds
 @since Available in M3Foundation 1.0 and later
 */
- (id)m3_safeObjectAtIndex:(NSUInteger)aIndex;


- (id)m3_objectPassingTest:(BOOL (^)(id aObj))aTest;


@end