//
//  AbstractWebService.m
//  Away
//
//  Created by Marcelo Toledo on 2/6/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "AbstractWebServicePrivate.h"

#define TIMEOUT 10
#define MAXTRIES 3

@interface WebService : XCTestCase <HTTPRequestDelegate> {
    AbstractWebService *_testWebService;
    
    NSString *_urlScheme; // http
    NSString *_hostURL; // @"http://www.google.com"
    NSString *_path; // @"/away/api"
    NSString *_action; // @"login";
    
    NSDictionary *_requestParams; //
    
    // To serialize asynchronous execution
    dispatch_semaphore_t _semaphore;
    
    BOOL _callbackInvoked;
    
    HTTPResponseObject *_responseObject;
    NSError *_requestError;
}

@end

@implementation WebService

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _testWebService = [AbstractWebService sharedWebService];

    _urlScheme = @"http";
    _hostURL = @"httpbin.org";
    _path = @"/";
    _action = @"get";
    
    _requestParams = @{@"key1": @"value1"};
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _testWebService = nil;
    
    _urlScheme = nil;
    _hostURL = nil;
    _path = nil;
    _action = nil;
    
    _requestParams = nil;
    
}

- (void)testSingleton
{
    //
    AbstractWebService *webService = [AbstractWebService sharedWebService];
    XCTAssertEqualObjects(_testWebService, webService, @"Not singleton?");
}

- (void)testURLStringConstruction
{
    //
    NSString *urlString;
    // scheme, host and path. (action = nil; parameters = nil)
    urlString = [_testWebService urlStringWithScheme:_urlScheme
                                             hostURL:_hostURL
                                                path:_path
                                              action:nil
                                       andParameters:nil];
    XCTAssertEqualObjects(@"http://httpbin.org/",
                          urlString, @"");
    
    // scheme, host, path and action (action = @""; parameters = nil)
    urlString = [_testWebService urlStringWithScheme:_urlScheme
                                             hostURL:_hostURL
                                                path:_path
                                              action:@""
                                       andParameters:nil];
    
    XCTAssertEqualObjects(@"http://httpbin.org/",
                          urlString, @"");
    
    // scheme, host, path and action (parameters = nil)
    urlString = [_testWebService urlStringWithScheme:_urlScheme
                                             hostURL:_hostURL
                                                path:_path
                                              action:_action
                                       andParameters:nil];
    XCTAssertEqualObjects(@"http://httpbin.org/get",
                          urlString, @"");
    
    // scheme, host, path and action (parameters = @{})
    urlString = [_testWebService urlStringWithScheme:_urlScheme
                                             hostURL:_hostURL
                                                path:_path
                                              action:_action
                                       andParameters:@{}];
    XCTAssertEqualObjects(@"http://httpbin.org/get",
                          urlString, @"");
    
    // scheme, host, path, action and parameters.
    urlString = [_testWebService urlStringWithScheme:_urlScheme
                                             hostURL:_hostURL
                                                path:_path
                                              action:_action
                                       andParameters:_requestParams];
    XCTAssertEqualObjects(@"http://httpbin.org/get?key1=value1",
                          urlString, @"");
  

}

- (void)testConfiguration
{
    // change class internal atributes to private properties
    // config webservice and check if everyting ok.
}

- (void)testGETRequestLoading
{
    // config and aski to load get request and check request properties
}

- (void)testPOSTRequestLoading
{
    // config nd ask to load post request and check request properties
}

- (void)testCallback
{
    //
    _semaphore = dispatch_semaphore_create(0);
    
    [_testWebService configWebServiceScheme:_urlScheme
                                       host:_hostURL
                                       path:_path
                                     action:_action
                                 parameters:_requestParams
                                     method:@"GET"
                                  userAgent:@"ios7"
                                contentType:@"application/json"
                                    timeout:TIMEOUT
                                 maxRetries:MAXTRIES];
    [_testWebService loadGETRequestWithParameters:_requestParams];
    
    [_testWebService executeWithHandler:self];
    
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
            
            XCTAssertEqualObjects(val1, @"value1", @"BLU");
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
