/*****************************************************************
 M3AccessibleUIElement.m
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

#import "M3AccessibleUIElement.h"
#import "M3AccessibilityController.h"

@interface M3AccessibleUIElement ()

- (id)sanitiseValue:(id)value;

@end


@implementation M3AccessibleUIElement

@synthesize element;

- (id)copyWithZone:(NSZone *)zone {
    return [self retain];
}

- (id)initWithElement:(AXUIElementRef)newElement {
	if (self = [super init]) {
		element = CFRetain(newElement);
	}
	return self;
}

- (void)dealloc {
	CFRelease(element);
	[super dealloc];
}

- (void)finalize {
	CFRelease(element);
	[super finalize];
}

/**
 Returns the description for a supplied action
 */
- (NSString *)descriptionForAction:(NSString *)action error:(NSError **)error {
	CFStringRef description = nil;
	AXError errorCode = AXUIElementCopyActionDescription (element, (CFStringRef)action, &description);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError)
		*error = returnError;
	return returnError != nil ? (NSString *)description : nil;
}

/**
 Returns an array of the action names
 */
- (NSArray *)actionNamesAndError:(NSError **)error {
	CFArrayRef names = nil;
	AXError errorCode = AXUIElementCopyActionNames(element, &names);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError)
		*error = returnError;
	return (NSArray *)names;
}

/**
 Returns an array of the attribute names;
 */
- (NSArray *)attributeNamesAndError:(NSError **)error {
	CFArrayRef names = nil;
	AXError errorCode = AXUIElementCopyAttributeNames(element, &names);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError)
		*error = returnError;
	return (NSArray *)names;
}

/**
 Returns the value for a supplied attribute
 */
- (id)valueForAttribute:(NSString *)attribute error:(NSError **)error {
	CFTypeRef value = nil;
	if ([[self attributeNamesAndError:NULL] containsObject:attribute]) {
		AXError errorCode = AXUIElementCopyAttributeValue(element, (CFStringRef)attribute, &value);
		NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
		if (error != NULL && returnError)
			*error = returnError;
	}
	
	return [self sanitiseValue:(id)value];
}

- (id)valuesForAttribute:(NSString *)attribute inRange:(NSRange)range error:(NSError **)error {
	CFArrayRef values = nil;
	AXError errorCode = AXUIElementCopyAttributeValues(element, (CFStringRef)attribute, range.location, range.length, &values);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError)
		*error = returnError;
	return [self sanitiseValue:(id)values];
}

/**
 Defines if an attribute is settable
 */
- (BOOL)isAttributeSettable:(NSString *)attribute error:(NSError **)error {
	Boolean settable;
	AXError errorCode = AXUIElementIsAttributeSettable(element, (CFStringRef)attribute, &settable);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError)
		*error = returnError;
	return (BOOL)settable;
}

/**
 Performs the supplied action
 */
- (BOOL)performAction:(NSString *)action error:(NSError **)error {
	AXError errorCode = AXUIElementPerformAction(element, (CFStringRef)action);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError) {
		*error = returnError;
		return NO;
	}
	return YES;
}

/**
 Posts a keyboard event
 */
- (BOOL)postKeyboardEventWithKeyCharacter:(CGCharCode)keyChar virtualKey:(CGKeyCode)virtualKey keyDown:(BOOL)keyDown error:(NSError **)error {
	AXError errorCode = AXUIElementPostKeyboardEvent(element, keyChar, virtualKey, (Boolean)keyDown);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError) {
		*error = returnError;
		return NO;
	}
	return YES;
}

/**
 Sets the value of the supplied attribute
 */
- (BOOL)setValue:(id)value forAttribute:(NSString *)attribute error:(NSError **)error {
	AXError errorCode = AXUIElementSetAttributeValue(element, (CFStringRef)attribute, (CFTypeRef)value);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError) {
		*error = returnError;
		return NO;
	}
	return YES;
}





/**
 Santises the output, putting it into appropriate objects
 */
