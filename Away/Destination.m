//
//  Destination.m
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "Destination.h"
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
    //
    return images;
}

- (CGFloat)getDistanceFromPoint:(CGPoint *)point
{
    //
    return 0.0;
}

- (UIImage*)getFirstImage {
    return [self.viewPoints objectAtIndex:0];
}

- (NSInteger)getNumberOfFriendsFromUser:(User*) user {
    return [user getNumberOfFriendsFromDestination: self];
}

@end
