/*****************************************************************
 NSString+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 09/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSString+M3Extensions.h"


@implementation NSString(M3Extensions) 

//*****//
- (NSString *)m3_stringByRemovingCharactersFromEnd:(NSUInteger)aNumber {
	if (aNumber > [self length])
		return nil;
	return [self substringToIndex:[self length] - aNumber];
}

//*****//
- (BOOL)m3_containsString:(NSString *)aSubString {
	return [self rangeOfString:aSubString].location != NSNotFound;
}

@end
