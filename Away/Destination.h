//
//  Destination.h
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Destination : NSObject

@property(nonatomic, strong) NSString *_id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *description;

@property(nonatomic) NSInteger basePrice;
@property(nonatomic, strong) NSMutableArray *viewPoints;

- (id)initWithDictionary:(NSDictionary *)destinationDataDictionary;
//- (NSArray *)getAllImages;
- (CGFloat)getDistanceFromPoint:(CGPoint *)point;
- (UIImage*)getFirstImage;
- (NSInteger)getNumberOfFriendsFromUser:(User*)user;

@end
