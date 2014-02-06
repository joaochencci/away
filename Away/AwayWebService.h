//
//  AwayWebService.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AbstractWebServicePrivate.h"

@interface AwayWebService : AbstractWebService

// Returns a user for a given facebook token.
- (void)getUserForFacebookToken:(NSString *)fbToken withHandler:(id<HTTPRequestDelegate>)handler;

@end
