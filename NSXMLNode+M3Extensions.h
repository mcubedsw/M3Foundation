//
//  NSXMLNode+M3Extensions.h
//  Lighthouse Keeper
//
//  Created by Martin Pilkington on 19/03/2010.
//  Copyright 2010 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSXMLNode (M3Extensions)

- (NSInteger)m3_integerValue;
- (CGFloat)m3_floatValue;
- (NSXMLNode *)m3_nodeForXPath:(NSString *)xPath error:(NSError **)error;

@end
