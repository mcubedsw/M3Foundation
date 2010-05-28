/*****************************************************************
 M3AccessibilityController.m
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

#import "M3AccessibilityController.h"
#import "M3AccessibleUIElement.h"
#import "M3DFA.h"

static M3AccessibilityController *defaultController;
@implementation M3AccessibilityController

/**
 Return the default accessibility controller
 */
+ (M3AccessibilityController *)defaultController {
	if (!defaultController) {
		defaultController = [[M3AccessibilityController alloc] init];
	}
	return defaultController;
}

- (id)init {
	if (self = [super init]) {
		NSString *dfa = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AXPathDFA" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
		
#if NS_BLOCKS_AVAILABLE
		automata = [[M3DFA alloc] initWithAutomata:dfa error:NULL];
#endif
	}
	return self;
}

- (void)dealloc {
	[systemWideElement release];
	[super dealloc];
}

/**
 Returns YES if support for assistive devices is enabled in system prefs
 */
- (BOOL)isAccessibilityEnabled {
	return (BOOL)AXAPIEnabled();
}


- (M3AccessibleUIElement *)elementForActiveApplication {
	pid_t processid = (pid_t)[[[[NSWorkspace sharedWorkspace] activeApplication] objectForKey:@"NSApplicationProcessIdentifier"] integerValue];
	return [[[M3AccessibleUIElement alloc] initWithElement:AXUIElementCreateApplication(processid)] autorelease];
}

- (M3AccessibleUIElement *)elementForApplicationWithPid:(pid_t)processid {
	return [[[M3AccessibleUIElement alloc] initWithElement:AXUIElementCreateApplication(processid)] autorelease];
}

/**
 Return the system wide accessibility element
 */
- (M3AccessibleUIElement *)systemWideElement {
	if (!systemWideElement) {
		systemWideElement = [[M3AccessibleUIElement alloc] initWithElement:AXUIElementCreateSystemWide()];
	}
	return [[systemWideElement retain] autorelease];
}

#if NS_BLOCKS_AVAILABLE

