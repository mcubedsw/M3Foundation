/*****************************************************************
M3AccessibilityController.h
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


extern NSString *M3AccessibilityErrorDomain;

@class M3AccessibleUIElement;

/***************************
 A central controller for the accessibility APIs
 @since M3Foundation 1.0 and later
 ***************************/
@interface M3AccessibilityController : NSObject

/***************************
 Checks if the accessibility APIs are enabled.
 @result Returns YES if accessibility is enabled, otherwise NO
 @since M3Foundation 1.0 and later
 ***************************/
@property (readonly, getter = isAccessibilityEnabled) BOOL accessibilityEnabled;

/***************************
 Returns an accessibility element representing the current frontmost application.
 @result Returns an accessibility element for the active application
 @since M3Foundation 1.0 and later
 ***************************/
- (M3AccessibleUIElement *)elementForActiveApplication;

/***************************
 Returns an accessibility element representing the application with the supplied process id
 @param aProcessID The process ID of the application
 @result The accessibility element for the application with the supplied process id
 @since M3Foundation 1.0 or later
 **************************/
- (M3AccessibleUIElement *)elementForApplicationWithPid:(pid_t)aProcessID;

/***************************
 Returns the system wide element, which represents no single application.
 @result Returns the system wide element
 @since M3Foundation 1.0 and later
 ***************************/
@property (readonly, strong) M3AccessibleUIElement *systemWideElement;

/***************************
 Finds the element at the supplied point.
 @param point The point at which to look for the UI element in screen co-ordinates
 @param error A pointer to an NSError
 @result The UI element at the supplied point, if one exists
 @since M3Foundation 1.0 and later
 ***************************/
- (M3AccessibleUIElement *)elementAtPosition:(NSPoint)point error:(NSError **)error;

/***************************
 Returns the NSError object for the supplied error code
 @param code The error code to create the error for
 @result The NSError object for the supplied code
 @since M3Foundation 1.0 and later
 ***************************/
- (NSError *)errorForCode:(NSInteger)code;

@end
