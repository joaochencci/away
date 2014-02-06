//
//  WebServiceAction.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "AbstractWebServicePrivate.h"

#import "NSDictionary+URLArguments.h"

@implementation AbstractWebService

#pragma mark - Singleton

static AbstractWebService *_webService = nil;

+ (AbstractWebService *)sharedWebService
{
    if (!_webService) {
        _webService = [[super allocWithZone:nil] init];
    }
    return _webService;
}

# pragma mark - Initialization

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [AbstractWebService sharedWebService];
}

-(id)init
{
    self = [super init];
    
    if (self){
        _urlScheme = nil;
        _hostURL = nil;
        _path = nil;
        
        _requestParams = nil;
        
        _requestMethod = nil;
        _userAgent = nil;
        _contentType = nil;
        
        _maxRequestTries = 0;
        _tryCounter = 0;
        
        _request = nil;
        _requestFired = NO;
    }
    
    return self;
}

# pragma mark - URL construction methods

- (NSString *)urlStringWithScheme:(NSString *)urlScheme
                       hostURL:(NSString *)hostURL
                          path:(NSString *)path
                        action:(NSString *)action
                 andParameters:(NSDictionary *)parameters
{
    //
    if (!action) {
        action = @"";
    }
    
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@%@%@",
                                  urlScheme, hostURL, path, action];
    
    if (parameters) {
        [urlString appendString:[parameters stringForURLEscapedArguments]];
    }
    
    return urlString;
}


# pragma mark - URL Request construction methods

- (void)loadGETRequest
{
    NSString *urlString = [self urlStringWithScheme:_urlScheme
                                            hostURL:_hostURL
                                               path:_path
                                             action:_action
                                      andParameters:_requestParams];
    NSURL *getURL = [NSURL URLWithString:urlString];
    _request = [NSMutableURLRequest requestWithURL:getURL];
    
}
- (void)loadPOSTRequest
{
    NSString *urlString = [self urlStringWithScheme:_urlScheme
                                            hostURL:_hostURL
                                               path:_path
                                             action:_action
                                      andParameters:nil];
    NSURL *postURL = [NSURL URLWithString:urlString];
    _request = [NSMutableURLRequest requestWithURL:postURL];
    
    // TODO(mingatos): finish loading Post Request
}

# pragma mark - URL Request requisition

- (void)executeRequest:(NSURLRequest *)request withHandler:(id<HTTPRequestDelegate>)handler
{
    //
    
    
    _httpRequest = [[HTTPRequest alloc] initWithRequest:_request andDelegate:handler];
}


# pragma mark - Abstract methods
# pragma mark - HTTPRequesterDelegate methods
// Must be implemented in subclass.
- (void)request:(HTTPRequest *)request didFailWithError:(NSError *)error
{
    //
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}

- (void)request:(HTTPRequest *)request didFinishWithResponseObject:(HTTPResponseObject *)responseObject
{
    //
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
