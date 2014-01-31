//
//  RawHTTPDataParser.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "RawHTTPDataParser.h"

@interface RawHTTPDataParser () {
    RawHTTPDataType _dataType;
}

+ (NSDictionary *)jsonParser:(NSData *)jsonData error:(NSError *)error;

@end

@implementation RawHTTPDataParser

# pragma mark - Public

+ (HTTPResponseObject *)parseData:(NSData *)dataToParse forDataType:(RawHTTPDataType)dataType
{
    //
    NSError *error;
    
    NSDictionary *responseData;
    
    switch (dataType) {
        case RawHTTPDataTypeJSON:
            responseData = [RawHTTPDataParser jsonParser:dataToParse error:error];
            break;
            
        default:
            break;
    }
    
    HTTPResponseObject *response = [[HTTPResponseObject alloc] initWithResponseData:responseData
                                                                            dataTye:dataType
                                                                              error:error];
    return response;
    
}

# pragma mark - Private

+ (NSDictionary *)jsonParser:(NSData *)jsonData error:(NSError *)error
{
    //
    NSDictionary *parsedJSONData = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    
    if (error) {
        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (error).localizedDescription);
    }
    
    return [parsedJSONData copy];
}

@end
