//
//  AwayWebService.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "AwayWebService.h"

// Importing Actions

@interface AwayWebService ()



@end

@implementation AwayWebService

- (void)configAwayWebService
{
    [self configWebServiceScheme:@""
                            host:@""
                            path:@""
                          action:@""
                      parameters:nil
                          method:@""
                       userAgent:@""
                     contentType:@""
                         timeout:15
                      maxRetries:3];
}

- (void)getUserForFacebookToken:(NSString *)fbToken withHandler:(id<HTTPRequestDelegate>)handler
{
    //
    NSDictionary *parameters = @{@"provider": @"facebook", @"token": fbToken};
    
    [self configAwayWebService];
    
    [self loadGETRequestWithParameters:parameters];
    [self executeWithHandler:handler];
}

@end
