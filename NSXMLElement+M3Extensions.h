/*****************************************************************
 NSXMLElement+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 10/05/2008.
 
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
 This category adds some convienience methods to NSXMLElement
 @since M3Foundation 1.0 and later
***************************/
@interface NSXMLElement(M3Extensions)

/***************************
 Returns the element with the supplied name, or the first element with that name
 Equivalent to [[self elementsForName:str] objectAtIndex:0]
 @param aName The name of the element
 @result The element with the supplied name
 @since M3Foundation 1.0 and later
***************************/
- (NSXMLElement *)m3_elementForName:(NSString *)aName;

@end
