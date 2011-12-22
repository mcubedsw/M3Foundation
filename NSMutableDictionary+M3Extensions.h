/*****************************************************************
 NSMutableDictionary+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 15/04/2011.
 
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

#import <Foundation/Foundation.h>

/***************************
 This category adds methods to simplify working with dictionaries
 @since M3Foundation 1.0 or later
 **************************/
@interface NSMutableDictionary (M3Extensions)

/***************************
 Adds an object to the dictionary, ignoring nil if passed in as the object
 @param aObj The object to add
 @param aKey The key to use for the object
 @since M3Foundation 1.0 or later
 **************************/
- (void)m3_safeSetObject:(id)aObj forKey:(id)aKey;

@end
