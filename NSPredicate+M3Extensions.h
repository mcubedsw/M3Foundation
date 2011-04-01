//
//  NSPredicate+M3Extensions.h
//  M3Foundation
//
//  Created by Martin Pilkington on 31/03/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSPredicate (M3Extensions)

+ (NSPredicate *)m3_predicateFromXMLElement:(NSXMLElement *)aElement;
- (NSXMLElement *)m3_xmlRepresentation;

@end
