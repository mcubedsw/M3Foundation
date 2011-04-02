//
//  NSExpression+M3Extensions.h
//  M3Foundation
//
//  Created by Martin Pilkington on 01/04/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSExpression (M3Extensions)

+ (NSExpression *)m3_expressionFromXMLElement:(NSXMLElement *)aElement;
- (NSXMLElement *)m3_xmlRepresentation;

@end
