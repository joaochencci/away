//
//  RawHTTPDataParser.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTTPResponseObject.h"

typedef enum {
    RawHTTPDataTypeJSON
}RawHTTPDataType;

@interface RawHTTPDataParser : NSObject

- (id)initWithDataType:(RawHTTPDataType)dataType;
- (HTTPResponseObject *)parseData:(NSData *)dataToParse;

@end
