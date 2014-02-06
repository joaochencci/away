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
        _baseURL = nil;
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

//- (void)setupScheme:hostURL:path...

# pragma mark - URL construction methods
- (NSURL *)urlWithScheme:(NSString *)urlScheme
                 hostURL:(NSString *)hostURL
                    path:(NSString *)path
                  action:(NSString *)action
           andParameters:(NSDictionary *)parameters
{
    // Acceped urlSchemes: http
    //
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@%@%@",
                                  urlScheme, hostURL, path, action];
    
    if (parameters) {
        [urlString appendString:[parameters stringForURLEscapedArguments]];
    }
    
    NSURL *myURL = [NSURL URLWithString:urlString];
    
    NSLog(@"%@", myURL);
    
    return myURL;
}


- (NSString *)urlStringWithScheme:(NSString *)urlScheme
                       hostURL:(NSString *)hostURL
                          path:(NSString *)path
                        action:(NSString *)action
                 andParameters:(NSDictionary *)parameters
{
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
    
}
- (void)loadPOSTRequest
{
    
}

# pragma mark - URL Request requisition

//- (void)executeRequest:(NSURLRequest *)request withDelegate:
//{
//    //
//    //_connection = [NSURLConnection connectionWithRequest:request delegate:(id<NS>)]
//    
//}


# pragma mark - Abstract methods
# pragma mark - HTTPRequesterDelegate methods
// Must be implemented in subclass.
- (void)requestDidFailWithError:(NSError *)error
{
    //
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}

- (void)requestDidFinishWithResponseObject:(HTTPResponseObject *)responseObject
{
    //
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
