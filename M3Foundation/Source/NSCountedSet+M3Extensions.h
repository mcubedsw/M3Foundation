/*****************************************************************
 NSCountedSet+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 11/02/2012.
 
 Please read the LICENCE.txt for licensing information
 *****************************************************************/

#import <Foundation/Foundation.h>

@interface NSCountedSet (M3Extensions)

- (NSSet *)m3_objectsWithCount:(NSUInteger)aCount;
- (NSUInteger)m3_countedObjectTotal;

@end
