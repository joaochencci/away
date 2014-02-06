//
//  WebServiceHTTPRequest.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTTPRawDataParser.h"
#import "HTTPResponseObject.h"

@class HTTPRequest;
/*
 WebServiceHTTPRequest class encapsulates URL connection,
 HTTP errors and data parse handling.
 */

@protocol HTTPRequestDelegate <NSObject>

- (void)request:(HTTPRequest *)request didFailWithError:(NSError *)error;
- (void)request:(HTTPRequest *)request didFinishWithResponseObject:(HTTPResponseObject *)responseObject;

@optional
// Optional delegate methods for other NSURLConnection delegate methods.
@end


@interface HTTPRequest : NSObject

// Defaults to RawDataParserTypeJSON - only supported format so far.
@property(nonatomic, readonly) RawHTTPDataType rawHTTPDataType;
@property(nonatomic, readonly) NSInteger tryCount;


- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<HTTPRequestDelegate>)delegate;

- (void)makeRequestParsingData:(RawHTTPDataType)httpDataType asynch:(BOOL)asynch;
- (void)retryRequest;

@end