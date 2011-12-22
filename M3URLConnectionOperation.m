/*****************************************************************
 M3URLConnectionOperation.m
 M3Foundation
 
 Created by Martin Pilkington on 01/07/2010.
 
 Copyright © 2006-2011 M Cubed Software.
 
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

#import "M3URLConnectionOperation.h"

@interface M3URLConnectionOperation () {
	NSURLRequest *request;
	void(^downloadCompletionBlock)(NSInteger aResponse, NSData *aData, NSError *aError);
}

@end



@implementation M3URLConnectionOperation

@synthesize request, shouldAutomaticallyRetryAfterTimeOut;

- (id)initWithURLRequest:(NSURLRequest *)aRequest {
	if ((self = [super init])) {
		request = [aRequest retain];
		shouldAutomaticallyRetryAfterTimeOut = YES;
	}
	return self;
}

- (void)dealloc {
	[request release];
	[downloadCompletionBlock release];
	[super dealloc];
}

- (void)setDownloadCompletionBlock:(void(^)(NSInteger aResponse, NSData *aData, NSError *aError))aBlock {
	downloadCompletionBlock = [aBlock copy];
}

- (void)main {
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if (!data && [error code] == NSURLErrorTimedOut) {
		data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	}
	
	[self performSelectorOnMainThread:@selector(performBlock:) withObject:^{
		downloadCompletionBlock([response statusCode], data, error);
	} waitUntilDone:YES];
}

- (void)performBlock:(void (^)(void))aBlock {
	aBlock();
}

@end
