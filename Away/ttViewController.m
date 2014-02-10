//
//  ttViewController.m
//  Away
//
//  Created by Marcelo Toledo on 2/10/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "ttViewController.h"
#import "FloatingShadowView.h"

@interface ttViewController ()


@property (weak, nonatomic) IBOutlet FloatingShadowView *iew;

@end

@implementation ttViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//40 190 230 230
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImage *img = [UIImage imageNamed:@"placeholder"];
    self.iew.image = img;
    [self.iew startFloatingAnimation];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
