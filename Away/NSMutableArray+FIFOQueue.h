//
//  NSMutableArray+FIFOQueue.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//
//  FIFOQueue Category
//
//  A Category to extend NSMutableArray to an FIFO Queue.
//  In order to use a NSMutableArray with the extended functionality
//  this header file should be imported do source code
//  where FIFOQueue will be used.
//
//  Just instantiate a NSMutableArray (or any of its subclasses)
//  and use the methods defined in this header file.

#import <Foundation/Foundation.h>

@interface NSMutableArray (FIFOQueue)

// Places an object at the end of the queue.
- (void)enqueueObject:(id)object;
// If Queue not empty, returns first object,
// otherwise returns nil.
- (id)dequeueObject;

@end