- (id)sanitiseValue:(id)value {
	if (!value)
		return nil;
	if (AXValueGetType((AXValueRef)value) != kAXValueIllegalType) {
		CGPoint rawValue;
		AXValueGetValue((AXValueRef)value, AXValueGetType((AXValueRef)value), &rawValue);
		switch (AXValueGetType((AXValueRef)value)) {
			case kAXValueCGPointType: {
				CGPoint rawValue;
				AXValueGetValue((AXValueRef)value, kAXValueCGPointType, &rawValue);
				return [NSValue valueWithPoint:rawValue];
			}
			case kAXValueCGSizeType: {
				CGSize rawValue;
				AXValueGetValue((AXValueRef)value, kAXValueCGSizeType, &rawValue);
				return [NSValue valueWithSize:rawValue];
			}
			case kAXValueCGRectType: {
				CGRect rawValue;
				AXValueGetValue((AXValueRef)value, kAXValueCGRectType, &rawValue);
				return [NSValue valueWithRect:rawValue];
			}
			case kAXValueCFRangeType: {
				NSRange rawValue;
				AXValueGetValue((AXValueRef)value, kAXValueCFRangeType, &rawValue);
				return [NSValue valueWithRange:rawValue];
			}
		}
	}
	if ([value isKindOfClass:[NSArray class]]) {
		NSMutableArray *array = [NSMutableArray array];
		for (id subvalue in value) {
			[array addObject:[self sanitiseValue:subvalue]];
		}
		return [[array copy] autorelease];
	} else if ([[value description] rangeOfString:@"AXUIElement"].location != NSNotFound) {
		return [[[M3AccessibleUIElement alloc] initWithElement:(AXUIElementRef)value] autorelease];
	}
	return value;
}


- (NSString *)description {
	NSString *role = [self valueForAttribute:@"AXRole" error:nil];
	id value = [self valueForAttribute:@"AXValue" error:nil];
	if (value) {
		return [NSString stringWithFormat:@"%@ (%@)", role, value];
	}
	return role;
}

/**
 Generates the path to identify the UI element between launches
*/
- (NSString *)path {
	//Find the tree
	NSMutableArray *pathElements = [NSMutableArray arrayWithObject:self];
	id currentElement = self;
	while ((currentElement = [currentElement valueForAttribute:@"AXParent" error:NULL]) != nil) {
		[pathElements addObject:currentElement];
	}
	
	NSMutableArray *returnPath = [NSMutableArray array];
	
	//Loop through elements and build up path
	M3AccessibleUIElement *parent = nil;
	for (M3AccessibleUIElement *pathElement in [pathElements reverseObjectEnumerator]) {
		NSString *role = [pathElement valueForAttribute:(NSString *)kAXRoleAttribute error:NULL];
		NSString *subrole = [pathElement valueForAttribute:(NSString *)kAXSubroleAttribute error:NULL];
		NSString *title = [pathElement valueForAttribute:(NSString *)kAXTitleAttribute error:NULL];
		if (!title) {
			title = [[[pathElement valueForAttribute:(NSString *)kAXTitleUIElementAttribute error:NULL] valueForAttribute:(NSString *)kAXValueAttribute error:NULL] description];
		}
		NSString *value = [pathElement valueForAttribute:(NSString *)kAXValueAttribute error:NULL];
		NSPoint position = [[pathElement valueForAttribute:(NSString *)kAXPositionAttribute error:NULL] pointValue];
		
		NSArray *parentChildren = [parent valueForAttribute:(NSString *)kAXChildrenAttribute error:NULL];
		NSUInteger index = NSNotFound;
		if ([parentChildren count]) {
			index = [parentChildren indexOfObject:pathElement];
		}
		
		NSUInteger childCount = [[pathElement valueForAttribute:(NSString *)kAXChildrenAttribute error:NULL] count];
		
		//Create attributes array
		NSMutableArray *attributes = [NSMutableArray array];
		//Apps only need the app bundle
		if ([role isEqualToString:(NSString *)kAXApplicationRole]) {
			NSString *bundle = [[NSRunningApplication runningApplicationWithProcessIdentifier:[self processIDAndError:NULL]] bundleIdentifier];
			[attributes addObject:[NSString stringWithFormat:@"bundle='%@'", bundle]];
		} else {
			if (subrole) {
				[attributes addObject:[NSString stringWithFormat:@"%@='%@'", kAXSubroleAttribute, [subrole stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]]];
			}
			if (title) {
				[attributes addObject:[NSString stringWithFormat:@"%@='%@'", kAXTitleAttribute, [title stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]]];
			}
			if (value) {
				[attributes addObject:[NSString stringWithFormat:@"%@='%@'", kAXValueAttribute, [[value description] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]]];
			}
			[attributes addObject:[NSString stringWithFormat:@"%@=(%.1f|%.1f)", kAXPositionAttribute, position.x, position.y]];
			if (index != NSNotFound) {
				[attributes addObject:[NSString stringWithFormat:@"index=%d", index]];
			}
			[attributes addObject:[NSString stringWithFormat:@"childCount=%d", childCount]];
			
			//Menu specific items
			if ([role isEqualToString:(NSString *)kAXMenuItemRole]) {
				NSString *cmdChar = [pathElement valueForAttribute:(NSString *)kAXMenuItemCmdCharAttribute error:NULL];
				NSString *cmdModifiers = [pathElement valueForAttribute:(NSString *)kAXMenuItemCmdModifiersAttribute error:NULL];
				NSString *cmdVirtualKey = [pathElement valueForAttribute:(NSString *)kAXMenuItemCmdVirtualKeyAttribute error:NULL];
				if (cmdChar) 
					[attributes addObject:[NSString stringWithFormat:@"%@=%@", kAXMenuItemCmdCharAttribute, cmdChar]];
				if (cmdModifiers)
					[attributes addObject:[NSString stringWithFormat:@"%@=%@", kAXMenuItemCmdModifiersAttribute, cmdModifiers]];
				if (cmdVirtualKey)
					[attributes addObject:[NSString stringWithFormat:@"%@=%@", kAXMenuItemCmdVirtualKeyAttribute, cmdVirtualKey]];
			}
			
			//Table/Outline specific items
			if ([role isEqualToString:(NSString *)kAXTableRole] || [role isEqualToString:(NSString *)kAXOutlineRole]) {
				NSUInteger columnCount = [[pathElement valueForAttribute:(NSString *)kAXColumnsAttribute error:NULL] count];
				NSUInteger rowCount = [[pathElement valueForAttribute:(NSString *)kAXRowsAttribute error:NULL] count];
				[attributes addObject:[NSString stringWithFormat:@"columnCount=%d", columnCount]];
				[attributes addObject:[NSString stringWithFormat:@"rowCount=%d", rowCount]];
			}
		}
		
		
		[returnPath addObject:[NSString stringWithFormat:@"%@:(%@)", [pathElement valueForAttribute:(NSString *)kAXRoleAttribute error:NULL], [attributes componentsJoinedByString:@", "]]];
		parent = pathElement;
	}
	return [returnPath componentsJoinedByString:@"/"];
}


