/*****************************************************************
 M3URLConnectionOperation.h
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

#import <Cocoa/Cocoa.h>

/***************************
 An operation that encapsulates a URL connection
 Behind the scenes this uses NS
 @since M3Foundation 1.0 or later
 **************************/
@interface M3URLConnectionOperation : NSOperation

/***************************
 Initialise a new operation with the supplied request
 @param aRequest The request for the connection operation
 @return A newly initialised M3URLConnectionOperation
 @since M3Foundation 1.0 or later
 **************************/
- (id)initWithURLRequest:(NSURLRequest *)aRequest;

/***************************
 Sets the block to call when the connection has completed
 This block is called on the main thread. The operation doesn't complete until after it has executed
 @param aBlock The completion block
 @since M3Foundation 1.0 or later
 **************************/
- (void)setDownloadCompletionBlock:(void(^)(NSInteger aResponse, NSData *aData, NSError *aError))aBlock;

/***************************
 The request for the operation
 @since M3Foundation 1.0 or later
 **************************/
@property (readonly) NSURLRequest *request;

/***************************
 Whether the operation should automatically try a second time after a time out.
 @since M3Foundation 1.0 or later
 **************************/
@property (assign) BOOL shouldAutomaticallyRetryAfterTimeOut;

@end
