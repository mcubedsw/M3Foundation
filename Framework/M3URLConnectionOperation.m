/*****************************************************************
 M3URLConnectionOperation.m
 M3Foundation
 
 Created by Martin Pilkington on 01/07/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3URLConnectionOperation.h"

@interface M3URLConnectionOperation () {
	NSURLRequest *request;
	void(^downloadCompletionBlock)(NSInteger aResponse, NSData *aData, NSError *aError);
}

@end



@implementation M3URLConnectionOperation

@synthesize request, shouldAutomaticallyRetryAfterTimeOut;

//*****//
- (id)initWithURLRequest:(NSURLRequest *)aRequest {
	if ((self = [super init])) {
		request = [aRequest retain];
		shouldAutomaticallyRetryAfterTimeOut = YES;
	}
	return self;
}

//*****//
- (void)dealloc {
	[request release];
	[downloadCompletionBlock release];
	[super dealloc];
}

//*****//
- (void)setDownloadCompletionBlock:(void(^)(NSInteger aResponse, NSData *aData, NSError *aError))aBlock {
	downloadCompletionBlock = [aBlock copy];
}

//*****//
- (void)main {
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if (!data && [error code] == NSURLErrorTimedOut && self.shouldAutomaticallyRetryAfterTimeOut) {
		data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	}
	
	[self performSelectorOnMainThread:@selector(performBlock:) withObject:^{
		downloadCompletionBlock([response statusCode], data, error);
	} waitUntilDone:YES];
}

//*****//
- (void)performBlock:(void (^)(void))aBlock {
	aBlock();
}

@end
