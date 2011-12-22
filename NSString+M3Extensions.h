/*****************************************************************
 NSString+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 09/09/2006.
 
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

#import <Cocoa/Cocoa.h>

/***************************
 This category adds some convienience methods to NSString
 @since Available in M3Foundation 1.0 and later
***************************/
@interface NSString(M3Extensions) 

/***************************
 Returns a string with the specified number of characters removed from the end
 @param number The number of characters to be removed from the end of the string
 @result Returns an NSString object with with the specified number of characters are removed
 @since M3Foundation 1.0 and later
***************************/
- (NSString *)m3_stringByRemovingCharactersFromEnd:(NSUInteger)aNumber;

/***************************
 Finds whether the string contains the supplied substring
 @param subString The string to test for
 @result Returns true if the string contains subString
 @since M3Foundation 1.0 and later
***************************/
- (BOOL)m3_containsString:(NSString *)aSubString;

@end
