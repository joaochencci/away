//
//  User.m
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "User.h"

@interface User () {
    CGFloat coordinatesLocation;
}

@end

@implementation User

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)userDataDictionary
{
    self = [self init];
    if (self) {
        //
    }
    return self;
}

- (NSInteger)getNumberOfFriendsFromDestination: (Destination*) destination {
    // TO DO: fazer lógica de cruzar amigos que já curtiram determinado destino.
    return [self.friends count];
}

@end
