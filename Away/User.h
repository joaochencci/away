//
//  User.h
//  Away
//
//  Created by Marcelo Toledo on 1/29/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>
    
@class Destination;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *likes;
@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSNumber *maxDistance;
@property (nonatomic, strong) NSNumber *maxValue;
@property (nonatomic, strong) NSMutableArray *location; // [0] = LAT  |  [1] = LNG


- (id)initWithDictionary:(NSDictionary *)userDataDictionary;
- (NSInteger)getNumberOfFriendsFromDestination:(Destination*) destination;

@end
