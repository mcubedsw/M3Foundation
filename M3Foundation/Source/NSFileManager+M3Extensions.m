/*****************************************************************
 NSFileManager+M3Extensions.m
 M3Foundation
 
 Created by Martin Pilkington on 11/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSFileManager+M3Extensions.h"
#import "NSString+M3Extensions.h"
#import "M3FileSizeValueTransformer.h"


NSString *M3ActualFileSize = @"M3ActualFileSize";
NSString *M3FileSizeOnDisk = @"M3FileSizeOnDisk";
NSString *M3ReadableFileSize = @"M3ReadableFileSize";


@interface NSFileManager(PrivateExtensions)

- (void)m3_calcSizeInNewThread:(NSDictionary *)attributes;

@end


@implementation NSFileManager(M3Extensions)

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

//*****//
- (void)m3_calcSizeInNewThread:(NSDictionary *)attributes {	
	NSString *filePath = [attributes objectForKey:@"filepath"];
	// Copy the sending object over in case the code gets called again before it has finished execution	
	
	@autoreleasepool {
		NSFileManager * fm = [NSFileManager defaultManager];
		NSArray * contents;
		unsigned long long size = 0, sizeOnDisk = 0;
		NSString * path;
		BOOL isDirectory;
		
		// Determine Paths to Add
		if ([fm fileExistsAtPath:filePath] && ([[fm attributesOfItemAtPath:filePath error:nil] objectForKey:NSFileType] == NSFileTypeDirectory)) {
			contents = [fm subpathsAtPath:filePath];
			isDirectory = TRUE;
		} else {
			contents = [NSArray arrayWithObject:filePath];
			isDirectory = FALSE;
		}
		// Add Size Of All Paths
		SEL objectAtIndexSEL	= @selector(objectAtIndex:);
		IMP objectAtIndexIMP	= [contents methodForSelector: objectAtIndexSEL]; //caches the selector, increases speed
		NSInteger count = [contents count];
		for (NSInteger index = 0; index < count; index++) {
			path = objectAtIndexIMP(contents, objectAtIndexSEL, index);
			NSDictionary *fileAttributes;
			if (isDirectory == TRUE)
				fileAttributes = [fm attributesOfItemAtPath:[filePath stringByAppendingPathComponent: path] error:nil];
			else
				fileAttributes = [fm attributesOfItemAtPath:path error:nil];
			//Sort into 4KB chunks to give physical space taken up
			size += [[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue];
			sizeOnDisk += ([[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue] / 4096 + (([[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue] % 4096) ? 1 : 0 )) *4;
		}
		// Create file size dictionary
		M3FileSizeValueTransformer *transformer = [[M3FileSizeValueTransformer alloc] init];
		NSDictionary *fileSizes = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedLongLong:size], M3ActualFileSize, [NSNumber numberWithUnsignedLongLong:sizeOnDisk], M3FileSizeOnDisk,
			[transformer transformedValue:[NSNumber numberWithUnsignedLongLong:size]], M3ReadableFileSize, nil];
		// Call setSize method of the handler object
		[self performSelectorOnMainThread:@selector(m3_returnObjectsToHandler:) 
							   withObject:[NSDictionary dictionaryWithObjectsAndKeys:[attributes objectForKey:@"handler"], @"handler",
										   fileSizes, @"fileSizes", filePath, @"filePath", nil]
							waitUntilDone:NO];
	}
}

//*****//
- (void)m3_returnObjectsToHandler:(NSDictionary *)dict {
	[[dict objectForKey:@"handler"] performSelector:@selector(fileSizes:ofFileAtPath:) withObject:[dict objectForKey:@"fileSizes"] withObject:[dict objectForKey:@"filePath"]];
}

@end
