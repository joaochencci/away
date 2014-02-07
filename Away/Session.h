//
//  Session.h
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Destination.h"
#import "User.h"

@interface Session : NSObject <CLLocationManagerDelegate> {
    Destination *currentDestination;
    NSMutableArray *destinationsChoose;
    NSMutableArray *destinationsReject;
    CLLocation *currentLocation;
    Destination *currentDestinationDetail;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Destination *currentDestination;
@property (nonatomic, retain) Destination *currentDestinationDetail;
@property (nonatomic, retain) NSMutableArray *destinations;

@property (nonatomic, retain) NSMutableArray *destinationsChoose;
@property (nonatomic, retain) NSMutableArray *destinationsReject;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) CLLocationManager *locationManager;

+ (id)sharedSession;
- (NSMutableArray*)initializeDestinationsWithDictionary:(NSDictionary *)dict;
- (BOOL)isDestination: (Destination*)dest in: (NSMutableArray*)dests;
- (void)removeDestinationAtIndex:(NSInteger)index;

@end
