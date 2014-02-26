//
//  Session.m
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "Session.h"

@interface Session () {
    NSOperationQueue *_operationQueue;
}

@end
@implementation Session

@synthesize user;
@synthesize currentDestination;
@synthesize currentDestinationDetail;
@synthesize destinations;

@synthesize destinationsChoose;
//@synthesize destinationsReject;
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
//        destinationsReject = [[NSMutableArray alloc] init];
        user = [[User alloc] init];
        user.location = [[NSMutableArray alloc] init];
        currentLocation = [[CLLocation alloc] init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
        _operationQueue = [[NSOperationQueue alloc] init];

        [self populateDestinations];
        NSLog(@"finish init");
    }
    return self;
}

- (void)populateDestinations {
//    NSError *error = nil;
//    NSString *searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL] encoding:NSUTF8StringEncoding error:&error];
    NSMutableArray *dests = [NSMutableArray arrayWithArray:@[@"belohorizonte", @"brasilia", @"cuiaba", @"curitiba", @"fortaleza", @"fozdoiguacu", @"manaus", @"natal", @"portoalegre", @"recife", @"riodejaneiro", @"salvador", @"saopaulo"]];

    NSError *error = nil;
    for (NSString *dest in dests) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:dest ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        [destinations addObject:[self addDestinationWithObject:dict]];
    }
}

- (Destination*)addDestinationWithObject:(NSDictionary*)dict {
    Destination *dest = [[Destination alloc] init];
    dest.title = dict[@"name"];
    dest.description = dict[@"info"];
    dest.basePrice = [dict[@"base_price"] intValue];

    NSArray *points = dict[@"points"];
    for (NSDictionary *vpDict in points) {
        DestinationViewPoint *vp = [[DestinationViewPoint alloc] init];
        vp.name = vpDict[@"name"];
        vp.coordinates = @[vpDict[@"geo"][@"lat"],vpDict[@"geo"][@"lng"]];
        vp.imageUrl = vpDict[@"pic_url"];
        [dest.viewPoints addObject:vp];
    }
    return dest;
}

- (void)updateDistances {
    for (Destination *d in destinations) {
        for (DestinationViewPoint *vp in d.viewPoints) {
            vp.distance = [self calcDistanceFrom:user.location to:vp.coordinates];
        }
    }
}

- (double)calcDistanceFrom:(NSArray*)userLocation to:(NSArray*)viewPointLocation{
    NSArray *coordUser = [self convertCoordinatesToDegreesMinutesSeconds:userLocation];
    NSArray *coordViewPoint = [self convertCoordinatesToDegreesMinutesSeconds:viewPointLocation];

    NSArray *latUser = [coordUser objectAtIndex:0];
    NSArray *latViewPoint = [coordViewPoint objectAtIndex:0];
    NSArray *latFinal = [self diffCoordinate:latUser and:latViewPoint];

    NSArray *lngUser = [coordUser objectAtIndex:1];
    NSArray *lngViewPoint = [coordViewPoint objectAtIndex:1];
    NSArray *lngFinal = [self diffCoordinate:lngUser and:lngViewPoint];

    double latDegrees = [[latFinal objectAtIndex:0] doubleValue] * 60 * 1.852;
    double latMinutes = [[latFinal objectAtIndex:1] doubleValue] * 1.852;
    double latSeconds = [[latFinal objectAtIndex:2] doubleValue] * 1.852 / 60;
    double distX = latDegrees + latMinutes + latSeconds;
    
    double lngDegrees = [[lngFinal objectAtIndex:0] doubleValue] * 60 * 1.852;
    double lngMinutes = [[lngFinal objectAtIndex:1] doubleValue] * 1.852;
    double lngSeconds = [[lngFinal objectAtIndex:2] doubleValue] * 1.852 / 60;
    double distY = lngDegrees + lngMinutes + lngSeconds;

    double distFinal = sqrt(pow(distX, 2) + pow(distY, 2));
    return distFinal;
}

- (NSArray*)diffCoordinate:(NSArray*)coord1 and:(NSArray*)coord2 {
    double degrees1 = [[coord1 objectAtIndex:0] doubleValue];
    double minutes1 = [[coord1 objectAtIndex:1] doubleValue];
    double seconds1 = [[coord1 objectAtIndex:2] doubleValue];

    double degrees2 = [[coord2 objectAtIndex:0] doubleValue];
    double minutes2 = [[coord2 objectAtIndex:1] doubleValue];
    double seconds2 = [[coord2 objectAtIndex:2] doubleValue];

    double secondsFinal = seconds1 - seconds2;
    if (secondsFinal < 0){
        secondsFinal += 60;
        if (minutes1 > 0){
            minutes1 -= 1;
        }else{
            if (degrees1 > 0){
                degrees1 -= 1;
            }else{
                degrees1 += 1;
            }
            minutes1 = 59;
        }
    }
    
    double minutesFinal = minutes1 - minutes2;
    if (minutesFinal < 0){
        minutesFinal += 60;
        if (degrees1 > 0){
            degrees1 -= 1;
        }else{
            degrees1 += 1;
        }
    }

    double degreesFinal = abs(degrees1 - degrees2);
    NSNumber *degreesNumber = [[NSNumber alloc] initWithInt:degreesFinal];
    NSNumber *minutesNumber = [[NSNumber alloc] initWithInt:minutesFinal];
    NSNumber *secondsNumber = [[NSNumber alloc] initWithInt:secondsFinal];
    return @[degreesNumber, minutesNumber, secondsNumber];
}

- (NSArray*)convertCoordinatesToDegreesMinutesSeconds:(NSArray*)location {
    double latitude = [[location objectAtIndex:0] doubleValue];
    double longitude = [[location objectAtIndex:1] doubleValue];

    NSArray *latitudeArray = [self convertDegreesToDegreesMinutesSeconds:latitude];
    NSArray *longitudeArray = [self convertDegreesToDegreesMinutesSeconds:longitude];
    return @[latitudeArray, longitudeArray];
}

- (NSArray*)convertDegreesToDegreesMinutesSeconds:(double)coord {
    int seconds = (int)round(coord * 3600);
    int degrees = seconds / 3600;
    seconds = abs(seconds % 3600);
    int minutes = seconds / 60;
    seconds %= 60;
    NSNumber *degreesNumber = [[NSNumber alloc] initWithInt:degrees];
    NSNumber *minutesNumber = [[NSNumber alloc] initWithInt:minutes];
    NSNumber *secondsNumber = [[NSNumber alloc] initWithInt:seconds];
    return @[degreesNumber, minutesNumber, secondsNumber];
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
