//
//  M3TestObject.h
//  M3Foundation
//
//  Created by Martin Pilkington on 15/01/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>

//Used for testing NSObject+M3Extensions
@interface M3TestObject : NSObject

@property (copy) NSString *storedValue;

- (void)updateStoredValue; //Sets the storedValue to "foo"

@end
