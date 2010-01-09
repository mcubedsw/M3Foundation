/*****************************************************************
 M3URLConnection.m
 M3Extensions
 
 Created by Martin Pilkington on 29/03/2008.
 
 Copyright (c) 2006-2009 M Cubed Software
 
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

#import "M3EncapsulatedURLConnection.h"


@implementation M3EncapsulatedURLConnection

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)del andIdentifier:(id)ident contextInfo:(NSDictionary *)dict{
	if (self = [super init]) {
		connectionRequest = [request retain];
		delegate = del;
		connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		returnData = [[NSMutableData alloc] init];
		identifier = [ident retain];
		contextInfo = [dict retain];
	}
	return self;
}

- (void)dealloc {
	[connectionRequest release];
	[delegate release];
	[connection release];
	[returnData release];
	[identifier release];
	[contextInfo release];
	[super dealloc];
}


- (NSURLRequest *)connectionRequest {
	return connectionRequest;
}

- (id)identifier {
	return identifier;
}

- (NSDictionary *)contextInfo {
	return contextInfo;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	responseNo = [(NSHTTPURLResponse *)response statusCode];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if ([delegate respondsToSelector:@selector(connection:returnedWithResponse:andData:)]) {
		[delegate connection:self returnedWithResponse:responseNo andData:returnData];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[returnData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if ([delegate respondsToSelector:@selector(connection:returnedWithError:)]) {
		[delegate connection:self returnedWithError:error];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	//If it hasn't failed before and the delegate responds to the selector then use it and return
	if ([challenge previousFailureCount] == 0) {
		if ([delegate respondsToSelector:@selector(connection:didRequestAuthenticationCredentialForChallenge:)]) {
			[[challenge sender] useCredential:[delegate connection:self didRequestAuthenticationCredentialForChallenge:challenge] forAuthenticationChallenge:challenge];
			return;
		}
	}
	//Otherwise fail
	[[challenge sender] cancelAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([delegate respondsToSelector:@selector(connection:canceledAuthenticationCredentialForChallenge:)]) {
		[delegate connection:self canceledAuthenticationChallenge:challenge];
		return;
	}
}

@end
