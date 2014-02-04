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
    
    NSInteger maxRequestTries; // 3
    NSInteger tryCounter;
    
}

- (void)executeRequest:(NSURLRequest *)request;
- (void)executeGETRequest:(NSURLRequest *)getRequest;
- (void)executePOSTRequest:(NSURLRequest *)postRequest;

// For GET HTTP Requests pass a dictionary containing all parameters
// to be passed via URL. Otherwise, pass nil.
- (NSURL *)urlWithScheme:(NSString *)urlScheme
                 baseURL:(NSString *)baseURL
                     path:(NSString *)path
                   action:(NSString *)action
            andParameters:(NSDictionary *)parameters;

// HTTPRequesterDelegate - To be implemented by subclass.
- (void)requestDidFailWithError:(NSError *)error andResponseObject:(HTTPResponseObject *)responseObject;
- (void)requestDidFinishWithResponseObject:(HTTPResponseObject *)responseObject;


@end