/**
 Return the process ID for the element
 */
- (pid_t)processIDAndError:(NSError **)error {
	pid_t pid = 0;
	AXError errorCode = AXUIElementGetPid(element, &pid);
	NSError *returnError = [M3AccessibilityController errorForCode:(NSInteger)errorCode];
	if (error != NULL && returnError)
		*error = returnError;
	
	return pid;
}

/**
 Test equality
 */
- (BOOL)isEqual:(id)object {
	if (![[self valueForAttribute:(NSString *)kAXRoleAttribute error:NULL] isEqualToString:[object valueForAttribute:(NSString *)kAXRoleAttribute error:NULL]]) {
		return NO;
	}
	NSString *subroleSelf = [self valueForAttribute:(NSString *)kAXSubroleAttribute error:NULL];
	NSString *subroleObject = [object valueForAttribute:(NSString *)kAXSubroleAttribute error:NULL];
	if (![subroleSelf isEqualToString:subroleObject] && subroleSelf && subroleObject) {
		return NO;
	}
	
	NSString *titleSelf = [self valueForAttribute:(NSString *)kAXTitleAttribute error:NULL];
	NSString *titleObject = [object valueForAttribute:(NSString *)kAXTitleAttribute error:NULL];
	if (![titleSelf isEqualToString:titleObject] && titleSelf && titleObject) {
		return NO;
	}
	
	id valueSelf = [self valueForAttribute:(NSString *)kAXValueAttribute error:NULL];
	id valueObject = [object valueForAttribute:(NSString *)kAXValueAttribute error:NULL];
	if (![valueSelf isEqual:valueObject] && valueSelf && valueObject) {
		return NO;
	}

	if (!NSEqualPoints([[self valueForAttribute:(NSString *)kAXPositionAttribute error:NULL] pointValue], [[object valueForAttribute:(NSString *)kAXPositionAttribute error:NULL] pointValue])) {
		return NO;
	}
	return YES;
}

@end
