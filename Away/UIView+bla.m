//
//  UIView+bla.m
//  Away
//
//  Created by Marcelo Toledo on 2/7/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "UIView+bla.h"

@implementation UIView (bla)

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    // If the touch was in the placardView, move the placardView to its location
    if ([touch view] == placardView) {
        CGPoint location = [touch locationInView:self];
        placardView.center = location;
        return;
    }


@end
