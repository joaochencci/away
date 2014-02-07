//
//  DestinationViewPoint.m
//  Away
//
//  Created by Marcelo Toledo on 2/1/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "DestinationViewPoint.h"

@interface DestinationViewPoint () {
    CGFloat *distance;
}

@end

@implementation DestinationViewPoint

- (id)init
{
    self = [super init];
    if (self) {
//        self.image = [[UIImage alloc] init];
//        self.imageUrl = [[NSString alloc] init];
//        self.name = [[NSString alloc] init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)viewPointDataDictionary
{
    self = [self init];
    if (self) {
        //
    }
    return self;
}

@end
