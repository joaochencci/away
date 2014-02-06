//
//  Session.m
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "Session.h"

@implementation Session

@synthesize user;
@synthesize currentDestination;
@synthesize destinations;

@synthesize destinationsChoose;
@synthesize destinationsReject;
@synthesize currentLocation;
@synthesize locationManager;

#pragma mark Singleton Methods

+ (id)sharedSession {
    static Session *sharedSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSession = [[self alloc] init];
    });
    return sharedSession;
}

- (id)init {
    if (self = [super init]) {
        destination = [[Destination alloc] init];
        destinationsChoose = [[NSMutableArray alloc] init];
        destinationsReject = [[NSMutableArray alloc] init];

        currentLocation = [[CLLocation alloc] init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
    return self;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //if the time interval returned from core location is more than two minutes we ignore it because it might be from an old session
//    if ( abs((int) [newLocation.timestamp timeIntervalSinceDate: [NSDate date]]) < 120) {
        self.currentLocation = newLocation;
//    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (BOOL)isDestination: (Destination*)dest in: (NSMutableArray*)dests {
    for (Destination *d in dests) {
        if ([d._id isEqualToString:dest._id]){
            return TRUE;
        }
    }
    return FALSE;
}

- (void)removeDestinationAtIndex:(NSInteger)index
{
    if (index >= 0 && index < [self.destinationsChoose count]){
        [self.destinationsChoose removeObjectAtIndex:index];
    }
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
