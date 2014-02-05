//
//  AbstractWebServicePrivate.h
//  Away
//
//  Created by Marcelo Toledo on 2/4/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "AbstractWebService.h"
#import "HTTPRequester.h"

@interface AbstractWebService () <HTTPRequesterDelegate> {
    
    NSString *_urlScheme; // http
    NSString *_baseURL; // @"http://www.google.com"
    NSString *_path; // @"/away/api"
    NSString *_action; // @"login";
    
    NSDictionary *_requestParams; //
    
    
    NSString *_requestMethod; // @"POST";
    NSString *_userAgent; // away-app-ios
    NSString *_contentType; // application/json
    
    NSInteger _maxRequestTries; // 3
    NSInteger _tryCounter;
    
    NSURLRequest *_request;
    BOOL _requestFired;
    
}

- (void)loadGETRequest;
- (void)loadPOSTRequest;
- (void)executeRequest:(NSURLRequest *)request;


// For GET HTTP Requests pass a dictionary containing all parameters
// to be passed via URL. Otherwise, pass nil.
- (NSString *)urlStringWithScheme:(NSString *)urlScheme
                          hostURL:(NSString *)hostURL
                             path:(NSString *)path
                           action:(NSString *)action
                    andParameters:(NSDictionary *)parameters;

// HTTPRequesterDelegate - To be implemented by subclass.
- (void)requestDidFailWithError:(NSError *)error andResponseObject:(HTTPResponseObject *)responseObject;
- (void)requestDidFinishWithResponseObject:(HTTPResponseObject *)responseObject;


@end