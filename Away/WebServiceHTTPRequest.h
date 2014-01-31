//
//  WebServiceHTTPRequest.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RawHTTPDataParser.h"
#import "HTTPResponseObject.h"

@class WebServiceHTTPRequest;
/*
 WebServiceHTTPRequest class encapsulates URL connection,
 HTTP errors, timeout and data parse handling.
 
 
 */
@protocol WebServiceHTTPRequestDelegate <NSObject>

- (void)requestDidFailWithError:(NSError *)error;
- (void)requestDidFinishWithResponseObject:(HTTPResponseObject *)responseObject;

@optional
// Optional delegate methods for other NSURLConnection delegate methods.

@end

@interface WebServiceHTTPRequest : NSObject

// Defaults to RawDataParserTypeJSON - only supported format so far.
@property(nonatomic, readonly) RawHTTPDataType httpDataType;


- (id)initWithDelegate:(id<WebServiceHTTPRequestDelegate>)delegate;
//TODO(mingatos): create inits to enable setting readonly properties.

- (void)makeRequest:(NSURLRequest *)request;

@end