//
//  HTTPRequest.m
//  Away
//
//  Created by Marcelo Toledo on 2/6/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "HTTPRequest.h"

#define TIMEOUT 10

@interface HTTPRequests : XCTestCase <HTTPRequestDelegate> {
    NSURL *_url;
    NSMutableURLRequest *_request;
    NSURLConnection *_connection;
    
    // To serialize asynchronous execution
    dispatch_semaphore_t _semaphore;
    
    BOOL _callbackInvoked;
    
    HTTPResponseObject *_responseObject;
    HTTPRequest *_httpRequest;
    NSError *_requestError;
}

@end

@implementation HTTPRequests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _url = nil;
    _request = nil;
    _connection = nil;
    _callbackInvoked = NO;
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSLog(@"%@", _responseObject);
}

- (void)testRequestCallback
{
    //
    _url = [NSURL URLWithString:@"http://httpbin.org/get?key1=value1&key2=value2"];
    _request = [NSMutableURLRequest requestWithURL:_url];
    _request.timeoutInterval = TIMEOUT * (3/4);
    
    _semaphore = dispatch_semaphore_create(0);
    
    _httpRequest = [[HTTPRequest alloc] initWithRequest:_request andDelegate:self];
    [_httpRequest executeRequestParsingData:RawHTTPDataTypeJSON asynch:NO];
    
    while (dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:TIMEOUT]];
    }
    
    XCTAssertTrue(_callbackInvoked,
                  @"Delegate not called.");
    if (!_requestError) {
        NSDictionary *responseData = (NSDictionary *)_responseObject.data;
        NSDictionary *arguments = (NSDictionary *)[responseData objectForKey:@"args"];
        XCTAssertNotNil(arguments, @"BU");
        if (arguments) {
            NSString *val1 = (NSString *)[arguments objectForKey:@"key1"];
            NSString *val2 = (NSString *)[arguments objectForKey:@"key2"];
            
            XCTAssertEqualObjects(val1, @"value1", @"BLU");
            XCTAssertEqualObjects(val2, @"value2", @"bajkbl");
        }
    } else {
        NSLog(@"Request not successfull");
    }
}


# pragma mark - HTTPRequest Delegate

- (void)request:(HTTPRequest *)request didFailWithError:(NSError *)error
{
    _callbackInvoked = YES;
    //_httpRequest = request;
    _responseObject = nil;
    _requestError = error;
    
    dispatch_semaphore_signal(_semaphore);
}

- (void)request:(HTTPRequest *)request didFinishWithResponseObject:(HTTPResponseObject *)responseObject
{
    _callbackInvoked = YES;
    //_httpRequest = request;
    _responseObject = responseObject;
    
    dispatch_semaphore_signal(_semaphore);
}

@end
