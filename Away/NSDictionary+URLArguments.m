//
//  NSDictionary+URLArguments.m
//  Away
//
//  Created by Marcelo Toledo on 2/4/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "NSDictionary+URLArguments.h"
#import "NSString+URLArguments.h"

@implementation NSDictionary (URLArguments)

- (NSString *)stringForURLEscapedArguments
{
    // Transforms a dictionary of http arguments into a string
    // joined by ? and =.
    // Returns empty string "" in case of empty dictionary.
    
    // TODO(mingatos): check if all keys are string.
    
    NSMutableString *getArgumentsString = [NSMutableString stringWithFormat:@""];
    
    for (NSString *key in self) {
        NSString *value = [self objectForKey:key];
        [getArgumentsString appendString:[NSString stringWithFormat:@"&%@=%@",
                                          [key stringByEscapingForURLArgument],
                                          [value stringByEscapingForURLArgument]]];
    }
    
    return getArgumentsString;
}

@end
