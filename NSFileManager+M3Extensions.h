/*****************************************************************
NSFileManager+M3Extensions.h
M3Extensions

Created by Martin Pilkington on 11/09/2006.

Copyright (c) 2006-2010 M Cubed Software
Except trashPath:showAlerts: method which is adapted from DanSaul at http://www.cocoadev.com/index.pl?MoveToTrash

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

*****************************************************************/

#import <Cocoa/Cocoa.h>

extern NSString *M3ActualFileSize;
extern NSString *M3FileSizeOnDisk;
extern NSString *M3ReadableFileSize;

/**
 @category NSFileManager(M3Extensions)
 This category adds various useful methods for deleting and finding the size of files
 @since Available in M3Foundation 1.0 and later
 */
@interface NSFileManager(M3Extensions)

/**
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
 @since Available in M3Foundation 1.0 and later
 */
- (void)m3_calculateSizeOfFileAtPath:(NSString *)filePath handler:(id)handler;



@end
