//
//  M3URLConnectionOperation.h
//  Lighthouse Keeper
//
//  Created by Martin Pilkington on 01/07/2010.
//  Copyright 2010 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//typedef void (^M3DownloadCompletionBlock)(NSInteger aResponse, NSData *aData, NSError *aError);


@interface M3URLConnectionOperation : NSOperation

- (id)initWithURLRequest:(NSURLRequest *)aRequest;

- (void)setDownloadCompletionBlock:(void(^)(NSInteger aResponse, NSData *aData, NSError *aError))aBlock;
@property (readonly) NSURLRequest *request;

@end
