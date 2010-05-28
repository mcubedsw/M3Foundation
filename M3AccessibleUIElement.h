/*****************************************************************
 M3AccessibleUIElement.h
 M3Extensions
 
 Created by Martin Pilkington on 03/11/2009.
 
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


@interface M3AccessibleUIElement : NSObject <NSCopying> {
	AXUIElementRef element;
}

@property (readonly) AXUIElementRef element;

- (id)initWithElement:(AXUIElementRef)newElement;

- (NSString *)desecriptionForAction:(NSString *)action error:(NSError **)error;
- (NSArray *)actionNamesAndError:(NSError **)error;
- (NSArray *)attributeNamesAndError:(NSError **)error;
- (id)valueForAttribute:(NSString *)attribute error:(NSError **)error;
- (id)valuesForAttribute:(NSString *)attribute inRange:(NSRange)range error:(NSError **)error;
- (BOOL)isAttributeSettable:(NSString *)str error:(NSError **)error;
- (void)performAction:(NSString *)action error:(NSError **)error;
- (void)postKeyboardEventWithKeyCharacter:(CGCharCode)keyChar virtualKey:(CGKeyCode)virtualKey keyDown:(BOOL)keyDown error:(NSError **)error;
- (void)setValue:(id)value forAttribute:(NSString *)attribute error:(NSError **)error;
- (NSString *)path;
- (pid_t)processIDAndError:(NSError **)error;

@end
