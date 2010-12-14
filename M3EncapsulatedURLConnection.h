/*****************************************************************
 M3URLConnection.h
 M3Extensions
 
 Created by Martin Pilkington on 29/03/2008.
 
 Copyright (c) 2006-2010 M Cubed Software
 
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

/**
 @class M3EncapsulatedURLConnection
 This class wraps around NSURLConnection providing extra functionality that greatly improves
 it's usability in situations where lots of queries are sent. As well as providing the ability to uniquely
 identify each connection, store a context info dictionary and retreive extra information such as the 
 NSURLRequest used, M3EncapsulatedURLConnection only gives you the request data and response once all data 
 has been received, meaning that packets for a certain request are kept neatly within one class, making the
 task of sending multiple requests at a time much easier.
 
 @since Available in M3Foundation 1.0 and later
 */
@interface M3EncapsulatedURLConnection : NSObject {
	NSURLConnection *connection;
	NSURLRequest *connectionRequest;
	NSMutableData *returnData;
	NSInteger responseNo;
	id delegate;
	id identifier;
	NSDictionary *contextInfo;
}

/**
 Creates and initialises a new M3EncapsulatedURLConnection object
 @param request The NSURLRequest for the connection
 @param del The delegate for the connection
 @param ident An object that you can use to identify the connection, may be nil
 @param dict A dictionary of additional info, may be nil
 @result A newly initialised M3EncapsulatedURLConnection object
 @since Available in M3Foundation 1.0 and later
 */
- (id)initWithRequest:(NSURLRequest *)request delegate:(id)del andIdentifier:(id)ident contextInfo:(NSDictionary *)dict;


/**
 Returns the NSURLRequest object for the connection
 @result The connection's NSURLRequest object
 @since Available in M3Foundation 1.0 and later
 */
- (NSURLRequest *)connectionRequest;

/**
 Returns the connection's identifier
 @result The connection's identifier
 @since Available in M3Foundation 1.0 and later
 */
- (id)identifier;

/**
 Returns the context info dictionary for the connection
 @result The connection's context info dictionary
 @since Available in M3Foundation 1.0 and later
 */
- (NSDictionary *)contextInfo;

@end

/**
 @category M3EncapsulatedURLConnection(DelegateMethods)
 <b>Discussion</b>
 Delegate methods for M3EncapsulatedURLConnection
 @since Available in M3Foundation 1.0 and later
 */
@interface M3EncapsulatedURLConnection (DelegateMethods)
/**
 Sent when a connection has finished loading all data
 @param connection The connection sending the message
 @param response The response of the request
 @param data The data returned from the request
 @since Available in M3Foundation 1.0 and later
 */
- (void)connection:(M3EncapsulatedURLConnection *)connection returnedWithResponse:(NSInteger)response andData:(NSData *)data;

/**
 Sent when a connection has received an authentication challenge
 @param connection The connection sending the message
 @param challenge The challenge that connection must authenticate in order to download its request
 @result The credential that should be used by the connection
 @since Available in M3Foundation 1.0 and later
 */
- (NSURLCredential *)connection:(M3EncapsulatedURLConnection *)connection didRequestAuthenticationCredentialForChallenge:(NSURLAuthenticationChallenge *)challenge;

/**
 Sent when an authentication challenge cancelled
 @param connection The connection sending the message
 @param response The challenge that was cancelled
 @since Available in M3Foundation 1.0 and later
 */
- (void)connection:(M3EncapsulatedURLConnection *)connection canceledAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

/**
 Creates an initialises a new M3EncapsulatedURLConnection object
 @param connection The connection sending the message
 @param response An error object containing details of why the connection failed to load the request successfully
 @since Available in M3Foundation 1.0 and later
 */
- (void)connection:(M3EncapsulatedURLConnection *)connection returnedWithError:(NSError *)error;

@end