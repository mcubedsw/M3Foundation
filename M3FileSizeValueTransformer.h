//
//  M3FileSizeValueTransformer.h
//  Minim
//
//  Created by Martin Pilkington on 16/08/2009.
//  Copyright 2009 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 @abstract Takes a value in bytes and converts it into the most appropriate unit eg 2048 bytes would return "2 KB"
 @param number The size of the file in bytes
 @return An NSString containing the readable size and appropriate unit
 */
@interface M3FileSizeValueTransformer : NSValueTransformer {

}

@end
