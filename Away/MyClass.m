//
//  MyClass.m
//  Away
//
//  Created by Marcelo Toledo on 2/2/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "MyClass.h"
#import "NSDictionary+URLArguments.h"

@interface MyClass () {
    NSInteger _privateAtribute;
}

@property(nonatomic) NSInteger privateProperty;

- (void)privateMethod;

@end

@implementation MyClass

- (id)init
{
    self = [super self];
    if (self) {
        _privateAtribute = 1;
        self.privateProperty = 2;
        self.publicInteger = 3;
    }
    return self;
}

- (void)publicMethod
{
    NSLog(@"MyClass: publicMethod");
    [self privateMethod];
    
}

- (void)privateMethod
{
    NSLog(@"MyClass: privateMethod");
    [self logProperties];
}

- (void)logProperties
{
    NSLog(@"%d %d %d", _privateAtribute, self.privateProperty, self.publicInteger);
}

- (NSURL *)urlWithScheme:(NSString *)urlScheme
                 baseURL:(NSString *)baseURL
                    path:(NSString *)path
                  action:(NSString *)action
           andParameters:(NSDictionary *)parameters;
{
    
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@%@%@",
                           urlScheme, baseURL, path, action];
    
    if (parameters) {
        [urlString appendString:[parameters stringForURLEscapedArguments]];
    }
    
    //NSString *escapedURLString = [urlString stringByEscapingForURLArgument];
    
    NSURL *myURL = [NSURL URLWithString:urlString];
    
    NSLog(@"%@", myURL);
    
    return myURL;
}

@end
