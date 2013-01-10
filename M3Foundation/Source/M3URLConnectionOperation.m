/*****************************************************************
 M3URLConnectionOperation.m
 M3Foundation
 
 Created by Martin Pilkington on 01/07/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3URLConnectionOperation.h"


@implementation M3URLConnectionOperation 

- (id)initWithURLRequest:(NSURLRequest *)aRequest {
	if ((self = [super init])) {
		_request = aRequest;
		_shouldAutomaticallyRetryAfterTimeOut = YES;
	}
	return self;
}



- (void)main {
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&response error:&error];
	
	if (!data && (error.code == NSURLErrorTimedOut) && self.shouldAutomaticallyRetryAfterTimeOut) {
		data = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&response error:&error];
	}
	
	[self performSelectorOnMainThread:@selector(performBlock:) withObject:^{
		self.downloadCompletionBlock(response.statusCode, data, error);
	} waitUntilDone:YES];
}


- (void)performBlock:(void (^)(void))aBlock {
	aBlock();
}

@end
