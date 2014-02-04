//
//  SettingsViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UISlider *priceSlider;

@end

@implementation SettingsViewController

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

    self.navigationItem.title = @"Configurações";

    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email", @"user_likes"]];
    
    // Set this loginUIViewController to be the loginView button's delegate
    loginView.delegate = self;
    
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 5);
    
    // Align the button in the center vertically
    loginView.center = self.view.center;
    
    // Add the button to the view
    [self.view addSubview:loginView];

}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
