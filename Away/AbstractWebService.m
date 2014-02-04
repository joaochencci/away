//
//  WebServiceAction.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "AbstractWebServicePrivate.h"

@implementation AbstractWebService

# pragma mark - URL construction methods

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
