//
//  Destination.m
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "Destination.h"
#import "DestinationViewPoint.h"
#import "User.h"

@interface Destination () {
    NSArray *images;
    NSMutableArray *tags;
    CGFloat geographicCoordinates;
    NSInteger numberOfFriends;
}

@end

@implementation Destination

- (id)init
{
    self = [super init];
    if (self) {
        self.viewPoints = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)destinationDataDictionary
{
    self = [self init];
    if (self) {
        
        
    }
    return self;
}

# pragma mark - Public
- (NSArray *)getAllImages
{
    NSMutableArray* imgs = [[NSMutableArray alloc] init];
    for (DestinationViewPoint *dvp in self.viewPoints) {
        [imgs addObject:dvp.image];
    }
    return [imgs copy];
}

- (CGFloat)getDistanceFromPoint:(CGPoint *)point
{
    //
    return 0.0;
}

- (UIImage*)getFirstImage {
//    DestinationViewPoint *dvp = [self.viewPoints objectAtIndex:0];
//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: dvp.imageUrl]];
//    return [UIImage imageWithData:imageData];
    return nil;
}

- (NSInteger)getNumberOfFriendsFromUser:(User*) user {
    return [user getNumberOfFriendsFromDestination: self];
}

@end
