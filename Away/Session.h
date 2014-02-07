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
#import "DestinationViewPoint.h"
#import "User.h"

@interface Session : NSObject <CLLocationManagerDelegate> {
    Destination *destination;
    Destination *currentDestination;
    Destination *currentDestinationDetail;
    NSMutableArray *destinationsChoose;
    NSMutableArray *destinationsReject;
    CLLocation *currentLocation;
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
- (BOOL)isDestination: (Destination*)dest in: (NSMutableArray*)dests;
- (void)removeDestinationAtIndex:(NSInteger)index;

@end
