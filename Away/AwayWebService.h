//
//  AwayWebService.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface AwayWebService : NSObject

// Returns a user for a given facebook token.
- (User *)getUserForFacebookToken:(NSString *)fbToken;

@end
