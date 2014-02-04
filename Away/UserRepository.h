//
//  UserRepository.h
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"

@interface UserRepository : NSObject{
    Destination *destination;
    NSUInteger indexDestinations;
    NSMutableArray *destinations;
    NSMutableArray *destinationsChoose;
    NSMutableArray *destinationsReject;
}

@property (nonatomic, retain) Destination *destination;
@property (nonatomic) NSUInteger indexDestinations;
@property (nonatomic, retain) NSMutableArray *destinations;
@property (nonatomic, retain) NSMutableArray *destinationsChoose;
@property (nonatomic, retain) NSMutableArray *destinationsReject;

+ (id)sharedManager;

@end
