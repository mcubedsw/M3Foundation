/*****************************************************************
 M3TestObject.h
 M3Foundation
 
 Created by Martin Pilkington on 15/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

//Used for testing NSObject+M3Extensions
@interface M3TestObject : NSObject

@property (copy) NSString *storedValue;

- (void)updateStoredValue; //Sets the storedValue to "foo"

@end
