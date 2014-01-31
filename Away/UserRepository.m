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
        destination = [[Destination alloc] init];
        destinationsChoose = [[NSMutableArray alloc] init];
        destinationsReject = [[NSMutableArray alloc] init];
    }
    return self;
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
