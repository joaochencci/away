//
//  LoginAction.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "BaseAwayAction.h"

@interface GetUserAction : BaseAwayAction

// Returns a user for a given facebook token.
- ()getUserForFacebookToken:(NSString *)fbToken;

@end
