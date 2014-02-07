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


@implementation Destination

- (id)init
{
    self = [super init];
    if (self) {
        DestinationViewPoint *dvp = [[DestinationViewPoint alloc] init];
        NSMutableArray *viewPoints = [[NSMutableArray alloc] init];
        [viewPoints addObject:dvp];
        self.viewPoints = viewPoints;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [self init];
    if (self) {
        self.title = dict[@"name"];
        self.description = dict[@"info"];
    }
    return self;
}

//# pragma mark - Public
//- (NSArray *)getAllImages
//{
//    //
//    return images;
//}

- (CGFloat)getDistanceFromPoint:(CGPoint *)point
{
    //
    return 0.0;
}

- (UIImage*)getFirstImage {
    DestinationViewPoint *dvp = [self.viewPoints objectAtIndex:0];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: dvp.imageUrl]];
    return [UIImage imageWithData:imageData];
}

- (NSInteger)getNumberOfFriendsFromUser:(User*) user {
    return [user getNumberOfFriendsFromDestination: self];
}

@end
