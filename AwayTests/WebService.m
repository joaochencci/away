//
//  AbstractWebService.m
//  Away
//
//  Created by Marcelo Toledo on 2/6/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "AbstractWebServicePrivate.h"

@interface WebService : XCTestCase <HTTPRequestDelegate> {
    AbstractWebService *_testWebService;
}

@end

@implementation WebService

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _testWebService = [AbstractWebService sharedWebService];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test

@end
