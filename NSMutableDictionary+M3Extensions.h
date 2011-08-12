//
//  NSMutableDictionary+M3Extensions.h
//  M3Foundation
//
//  Created by Martin Pilkington on 15/04/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableDictionary (M3Extensions)

- (void)m3_safeSetObject:(id)aObj forKey:(id)aKey;

@end
