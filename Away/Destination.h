//
//  Destination.h
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface Destination : NSObject
@property(nonatomic) NSInteger identifier;
@property(strong, nonatomic) NSString *name;

@property(nonatomic, strong, readonly) NSString *_id;
@property(nonatomic, strong, readonly) NSString *title;
@property(nonatomic, strong, readonly) NSString *description;

@property(nonatomic) NSInteger basePrice;
@property(nonatomic) NSInteger numberOfFriends;

@property(nonatomic, strong, readonly) UIImage *firstImage;

- (id)initWithDictionary:(NSDictionary *)destinationDataDictionary;

- (NSArray *)getAllImages;

- (CGFloat)getDistanceFromPoint:(CGPoint *)point;

@end