- (M3AccessibleUIElement *)elementForPath:(NSString *)path {
	NSMutableArray *components = [NSMutableArray array];
	__block NSString *latestKey = nil;
	__block CGFloat x = 0;
	[automata parseString:path outputBlock:^(NSString *output, NSInteger state) {
		if (state == 3) { //Role
			[components addObject:[NSMutableDictionary dictionaryWithObject:[output copy] forKey:kAXRoleAttribute]];
		} else if (state == 5) { //Key
			while ([output hasPrefix:@" "]) {
				output = [output substringFromIndex:1];
			}
			latestKey = [output copy];
		} else if (state == 10) { //PosX
			x = [output floatValue];
		} else if (state == 11) { //PosY
			[[components lastObject] setObject:[NSValue valueWithPoint:CGPointMake(x, [output floatValue])] forKey:latestKey];
		} else if (state == 4) { //Number
			[[components lastObject] setObject:[NSNumber numberWithInteger:[output integerValue]] forKey:latestKey];
		} else if (state == 7) { //String
			if (latestKey)
				[[components lastObject] setObject:[output copy] forKey:latestKey];
		} else if (state == 12) { //String or Number
			NSInteger value = [output integerValue];
			if (value == 0 && ![output isEqualToString:@"0"]) {
				if (latestKey)
					[[components lastObject] setObject:[output copy] forKey:latestKey];
			} else {
				[[components lastObject] setObject:[NSNumber numberWithInteger:[output integerValue]] forKey:latestKey];
			}
		}
	}];
	
	M3AccessibleUIElement *currentElement = nil;
	for (NSDictionary *dict in components) {
		if ([[dict objectForKey:kAXRoleAttribute] isEqualToString:kAXApplicationRole]) {
			pid_t processid = [[[NSRunningApplication runningApplicationsWithBundleIdentifier:[dict objectForKey:@"bundle"]] objectAtIndex:0] processIdentifier];
			currentElement = [self elementForApplicationWithPid:processid];
		} else {
			NSMutableArray *candidates = [NSMutableArray arrayWithArray:[currentElement valueForAttribute:kAXChildrenAttribute error:NULL]];
			
			NSArray *keys = [NSArray arrayWithObjects:kAXRoleAttribute, kAXSubroleAttribute, kAXTitleAttribute, @"childCount", @"index", kAXPositionAttribute, nil];
			
			for (NSString *key in keys) {
				NSArray *candidateCopy = [candidates copy];
				for (M3AccessibleUIElement *element in candidateCopy) {
					id object = [dict objectForKey:key];
					if (object != nil) {
						if ([key isEqualToString:@"childCount"]) {
							if ([object integerValue] != [[element valueForAttribute:kAXChildrenAttribute error:NULL] count]) {
								[candidates removeObject:element];
							}
						} else if ([key isEqualToString:@"index"]) {
							M3AccessibleUIElement *parent = [element valueForAttribute:kAXParentAttribute error:NULL];
							if ([object integerValue] != [[parent valueForAttribute:kAXChildrenAttribute error:NULL] indexOfObject:element]) {
								[candidates removeObject:element];
							}
						} else if ([key isEqualToString:kAXTitleAttribute]) {
							if (![[element valueForAttribute:key error:NULL] isEqual:object]) {
								if (![[[[element valueForAttribute:kAXTitleUIElementAttribute error:NULL] valueForAttribute:kAXValueAttribute error:NULL] description] isEqual:object]) {
									[candidates removeObject:element];
								}
							}
						} else {
							if (![[element valueForAttribute:key error:NULL] isEqual:object]) {
								[candidates removeObject:element];
							}
						}
					}
				}
				if ([candidates count] == 1)
					break;
				if ([candidates count] == 0) {
					[candidates addObjectsFromArray:candidateCopy];
				}
			}
			
			if ([candidates count] == 1) {
				currentElement = [candidates objectAtIndex:0];
			}
			
		}
	}
	return currentElement;
}

#endif

- (M3AccessibleUIElement *)elementAtPosition:(NSPoint)point error:(NSError **)error {
	AXUIElementRef element = NULL;
	AXError errorCode = AXUIElementCopyElementAtPosition([[self systemWideElement] element], point.x, point.y, &element);
	
	*error = [M3AccessibilityController errorForCode:errorCode];
	return [[M3AccessibleUIElement alloc] initWithElement:element];
}




/**
 Generate an NSError for the supplied code
 */
+ (NSError *)errorForCode:(NSInteger)code {
	if (code == kAXErrorSuccess) {
		return nil;
	} else if (code == kAXErrorFailure) {
		return nil;
	} else if (code == kAXErrorIllegalArgument) {
		return nil;
	} else if (code == kAXErrorInvalidUIElement) {
		return nil;
	} else if (code == kAXErrorInvalidUIElementObserver) {
		return nil;
	} else if (code == kAXErrorCannotComplete) {
		return nil;
	} else if (code == kAXErrorAttributeUnsupported) {
		return nil;
	} else if (code == kAXErrorActionUnsupported) {
		return nil;
	} else if (code == kAXErrorNotificationUnsupported) {
		return nil;
	} else if (code == kAXErrorNotImplemented) {
		return nil;
	} else if (code == kAXErrorNotificationAlreadyRegistered) {
		return nil;
	} else if (code == kAXErrorNotificationNotRegistered) {
		return nil;
	} else if (code == kAXErrorAPIDisabled) {
		return nil;
	} else if (code == kAXErrorNoValue) {
		return nil;
	} else if (code == kAXErrorParameterizedAttributeUnsupported) {
		return nil;
	} else if (code == kAXErrorNotEnoughPrecision) {
		return nil;
	}
	return nil;
}


@end
