//
//  WebServiceAction.h
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractWebService : NSObject

// Defaults to 3.
@property(nonatomic, readonly) NSInteger maxRetries;
// Defaults to  20 seconds.
@property(nonatomic, readonly) NSTimeInterval requestTimeout;


@end
