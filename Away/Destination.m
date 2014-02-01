//
//  Destination.m
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "Destination.h"

@interface Destination () {
    NSArray *_images;
    NSMutableArray *_tags;
    CGFloat _geographicCoordinates;

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
        //
    }
    return self;
}

# pragma mark - Public
- (NSArray *)getAllImages
{
    //
    return _images;
}

- (CGFloat)getDistanceFromPoint:(CGPoint *)point
{
    //
    
    return 0.0;
}

@end
