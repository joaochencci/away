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
    // joined by ?, & and =.
    // Returns empty string "" in case of empty dictionary.
    
    // TODO(mingatos): check if all keys are string.
    
    BOOL isEmpty = ([self count] == 0);
    
    NSMutableString *getArgumentsString = [NSMutableString stringWithFormat:@""];
    
    if (!isEmpty) {
        
        [getArgumentsString appendString:@"?"];
        
        NSMutableArray *arguments = [[NSMutableArray alloc] init];
        
        for (NSString *key in self) {
            NSString *value = [self objectForKey:key];
            [arguments addObject:[NSString stringWithFormat:@"%@=%@",
                                  [key stringByEscapingForURLArgument],
                                  [value stringByEscapingForURLArgument]]];
        }
        
        [getArgumentsString appendString:[arguments componentsJoinedByString:@"&"]];
    }
    
    return getArgumentsString;
}

@end
