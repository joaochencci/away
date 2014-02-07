//
//  DestinationViewPoint.h
//  Away
//
//  Created by Marcelo Toledo on 2/1/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationViewPoint : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, readonly) CGPoint *coordinates;
@property(nonatomic, strong) NSString *imageUrl;
@property(nonatomic, strong) UIImage *image;

@end
