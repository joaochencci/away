//
//  TestViewController.m
//  Away
//
//  Created by Marcelo Toledo on 2/7/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "TestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FloatingShadowView.h"


@interface TestViewController () <UIScrollViewDelegate> {
    NSInteger _pageChanges;
    NSArray *_images;
}

//@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIScrollView *_scroll;
//@property (weak, nonatomic) IBOutlet UIView *shadow;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@property (weak, nonatomic) IBOutlet FloatingShadowView *shadowedView;

@end

@implementation TestViewController

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
    
    _pageChanges = 0;
    _images = [NSArray arrayWithObjects:[UIImage imageNamed:@"placeholder"],
               [UIImage imageNamed:@"placeholder2"],
               [UIImage imageNamed:@"placeholder3"], nil];
    
    self._scroll.delegate = self;
    
    
    self.shadowedView.image = [UIImage imageNamed:@"placeholder"];
    [self.shadowedView startFloatingAnimation];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self._scroll.contentSize = CGSizeMake(self.view.frame.size.width * 3, self._scroll.frame.size.height);
    self._scroll.contentOffset = CGPointMake(self.view.frame.size.width, 0.0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"(%f, %f)", scrollView.contentOffset.x, scrollView.contentOffset.y);
    if (scrollView.contentOffset.x < 320) {
        NSLog(@"LEFT PAGE");
        [self nextImage];
    } else if (scrollView.contentOffset.x >= 640) {
        NSLog(@"RIGHT PAGE");
        [self nextImage];
    } else {
        NSLog(@"CENTER PAGE");
    }
}

# pragma mark - Flu

- (void)nextImage
{
    _pageChanges++;
    
    NSInteger currentIndex = _pageChanges % [_images count];
    
    self.shadowedView.image = [_images objectAtIndex:(currentIndex)];
    //[self.image setNeedsDisplay];
    
    //self.image.alpha = 0.0;
    self.shadowedView.alpha = 0.0;
    
    self.label.alpha = 0.0;
    self.header.alpha = 0.0;
    
    NSString *title;
    self.headerLabel.text = [NSString stringWithFormat:@"%d", currentIndex];
    switch (currentIndex) {
        case 0:
            title = @"Fortaleza";
            break;
        case 1:
            title = @"Rio de Janeiro";
            break;
        case 2:
            title = @"São Paulo";
            break;
        default:
            break;
    }
    
    self.label.text = title;
    
    
    [self._scroll setContentOffset:CGPointMake(320.0, 0.0) animated:NO];
    
    
    
//    double delayInSeconds = 0.05;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        
//        
//    });
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         //self.image.alpha = 1.0;
                         self.shadowedView.alpha = 1.0;
                         self.label.alpha = 1.0;
                         self.header.alpha = 1.0;
                     } completion:^(BOOL finished){
                         self.backImage.image = [_images objectAtIndex:((_pageChanges + 1) % [_images count])];
                     }];
    
    
}


- (IBAction)buttonPress:(id)sender {
    [self._scroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    //[self nextImage];
    [self performSelector:@selector(nextImage) withObject:Nil afterDelay:0.2];
}

- (IBAction)buu:(id)sender {
    [self._scroll setContentOffset:CGPointMake(640.0, 0.0) animated:YES];
    [self performSelector:@selector(nextImage) withObject:Nil afterDelay:0.2];
    //[self nextImage];
}


@end
 //218, 213