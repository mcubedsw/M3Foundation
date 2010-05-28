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

@class M3AccessibleUIElement, M3DFA;
@interface M3AccessibilityController : NSObject {
	M3AccessibleUIElement *systemWideElement;

#if NS_BLOCKS_AVAILABLE
	M3DFA *automata;
#endif
}

+ (M3AccessibilityController *)defaultController;
- (BOOL)isAccessibilityEnabled;
- (M3AccessibleUIElement *)elementForActiveApplication;
- (M3AccessibleUIElement *)systemWideElement;
- (M3AccessibleUIElement *)elementAtPosition:(NSPoint)point error:(NSError **)error;

#if NS_BLOCKS_AVAILABLE
- (M3AccessibleUIElement *)elementForPath:(NSString *)path;
#endif

+ (NSError *)errorForCode:(NSInteger)code;

@end
