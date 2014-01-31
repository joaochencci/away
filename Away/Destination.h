//
//  Destination.h
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Destination : NSObject

@property(nonatomic, strong) NSString *_id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *description;

@property(nonatomic) CGFloat geographicCoordinates;
@property(nonatomic) NSInteger basePrice;
@property(nonatomic) NSInteger numberOfFriends;

@property(nonatomic, strong, readonly) UIImage *firstImage;

- (id)initWithDictionary:(NSDictionary *)destinationDataDictionary;
- (NSArray *)getAllImages;

@end
