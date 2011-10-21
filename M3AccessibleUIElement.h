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

/**
 @class M3AccessibleUIElement
 Represents an AXUIElementRef, providing a more Cocoa like interface to it.
 @since Available in M3Foundation 1.0 and later
 */
@interface M3AccessibleUIElement : NSObject <NSCopying> {
	AXUIElementRef element;
}

/**
 @property element
 Returns the AXUIElement represented by the object
 @since Available in M3Foundation 1.0 and later
 */
@property (readonly) AXUIElementRef element;

/**
 Creates a new object with the supplied element
 @discussion The element is retained using CFRetain
 @param newElement The element to initialise the object with
 @result The initialised object
 @since Available in M3Foundation 1.0 and later
 */
- (id)initWithElement:(AXUIElementRef)newElement;

/**
 Returns the description for the supplied action
 @param action The action to get the description for
 @param error A pointer to an NSError object
 @result The action description
 @since Available in M3Foundation 1.0 and later
 */
- (NSString *)descriptionForAction:(NSString *)action error:(NSError **)error;

/**
 Returns the names of the actions on the item
 @param error A pointer to an NSError object
 @result An array of action names
 @since Available in M3Foundation 1.0 and later
 */
- (NSArray *)actionNamesAndError:(NSError **)error;

/**
 Returns the names of the attributes on the item
 @param error A pointer to an NSError object
 @result An array of attribute names
 @since Available in M3Foundation 1.0 and later
 */
- (NSArray *)attributeNamesAndError:(NSError **)error;

/**
 Returns the value for the attribute
 @param attribute The attribute to get the value of
 @param error A pointer to an NSError object
 @result The value of the supplied attribute
 @since Available in M3Foundation 1.0 and later
 */
- (id)valueForAttribute:(NSString *)attribute error:(NSError **)error;

/**
 Returns the values for the supplied attribute
 @param attribute The attribute to get
 @param range The range of values to return
 @param error A pointer to an NSError object
 @result The values for the attribute
 @since Available in M3Foundation 1.0 and later
 */
- (id)valuesForAttribute:(NSString *)attribute inRange:(NSRange)range error:(NSError **)error;

/**
 Checks if the supplied attribute is settable
 @param attribute The attribute to check
 @param error A pointer to an NSError object
 @result YES if the attribute is settable, otherwise NO
 @since Available in M3Foundation 1.0 and later
 */
- (BOOL)isAttributeSettable:(NSString *)attribute error:(NSError **)error;

/**
 Performs the supplied action
 @param action The action to perform
 @param error A pointer to an NSError object
 @since Available in M3Foundation 1.0 and later
 */
- (BOOL)performAction:(NSString *)action error:(NSError **)error;

/**
 Posts a keyboard character
 @param keyChar The key character to post
 @param virtualKey The virtual key to post
 @param keyDown The key to press
 @param error A pointer to an NSError object
 @since Available in M3Foundation 1.0 and later
 */
- (BOOL)postKeyboardEventWithKeyCharacter:(CGCharCode)keyChar virtualKey:(CGKeyCode)virtualKey keyDown:(BOOL)keyDown error:(NSError **)error;

/**
 Sets the value of the supplied attribute
 @param value The new value
 @param attribute The attribute to set
 @param error A pointer to an NSError object
 @since Available in M3Foundation 1.0 and later
 */
- (BOOL)setValue:(id)value forAttribute:(NSString *)attribute error:(NSError **)error;

/**
 Returns the process ID for the represented element
 @param error A pointer to an NSError object
 @result The process ID for the represented element
 @since Available in M3Foundation 1.0 and later
 */
- (pid_t)processIDAndError:(NSError **)error;

@end
