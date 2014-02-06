//
//  ResponseObject.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "HTTPResponseObject.h"

@interface HTTPResponseObject () {
    //BOOL _httpResponseOk;
}

@property(nonatomic, readwrite, strong) id data;
@property(nonatomic, readwrite, strong) NSError *parseError;
@property(nonatomic, readwrite, strong) NSError *httpError;
@property(nonatomic, readwrite) RawHTTPDataType dataType;

@end

@implementation HTTPResponseObject

- (id)initWithResponseData:(id)responseParsedData
                   dataTye:(NSInteger)dataType
                parseError:(NSError *)parseError
{
    self = [super init];
    if (self) {
        self.dataType = dataType;
        self.Data = responseParsedData;
        self.parseError = parseError;
        self.httpError = nil;
    }
    return self;
}

- (BOOL)isOK
{
    if (self.httpError) {
        return NO;
    } else {
        return YES;
    }
}

@end
