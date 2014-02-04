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

@class HTTPRequester;
/*
 WebServiceHTTPRequest class encapsulates URL connection,
 HTTP errors and data parse handling.
 
 
 */

@protocol HTTPRequesterDelegate <NSObject>

- (void)requestDidFailWithError:(NSError *)error andResponseObject:(HTTPResponseObject *)responseObject;
- (void)requestDidFinishWithResponseObject:(HTTPResponseObject *)responseObject;

@optional
// Optional delegate methods for other NSURLConnection delegate methods.

@end

@interface HTTPRequester : NSObject

// Defaults to RawDataParserTypeJSON - only supported format so far.
@property(nonatomic, readonly) RawHTTPDataType httpDataType;


- (id)initWithDelegate:(id<HTTPRequesterDelegate>)delegate;
//TODO(mingatos): create inits to enable setting readonly properties.

- (void)makeRequest:(NSURLRequest *)request;

@end