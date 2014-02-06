//
//  MyClass.h
//  Away
//
//  Created by Marcelo Toledo on 2/2/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject

@property(nonatomic) NSInteger publicInteger;

- (void)publicMethod;

- (NSURL *)urlWithScheme:(NSString *)urlScheme
                 baseURL:(NSString *)baseURL
                    path:(NSString *)path
                  action:(NSString *)action
           andParameters:(NSDictionary *)parameters;

- (NSString *)urlStringWithScheme:(NSString *)urlScheme
                          baseURL:(NSString *)baseURL
                             path:(NSString *)path
                           action:(NSString *)action
                    andParameters:(NSDictionary *)parameters;

@end
