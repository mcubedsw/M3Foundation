/*****************************************************************
NSFileManager+M3Extensions.h
M3Extensions

Created by Martin Pilkington on 11/09/2006.

Copyright (c) 2006-2009 M Cubed Software
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

#import "NSFileManager+M3Extensions.h"
#import "NSString+M3Extensions.h"
#import "M3FileSizeValueTransformer.h"

//static AuthorizationRef authorizationRef = NULL;

@interface NSFileManager ()

- (void)m3_calcSizeInNewThread:(NSDictionary *)attributes;

@end


@implementation NSFileManager (M3Extensions)

//detatches our size calculation to another thread
- (void)m3_calculateSizeOfFileAtPath:(NSString *)filePath handler:(id)handler {
	if (!filePath) {
		[handler performSelector:@selector(fileSizes:ofFileAtPath:) withObject:nil withObject:nil];
	} else if (handler) {
		[NSThread detachNewThreadSelector:@selector(m3_calcSizeInNewThread:)
								 toTarget:self
							   withObject:[NSDictionary dictionaryWithObjectsAndKeys:filePath, @"filepath", handler, @"handler", nil]];
	}
}

- (void)m3_calcSizeInNewThread:(NSDictionary *)attributes {	
	NSString *filePath = [attributes objectForKey:@"filepath"];
	// Copy the sending object over in case the code gets called again before it has finished execution	
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSFileManager * fm = [NSFileManager defaultManager];
	NSArray * contents;
	unsigned long long size = 0, sizeOnDisk = 0;
	NSString * path;
	BOOL isDirectory;
	
	// Determine Paths to Add
	if ([fm fileExistsAtPath:filePath] && ([[fm fileAttributesAtPath:filePath traverseLink:NO] objectForKey:NSFileType] == NSFileTypeDirectory)) {
		contents = [fm subpathsAtPath:filePath];
		isDirectory = TRUE;
	} else {
		contents = [NSArray arrayWithObject:filePath];
		isDirectory = FALSE;
	}
	// Add Size Of All Paths
	SEL objectAtIndexSEL	= @selector(objectAtIndex:);
	IMP objectAtIndexIMP	= [contents methodForSelector: objectAtIndexSEL]; //caches the selector, increases speed
	NSInteger index = 0;
	NSInteger count = [contents count];
	for (index; index < count; index++) {
		path = objectAtIndexIMP(contents, objectAtIndexSEL, index);
		NSDictionary *fileAttributes;
		if (isDirectory == TRUE)
			fileAttributes = [fm fileAttributesAtPath:[filePath stringByAppendingPathComponent: path] traverseLink:NO];
		else
			fileAttributes = [fm fileAttributesAtPath:path traverseLink:NO];
		//Sort into 4KB chunks to give physical space taken up
		size += [[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue];
		sizeOnDisk += ([[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue] / 4096 + (([[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue] % 4096) ? 1 : 0 )) *4;
	}
	// Create file size dictionary
	M3FileSizeValueTransformer *transformer = [[M3FileSizeValueTransformer alloc] init];
	NSDictionary *fileSizes = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedLongLong:size], @"M3ActualFileSize", [NSNumber numberWithUnsignedLongLong:sizeOnDisk], @"M3FileSizeOnDisk",
		[transformer transformedValue:[NSNumber numberWithUnsignedLongLong:size]], @"M3ReadableFileSize", nil];
	[transformer release];
	// Call setSize method of the handler object
	[self performSelectorOnMainThread:@selector(m3_returnObjectsToHandler:) 
						   withObject:[NSDictionary dictionaryWithObjectsAndKeys:[attributes objectForKey:@"handler"], @"handler",
									   fileSizes, @"fileSizes", filePath, @"filePath", nil]
						waitUntilDone:NO];
	[pool release];
}

- (void)m3_returnObjectsToHandler:(NSDictionary *)dict {
	[[dict objectForKey:@"handler"] performSelector:@selector(fileSizes:ofFileAtPath:) withObject:[dict objectForKey:@"fileSizes"] withObject:[dict objectForKey:@"filePath"]];
}

@end
