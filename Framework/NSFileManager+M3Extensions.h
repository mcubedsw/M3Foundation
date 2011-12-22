/*****************************************************************
 NSFileManager+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 11/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

extern NSString *M3ActualFileSize;
extern NSString *M3FileSizeOnDisk;
extern NSString *M3ReadableFileSize;

/***************************
 This category adds various useful methods for deleting and finding the size of files
 @since M3Foundation 1.0 and later
 ***************************/
@interface NSFileManager(M3Extensions)

/***************************
 Calculates the size of the supplied path in a separate thread
 
 <b>Discussion</b>
 This method calculates the size of a file or directory in a separate thread, calling 
 
 -(void)fileSizes:(NSDictionary *)filesizes ofFileAtPath:(NSString *)path
 
 on the supplied handler in the main thread once calculated. The filesizes array contains 3 objects:
 
 - M3ActualFileSize: an NSNumber containing the actual size of the file in bytes
 - M3FileSizeOnDisk: an NSNumber containing the space occupied by the file on disk in kilobytes
 - M3ReadableFileSize: an NSString containing a more user friendly form of M3ActualFileSize, in the most appropriate unit
 
 @param filePath The path of the file to calculate
 @param handler The object which will receive the size when calculation has finished
 @since M3Foundation 1.0 and later
 ***************************/
- (void)m3_calculateSizeOfFileAtPath:(NSString *)filePath handler:(id)handler;



@end
