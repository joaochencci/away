//
//  MySubclass.h
//  Away
//
//  Created by Marcelo Toledo on 2/2/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "MyClass.h"

@interface MySubclass : MyClass

- (NSInteger)returnPublicInteger;
- (NSInteger)returnPrivateAtribute;
- (NSInteger)returnPrivateProperty;

- (void)callPrivateMethod;
- (void)useInternalMethod;

@end
