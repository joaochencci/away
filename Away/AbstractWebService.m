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

# pragma mark - Private Interface
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


# pragma mark - URL Request construction methods


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
