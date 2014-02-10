//
//  FloatingShadowView.m
//  Away
//
//  Created by Marcelo Toledo on 2/10/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "FloatingShadowView.h"

#define CORNERRADIUS 5.0f;
#define SHADOWRADIUS 6.0f;
#define SCALEDSHADOWRADIUS 0.99f;
#define INITIALSHADOWOFFSET CGSizeMake(2, 7)

#define ANIMATIONOPTIONS (UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState)

@interface FloatingShadowView () {
    BOOL _animationRunning;
}

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation FloatingShadowView

@synthesize image = _image;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    // Initialization code
    _animationRunning = NO;
    
    
    CGRect newFrame = CGRectZero;
    newFrame.size = self.frame.size;
    self.imageView = [[UIImageView alloc] initWithFrame:newFrame];
    [self addSubview:self.imageView];
    
    // Setting up imageView
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = CORNERRADIUS;
    self.imageView.layer.shouldRasterize = YES;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    
    // Setting up view
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CORNERRADIUS;
    self.clipsToBounds = NO;
    
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = INITIALSHADOWOFFSET;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 6.0;
    self.layer.shouldRasterize = YES;
    
    //[self startFloatingAnimation];
}

- (void)setImage:(UIImage *)aImage
{
    _image = aImage;
    self.imageView.image = aImage;
    self.layer.rasterizationScale = self.imageView.image.scale;
    self.imageView.layer.rasterizationScale = self.imageView.image.scale;
    //[self.imageView setNeedsDisplay];
}

# pragma mark - Floating Animation

- (void)startFloatingAnimation
{
    NSTimeInterval animationDuration = 2.5;
    
    // Animating UIView Properties:
    //  - Center
    CGPoint newCenter = CGPointMake(self.center.x + 1,
                                    self.center.y + 4);
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:ANIMATIONOPTIONS
                     animations:^{
                         self.center = newCenter;
                     }
                     completion:^(BOOL completed){
                     }];
    
    // Animating Layer Properties:
    // - transform: scale and rotation
    // - shadowRadius
    // - shadowOffset
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.toValue = @0.99;
    
    // ShadowRadius
    CABasicAnimation *shadowRadiusAnim = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    shadowRadiusAnim.toValue = @4.5;
    
    // ShadowOffset
    CABasicAnimation *shadowOffsetWidthAnim = [CABasicAnimation animationWithKeyPath:@"shadowOffset.width"];
    shadowOffsetWidthAnim.toValue = [NSNumber numberWithDouble:(double)1.0];
    CABasicAnimation *shadowOffsetHeightAnim = [CABasicAnimation animationWithKeyPath:@"shadowOffset.height"];
    shadowOffsetHeightAnim.toValue = [NSNumber numberWithDouble:(double)6.0];
    
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnim.toValue = [NSNumber numberWithFloat:((0.1*M_PI)/180)];
    
    // Grouping Layer Animations
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = animationDuration;
    group.repeatCount = INFINITY;
    group.autoreverses = YES;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    group.animations = [NSArray arrayWithObjects:scaleAnim, shadowRadiusAnim, shadowOffsetWidthAnim, shadowOffsetHeightAnim, rotationAnim, nil];
    
    [self.layer addAnimation:group forKey:@"allImageViewAnimations"];
    
}


# pragma mark - PlayPause Animation
- (void)togglePlayPauseAnimation
{
    if (_animationRunning) {
        _animationRunning = NO;
        [self pauseLayer:self.layer];
    } else {
        _animationRunning = YES;
        [self resumeLayer:self.layer];
    }
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
