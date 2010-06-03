/*****************************************************************
NSMutableArray+M3Extensions.h
M3Extensions

Created by Martin Pilkington on 21/05/2010.

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

#import <Foundation/Foundation.h>

/**
 @category NSMutableArray(M3Extensions)
 This category adds more ways of re-arranging objects in a mutable array
 @since Available in M3Foundation 1.0 and later
 */
@interface NSMutableArray(M3Extensions)

/**
 Moves the supplied object to the new index
 <b>Discussion</b>
 If the object doesn't exist in the array, this acts just like addObject: or insertObject:atIndex: depending on whether the index is outside the bounds of the array
 @param aObject The object to move
 @param aIndex The index to move it to

 @since Available in M3Foundation 1.0 and later
 */
- (void)m3_moveObject:(id)aObject toIndex:(NSUInteger)aIndex;

@end
