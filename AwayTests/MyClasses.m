//
//  MyClasses.m
//  Away
//
//  Created by Marcelo Toledo on 2/2/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MyClass.h"
#import "MySubclass.h"

@interface MyClasses : XCTestCase

@end

@implementation MyClasses

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMyClass
{
    MyClass *myClass = [[MyClass alloc] init];
    
    [myClass publicMethod];
    
    XCTAssertTrue(myClass.publicInteger == 3, @"");
}

- (void)testMySubClass
{
    MySubclass *subclass = [[MySubclass alloc] init];
    
    XCTAssertTrue([subclass returnPrivateProperty] == 2, @" ");
}

- (void)testURL
{
    MyClass *myClass = [[MyClass alloc] init];
    
    NSURL *url = [myClass urlWithScheme:@"http" baseURL:@"httpbin.org" path:@"/" action:@"get" andParameters:@{@"key1": @"value1", @"key2": @"value2"}];
    
    XCTAssertTrue(YES, @"");
}

@end
