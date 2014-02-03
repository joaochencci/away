//
//  MySubclass.m
//  Away
//
//  Created by Marcelo Toledo on 2/2/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "MySubclass.h"

@interface MySubclass ()

@property(nonatomic) NSInteger privateProperty;

@end

@implementation MySubclass

- (NSInteger)returnPrivateAtribute
{
    return 90;
}

- (NSInteger)returnPrivateProperty
{
    return self.privateProperty;
}

@end
