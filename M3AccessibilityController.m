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


NSString *M3AccessibilityErrorDomain = @"com.mcubedsw.M3Foundation.accessibility";

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
#if NS_BLOCKS_AVAILABLE
		NSString *dfa = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AXPathDFA" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
		automata = [[M3DFA alloc] initWithAutomaton:dfa error:NULL];
#endif
	}
	return self;
}

- (void)dealloc {
	[systemWideElement release];
#if NS_BLOCKS_AVAILABLE
	[automata release];
#endif
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
			[components addObject:[NSMutableDictionary dictionaryWithObject:[output copy] forKey:(NSString *)kAXRoleAttribute]];
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
		if ([[dict objectForKey:(NSString *)kAXRoleAttribute] isEqualToString:(NSString *)kAXApplicationRole]) {
			pid_t processid = [[[NSRunningApplication runningApplicationsWithBundleIdentifier:[dict objectForKey:@"bundle"]] objectAtIndex:0] processIdentifier];
			currentElement = [self elementForApplicationWithPid:processid];
		} else {
			NSMutableArray *candidates = [NSMutableArray arrayWithArray:[currentElement valueForAttribute:(NSString *)kAXChildrenAttribute error:NULL]];
			
			NSArray *keys = [NSArray arrayWithObjects:(NSString *)kAXRoleAttribute, kAXSubroleAttribute, kAXTitleAttribute, @"childCount", @"index", kAXPositionAttribute, nil];
			
			for (NSString *key in keys) {
				NSArray *candidateCopy = [candidates copy];
				for (M3AccessibleUIElement *element in candidateCopy) {
					id object = [dict objectForKey:key];
					if (object != nil) {
						if ([key isEqualToString:@"childCount"]) {
							if ([object integerValue] != [[element valueForAttribute:(NSString *)kAXChildrenAttribute error:NULL] count]) {
								[candidates removeObject:element];
							}
						} else if ([key isEqualToString:@"index"]) {
							M3AccessibleUIElement *parent = [element valueForAttribute:(NSString *)kAXParentAttribute error:NULL];
							if ([object integerValue] != [[parent valueForAttribute:(NSString *)kAXChildrenAttribute error:NULL] indexOfObject:element]) {
								[candidates removeObject:element];
							}
						} else if ([key isEqualToString:(NSString *)kAXTitleAttribute]) {
							if (![[element valueForAttribute:key error:NULL] isEqual:object]) {
								if (![[[[element valueForAttribute:(NSString *)kAXTitleUIElementAttribute error:NULL] valueForAttribute:(NSString *)kAXValueAttribute error:NULL] description] isEqual:object]) {
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
	
	if (error != NULL && errorCode != 0) {
		*error = [M3AccessibilityController errorForCode:errorCode];
	}
	return [[[M3AccessibleUIElement alloc] initWithElement:element] autorelease];
}




/**
 Generate an NSError for the supplied code
 */
+ (NSError *)errorForCode:(NSInteger)code {
	NSString *localisedDescription = @"";
	if (code == kAXErrorFailure) {
		localisedDescription = NSLocalizedString(@"A system error occured.", @"");
	} else if (code == kAXErrorIllegalArgument) {
		localisedDescription = NSLocalizedString(@"An illegal argument was passed to the function.", @"");
	} else if (code == kAXErrorInvalidUIElement) {
		localisedDescription = NSLocalizedString(@"The UI element passed to the function was invalid.", @"");
	} else if (code == kAXErrorInvalidUIElementObserver) {
		localisedDescription = NSLocalizedString(@"The observer passed to the function was invalid", @"");
	} else if (code == kAXErrorCannotComplete) {
		localisedDescription = NSLocalizedString(@"Could not complete the operation. The application being communicated with may be busy or unresponsive.", @"");
	} else if (code == kAXErrorAttributeUnsupported) {
		localisedDescription = NSLocalizedString(@"The supplied attribute is not supported by this UI element.", @"");
	} else if (code == kAXErrorActionUnsupported) {
		localisedDescription = NSLocalizedString(@"The supplied action is not supported by this UI element.", @"");
	} else if (code == kAXErrorNotificationUnsupported) {
		localisedDescription = NSLocalizedString(@"The supplied notification is not supported by this UI element", @"");
	} else if (code == kAXErrorNotImplemented) {
		localisedDescription = NSLocalizedString(@"The targeted application does not implement the correct accessibility API methods", @"");
	} else if (code == kAXErrorNotificationAlreadyRegistered) {
		localisedDescription = NSLocalizedString(@"The supplied notification has already been registered", @"");
	} else if (code == kAXErrorNotificationNotRegistered) {
		localisedDescription = NSLocalizedString(@"The notification is not yet registered", @"");
	} else if (code == kAXErrorAPIDisabled) {
		localisedDescription = NSLocalizedString(@"The accessibility API is not enabled", @"");
	} else if (code == kAXErrorNoValue) {
		localisedDescription = NSLocalizedString(@"The requested value does not exist", @"");
	} else if (code == kAXErrorParameterizedAttributeUnsupported) {
		localisedDescription = NSLocalizedString(@"The supplied parameterised attribute is not supported by this UI element", @"");
	} else if (code == kAXErrorNotEnoughPrecision) {
		localisedDescription = NSLocalizedString(@"Undocumented Error: Not Enough Precision", @"");
	} else {
		return nil;
	}
	
	NSError *error = [NSError errorWithDomain:M3AccessibilityErrorDomain 
										 code:code 
									 userInfo:[NSDictionary dictionaryWithObject:localisedDescription forKey:NSLocalizedDescriptionKey]];
	
	return error;
}


@end
