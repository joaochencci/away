//
//  WebServiceHTTPRequest.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "HTTPRequester.h"

@interface HTTPRequester () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

// readwrite to enable setting properties from within class (during init).
@property(nonatomic, readwrite) NSInteger maxRetries;
@property(nonatomic, readwrite) NSTimeInterval requestTimeout;
@property(nonatomic, readwrite) RawHTTPDataType httpDataType;



@end


@implementation HTTPRequester



@end
