//
//  FIFOQueueTest.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//
//
//  Test Case for NSMutableArray FIFOQueue Category


#import <XCTest/XCTest.h>

#import "NSMutableArray+FIFOQueue.h"

@interface FIFOQueueTest : XCTestCase {
    NSMutableArray *_fifoQueue;
}

@end

@implementation FIFOQueueTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _fifoQueue = [[NSMutableArray alloc] init];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    _fifoQueue = nil;
}

- (void)testQueueInitialization
{
    // Queue initialized
    XCTAssertNotNil(_fifoQueue, @"INITIALIZATION ERROR!");
    
    // Queue empty
    NSInteger queueSize = [_fifoQueue count];
    XCTAssertEqual(queueSize, 0, @"FIFOQUEUE SHOULD BE EMPTY BUT CONTAINS %ld ELEMENTS!", (long)queueSize);
}

- (void)testQueueClass
{
    // FIFOQueue should be instance of NSMutable array.
    XCTAssertTrue([_fifoQueue isKindOfClass:[NSMutableArray class]], @"FIFO QUEUE NOT A NSMutableArray!");
}

- (void)testCategoryMethodsNotInSuperclass
{
    NSArray *notAFIFOQueue = [[NSArray alloc] initWithObjects: @1, @2, @3, nil];
    
    // Enqueue Object method
    BOOL arrayRespondsToEnqueue = [notAFIFOQueue respondsToSelector:@selector(enqueueObject:)];
    XCTAssertFalse(arrayRespondsToEnqueue, @"Error: Array object responding to FIFOQueue Category "
                                            "method enqueueObject: when it shouldn't.");

    
    // Dequeue Object method
    BOOL arrayRespondsToDequeue = [notAFIFOQueue respondsToSelector:@selector(dequeueObject)];
    XCTAssertFalse(arrayRespondsToDequeue, @"Error: Array object responding to FIFOQueue Category "
                   "method dequeueObject when it shouldn't.");
}



- (void)testEnqueue
{
    // Enqueuing objects and testing FIFOQueue size.
    
    [_fifoQueue enqueueObject:@123];
    XCTAssertNotEqual([_fifoQueue count], 1, @"");
    
    [_fifoQueue enqueueObject:@"myString"];
    XCTAssertTrue([_fifoQueue count] == 2, @"");
    
    [_fifoQueue enqueueObject:@1];
    [_fifoQueue enqueueObject:@2];
    [_fifoQueue enqueueObject:@3];
    XCTAssertTrue([_fifoQueue count] == 5, @"");
    
}
                                 
- (void)testDequeue
{
    // Enqueue objects to test dequeuing.
    
    [_fifoQueue enqueueObject:@123];
    [_fifoQueue enqueueObject:@"myString"];
    [_fifoQueue enqueueObject:@1];
    [_fifoQueue enqueueObject:@2];
    [_fifoQueue enqueueObject:@3];

    id dequeuedObject;

    // Dequeuing objects and testing FIFOQueue size and dequeued object.
    
    XCTAssertTrue([_fifoQueue count] == 5, @"");
    dequeuedObject = [_fifoQueue dequeueObject];
    XCTAssertEqualObjects(dequeuedObject, @123, @"Error: Dequeued object should be 123 but was %@.", dequeuedObject);
    
    XCTAssertTrue([_fifoQueue count] == 4, @"");
    dequeuedObject = [_fifoQueue dequeueObject];
    XCTAssertEqualObjects(dequeuedObject, @"myString", @"Error: Dequeued object should be 'myString' but was %@.", dequeuedObject);
    
    XCTAssertTrue([_fifoQueue count] == 3, @"");
    dequeuedObject = [_fifoQueue dequeueObject];
    XCTAssertEqualObjects(dequeuedObject, @1, @"Error: Dequeued object should be 1 but was %@.", dequeuedObject);
    
    XCTAssertTrue([_fifoQueue count] == 2, @"");
    dequeuedObject = [_fifoQueue dequeueObject];
    XCTAssertEqualObjects(dequeuedObject, @2, @"Error: Dequeued object should be 2 but was %@.", dequeuedObject);
    
    XCTAssertTrue([_fifoQueue count] == 1, @"");
    dequeuedObject = [_fifoQueue dequeueObject];
    XCTAssertEqualObjects(dequeuedObject, @3, @"Error: Dequeued object should be 3 but was %@.", dequeuedObject);
    
    XCTAssertTrue([_fifoQueue count] == 0, @"");
    dequeuedObject = [_fifoQueue dequeueObject];
    XCTAssertNil(dequeuedObject, @"Error: Dequeued object should be nil but was %@.", dequeuedObject);
}

@end
