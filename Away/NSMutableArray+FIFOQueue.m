//
//  NSMutableArray+FIFOQueue.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "NSMutableArray+FIFOQueue.h"

@implementation NSMutableArray (FIFOQueue)

- (void)enqueueObject:(id)object
{
    // Places an object at the end of the queue.
    [self addObject:object];
}

- (id)dequeueObject
{
    // If Queue not empty, returns first object,
    // otherwise returns nil.
    id dequeuedObject = [self firstObject];
    
    if (dequeuedObject) {
        [self removeObjectAtIndex:0];
    }
    
    return dequeuedObject;
}

@end
