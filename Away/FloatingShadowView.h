//
//  FloatingShadowView.h
//  Away
//
//  Created by Marcelo Toledo on 2/10/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingShadowView : UIView

@property(nonatomic, strong, setter=setImage:) UIImage *image;

- (void)togglePlayPauseAnimation;
- (void)startFloatingAnimation;

- (void)setImage:(UIImage *)image;

@end
