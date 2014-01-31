//
//  WebServiceAction.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "WebServiceAction.h"

@interface WebServiceAction () {
    
    NSString *_baseURL; // @"http://www.google.com/"
    NSString *_path; // @"away/api"
    NSString *_action; // @"login";
    
    NSDictionary *_requestParams; //
    
    
    NSString *_requestMethod; // @"POST";
    NSString *_userAgent; // away-app-ios
    NSString *_contentType; // application/json
    
    NSInteger maxRequestTries; // 3
    NSInteger tryCounter;
    
}

- (

@end

@implementation WebServiceAction

@end
