/*****************************************************************
 NSMutableDictionary+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 15/04/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

/***************************
 This category adds methods to simplify working with dictionaries
 @since M3Foundation 1.0 or later
 **************************/
@interface NSMutableDictionary (M3Extensions)

/***************************
 Adds an object to the dictionary, ignoring nil if passed in as the object
 @param aObj The object to add
 @param aKey The key to use for the object
 @since M3Foundation 1.0 or later
 **************************/
- (void)m3_safeSetObject:(id)aObj forKey:(id)aKey;

@end
