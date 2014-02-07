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
@synthesize currentDestinationDetail;
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
        destinations = [[NSMutableArray alloc] init];
        destinationsChoose = [[NSMutableArray alloc] init];
        destinationsReject = [[NSMutableArray alloc] init];

        currentLocation = [[CLLocation alloc] init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];

        [self populateDestinations];
    }
    return self;
}

- (void)populateDestinations {
    [destinations addObject:[self addDestinationWithName:@"Belo Horizonte"
                                               basePrice:200
                                          viewPointsName:@[@"Estádio Mineirão",@"Pq. Ecológico da Pampulha",@"Praça da Liberdade",@"Gruta da Lapinha"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/St5x1Az.jpg",@"https://i.imgur.com/HCicHCK.jpg",@"https://i.imgur.com/Rjhnrj9.jpg",@"https://i.imgur.com/PK0cJLC.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Brasília"
                                               basePrice:300
                                          viewPointsName:@[@"Pontão do Lago Sul",@"Ponte J. Kubitschek",@"Congresso Nacional",@"Estádio Mané Garrincha"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/UKFBAO8.jpg",@"https://i.imgur.com/H61XkiU.jpg",@"https://i.imgur.com/Lj3K9We.jpg",@"https://i.imgur.com/L4TI6IA.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Cuiabá"
                                               basePrice:250
                                          viewPointsName:@[@"Centro Histórico",@"Arena Pantanal",@"Parque Massairo Okamura"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/TsS3G28.jpg",@"https://i.imgur.com/1zdHHht.jpg",@"https://i.imgur.com/gJmHDZz.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Curitiba"
                                               basePrice:100
                                          viewPointsName:@[@"Arena da Baixada",@"Cataratas do Iguaçu",@"Bosque Alemão",@"Jardim Botânico de Curitiba"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/7je6Rnr.jpg",@"https://i.imgur.com/AzOirqE.jpg",@"https://i.imgur.com/MvywTqn.jpg",@"https://i.imgur.com/J5UovPl.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Fortaleza"
                                               basePrice:500
                                          viewPointsName:@[@"Praia das Fontes",@"Feira Beira Mar",@"Estádio Castelão",@"Praia do Futuro"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/Bd6JUBR.jpg",@"https://i.imgur.com/iVWeyuV.jpg",@"https://i.imgur.com/e4yN0gt.jpg",@"https://i.imgur.com/f6Px5tN.jpg"]
                             ]];

}

- (Destination*)addDestinationWithName:(NSString*)name basePrice:(int)basePrice viewPointsName:(NSArray*)viewPointsName andViewPointsImageUrl:(NSArray*)viewPointsImageUrl
{
    Destination *dest = [[Destination alloc] init];
    dest.title = name;
    dest.description = @"Lorem ipsum";
    dest.basePrice = basePrice;

    for (int i = 0 ; i < [viewPointsName count]; i++) {
        DestinationViewPoint *vp = [[DestinationViewPoint alloc] init];
        vp.name = viewPointsName[i];
        vp.imageUrl = viewPointsImageUrl[i];
        [dest.viewPoints addObject:vp];
    }
    return dest;
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
