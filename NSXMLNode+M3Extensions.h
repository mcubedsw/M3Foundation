/*****************************************************************
 NSXMLNode+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 19/03/2010.
 
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
 Extensions to NSXMLNode to simplify accessing data
 @since PROJECT_NAME VERSION_NAME or later
 **************************/
@interface NSXMLNode (M3Extensions)

/***************************
 The integer value of the node
 @since PROJECT_NAME VERSION_NAME or later
 **************************/
@property (readonly) NSInteger m3_integerValue;

/***************************
 The float value of the node
 @since PROJECT_NAME VERSION_NAME or later
 **************************/
@property (readonly) CGFloat m3_floatValue;

/***************************
 Return the first matching node for an xPath
 @param aXPath The XPath to use for searching
 @param aError A point to an error
 @return The first matching XML node, or nil if an error occurs
 @since PROJECT_NAME VERSION_NAME or later
 **************************/
- (NSXMLNode *)m3_nodeForXPath:(NSString *)aXPath error:(NSError **)aError;

@end
