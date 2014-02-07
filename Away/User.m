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
        self.location = [[NSMutableArray alloc] init];
        self.matches = [[NSMutableArray alloc] init];
        self.friends = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [self init];
    if (self) {
        NSDictionary *userDict = dict[@"user"];
        self.name = userDict[@"name"];
        NSDictionary *matchesArray = userDict[@"matches"];
        for (NSDictionary *match in matchesArray) {
//            NSString *type = match[@"type"];
            Destination *dest = [[Destination alloc] init];
            dest.title = match[@"name"];
            dest.description = match[@"info"];
        }
    };
    return self;
}

- (NSInteger)getNumberOfFriendsFromDestination: (Destination*) destination {
    // TO DO: fazer lógica de cruzar amigos que já curtiram determinado destino.
    return [self.friends count];
}

@end
