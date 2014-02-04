//
//  UserRepository.m
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "UserRepository.h"

@implementation UserRepository

@synthesize destination;
@synthesize indexDestinations;
@synthesize destinations;
@synthesize destinationsChoose;
@synthesize destinationsReject;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static UserRepository *sharedUserAux = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserAux = [[self alloc] init];
    });
    return sharedUserAux;
}

- (id)init {
    if (self = [super init]) {
        destinations = [self createDestinations];
        indexDestinations = 0;
        destination = nil;
        destinationsChoose = [[NSMutableArray alloc] init];
        destinationsReject = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray*)createDestinations {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    Destination *dest1 = [[Destination alloc] init];
    dest1.name = @"Fortaleza";
    dest1.title = @"Ceará";
    dest1.basePrice = 100;
    dest1.numberOfFriends = 10;
    dest1.firstImage = [UIImage imageNamed:@"placeholder1"];
    [array insertObject:dest1 atIndex:0];

    Destination *dest2 = [[Destination alloc] init];
    dest2.name = @"Cristo Redentor";
    dest2.title = @"Rio de Janeiro";
    dest2.basePrice = 80;
    dest2.numberOfFriends = 35;
    dest2.firstImage = [UIImage imageNamed:@"placeholder2"];
    [array insertObject:dest2 atIndex:1];

    Destination *dest3 = [[Destination alloc] init];
    dest3.name = @"Maresias";
    dest3.title = @"São Paulo";
    dest3.basePrice = 300;
    dest3.numberOfFriends = 15;
    dest3.firstImage = [UIImage imageNamed:@"placeholder3"];
    [array insertObject:dest3 atIndex:2];

    Destination *dest4 = [[Destination alloc] init];
    dest4.name = @"Poços de Caldas";
    dest4.title = @"Goiás";
    dest4.basePrice = 320;
    dest4.numberOfFriends = 7;
    dest4.firstImage = [UIImage imageNamed:@"placeholder4"];
    [array insertObject:dest4 atIndex:3];

    return array;
}

///* - (BOOL) containsUserInSession:(User*)user
//    Verifica se determinado usuário está na sessão.
// */
//- (BOOL) containsUserInSession:(User*)user {
//    for (User *u in usersSession) {
//        if ([u.mail isEqualToString:user.mail] &&
//            [u.password isEqualToString:user.password]){
//            return TRUE;
//        }
//    }
//    return FALSE;
//}
//
///* - (BOOL) containsUserRegistred:(User*)user
//    Verifica se determinado usuário está cadastrado.
// */
//- (BOOL) containsUserRegistred:(User*)user {
//    for (User *u in usersRegistred) {
//        if ([u.mail isEqualToString:user.mail] &&
//            [u.password isEqualToString:user.password]){
//            return TRUE;
//        }
//    }
//    return FALSE;
//}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
