//
//  tViewController.m
//  Away
//
//  Created by Marcelo Toledo on 2/11/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "tViewController.h"

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@interface tViewController () {
    BOOL _logoTextHidden;
    CGRect _originalLogoFrame;
    UIView *shadowView;
}
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@end

@implementation tViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO];
    
    _logoTextHidden = NO;
    _originalLogoFrame = self.logo.frame;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideLogoText:(id)sender
{
    //fullFrame: (26, 203, 265, 135)
    //hiddenFrame: (26, 216, 62, 90)
    
    CGSize newSize;
    CGPoint newOrigin = self.logo.frame.origin;
    
    if (_logoTextHidden) {
        newSize = CGSizeMake(265.0f, 135.0f);
        newOrigin.x = self.view.center.x - (265/2);
        self.logo.layer.shadowColor = [UIColor clearColor].CGColor;
    } else {
        newSize = CGSizeMake(62.5f, 90.0f);
        newOrigin.x = self.view.center.x - ((62./2) + 1);
        self.logo.layer.shadowColor = [UIColor blackColor].CGColor;
    }
    
    CGRect newFrame = self.logo.frame;
    newFrame.size = newSize;
    newFrame.origin = newOrigin;
    
    [UIView animateWithDuration:0.22
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseOut)
                    animations:^{
                        self.logo.frame = newFrame;
                    } completion:^(BOOL finished) {
                        //
                        _logoTextHidden = !_logoTextHidden;
                    }];
}

- (IBAction)rotation:(UIButton *)sender
{
    // Rotation
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnim.toValue = [NSNumber numberWithFloat:((25*M_PI)/180)];
    
    // Grouping Layer Animations
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2.5;
    group.repeatCount = INFINITY;
    group.autoreverses = YES;
    //group.removedOnCompletion = NO;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = [NSArray arrayWithObjects:rotationAnim, nil];
    
    [self.logo.layer addAnimation:group forKey:@"allImageViewAnimations"];
    
    sender.enabled = NO;
    
}

- (IBAction)floating:(UIButton *)sender
{
    sender.enabled = NO;
    
    CGPoint newCenter = CGPointMake(self.logo.center.x + 1,
                                    self.logo.center.y + 30);
    [UIView animateWithDuration:2.5
                          delay:0.0
                        options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         self.logo.center = newCenter;
                     }
                     completion:^(BOOL completed){
                     }];
    
}

- (IBAction)shadow:(id)sender {
    
    if (shadowView) {
        [shadowView removeFromSuperview];
    }
    
    shadowView = [[UIView alloc] initWithFrame:self.logo.frame];
    [self.view insertSubview:shadowView belowSubview:self.logo];
    
    CGSize size = self.logo.frame.size;
    
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.7f;
    shadowView.layer.shadowOffset = CGSizeMake(50.0f, 40.0f);
    shadowView.layer.shadowRadius = 5.0f;
    shadowView.layer.masksToBounds = NO;
    
    
    
    CGRect ovalRect = CGRectMake(0.0f, size.height + 5, size.width - 10, 15);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    shadowView.layer.shadowPath = path.CGPath;
    
}

- (IBAction)rm:(id)sender {
    [self.logo.layer removeAllAnimations];
}

@end
