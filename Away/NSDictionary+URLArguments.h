//
//  NSDictionary+URLArguments.h
//  Away
//
//  Created by Marcelo Toledo on 2/4/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (URLArguments)

/// Retruns a string concatenating all URL Get Request arguments.
/// (with ? between arguments and = between key and value) - not escaped.
//
///
- (NSString *)stringForURLEscapedArguments;

@end
