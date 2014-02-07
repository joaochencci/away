//
//  TestViewController.m
//  Away
//
//  Created by Marcelo Toledo on 2/7/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "TestViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIScrollView *_scroll;
@property (weak, nonatomic) IBOutlet UIView *shadow;

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
    
    self.image.layer.masksToBounds = YES;
    self.shadow.layer.cornerRadius = 10.0;
    self.shadow.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.shadow.layer.shadowOpacity = 1.0;
    self.shadow.layer.shadowRadius = 10.0;
    self.shadow.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self._scroll.contentSize = CGSizeMake(640,177);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
