//
//  ResponseObject.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTTPRawDataType.h"

@interface HTTPResponseObject : NSObject

@property(nonatomic, readonly, strong) id data;
@property(nonatomic, readonly, strong) NSError *parseError;
@property(nonatomic, readonly, strong) NSError *httpError;
@property(nonatomic, readonly) RawHTTPDataType dataType;

@property(nonatomic, readonly) BOOL isOK;

- (id)initWithResponseData:(id)responseParsedData
                   dataTye:(NSInteger)dataType
                parseError:(NSError *)parseError;

@end
