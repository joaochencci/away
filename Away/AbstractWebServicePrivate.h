//
//  AbstractWebServicePrivate.h
//  Away
//
//  Created by Marcelo Toledo on 2/4/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "AbstractWebService.h"
#import "HTTPRequest.h"

@interface AbstractWebService () <HTTPRequestDelegate> {
    
    NSString *_urlScheme; // http
    NSString *_hostURL; // @"http://www.google.com"
    NSString *_path; // @"/away/api"
    NSString *_action; // @"login";
    
    NSDictionary *_requestParams; //
    
    
    NSString *_requestMethod; // @"POST";
    NSString *_userAgent; // away-app-ios
    NSString *_contentType; // application/json
    
    NSTimeInterval _timeout; // 15s
    NSInteger _maxRequestTries; // 3
    NSInteger _tryCounter;
    
    // TODO(mingatos): MutableDictionary tracking all request, connection and
    // responses. When completed, remove from dict, this way can manage
    // multiple requests and connections. Use handler objects to handle
    // response
    
    // Array receiveing requests, when one request is fired, go through array
    // firing others in line
    HTTPRequest *_httpRequest;
    NSURLRequest *_request;
    NSURLConnection *_connection;
    BOOL _requestFired;
    
}

- (void)configWebServiceScheme:(NSString *)urlScheme
                          host:(NSString *)hostURL
                          path:(NSString *)path
                        action:(NSString *)action
                    parameters:(NSDictionary *)params
                        method:(NSString *)requestMethod
                     userAgent:(NSString *)userAgent
                   contentType:(NSString *)contentType
                       timeout:(NSTimeInterval)timeout
                    maxRetries:(NSInteger)maxRequestTries;

- (void)loadGETRequestWithParameters:(NSDictionary *)parametesrs;
- (void)loadPOSTRequest;
- (void)executeWithHandler:(id<HTTPRequestDelegate>)handler;
- (void)executeRequest:(NSURLRequest *)request withHandler:(id<HTTPRequestDelegate>)handler;

// For GET HTTP Requests pass a dictionary containing all parameters
// to be passed via URL. Otherwise, pass nil.
- (NSString *)urlStringWithScheme:(NSString *)urlScheme
                          hostURL:(NSString *)hostURL
                             path:(NSString *)path
                           action:(NSString *)action
                    andParameters:(NSDictionary *)parameters;

// HTTPRequesterDelegate - To be implemented by subclass.
- (void)request:(HTTPRequest *)request didFailWithError:(NSError *)error;
- (void)request:(HTTPRequest *)request didFinishWithResponseObject:(HTTPResponseObject *)responseObject;


@end