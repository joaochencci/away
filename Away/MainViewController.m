//
//  MainViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "MainViewController.h"
#import "Session.h"
#import "Destination.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *destinationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money4ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money5ImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberFriendsLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation MainViewController

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

    UIImage *imagefavoritesButton = [UIImage imageNamed:@"icon_star"];
    CGSize newSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [imagefavoritesButton drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    imagefavoritesButton = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIBarButtonItem *favoritesButton = [[UIBarButtonItem alloc] initWithImage:imagefavoritesButton style:UIBarButtonItemStylePlain target:self action:@selector(favorites:)];

    UIImage *imageSettingsButton = [UIImage imageNamed:@"icon_settings"];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [imageSettingsButton drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    imageSettingsButton = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:imageSettingsButton style:UIBarButtonItemStylePlain target:self action:@selector(settings:)];

    [self.navigationController setNavigationBarHidden:FALSE];
    NSArray *buttons= [[NSArray alloc] initWithObjects:settingsButton,favoritesButton,nil];
    self.navigationItem.rightBarButtonItems = buttons;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];

    Session *session = [Session sharedSession];
    Destination *dest = [[Destination alloc] init];
    dest._id = @"1";
    dest.title = @"Fortaleza";
    session.destination = dest;
    self.nameLabel.text = dest.title;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processSwipeInDirection: (UISwipeGestureRecognizerDirection) direction{
    Session *session = [Session sharedSession];
    Destination *dest = session.destination;
    
    if (direction == UISwipeGestureRecognizerDirectionRight) {
        // NSLog(@"Right Swipe");
        NSMutableArray *destinationsChoose = session.destinationsChoose;
        [destinationsChoose addObject:dest];
        session.destinationsChoose = destinationsChoose;
    }
    if (direction == UISwipeGestureRecognizerDirectionLeft) {
        // NSLog(@"Left Swipe");
        NSMutableArray *destinationsReject = session.destinationsReject;
        [destinationsReject addObject:dest];
        session.destinationsReject = destinationsReject;
    }

    Destination *newDest = [[Destination alloc] init];
    newDest._id = @"2";
    newDest.title = @"Curitiba";
    session.destination = newDest;
    
    self.nameLabel.text = newDest.title;
}

- (IBAction)choose:(id)sender {
    [self processSwipeInDirection: UISwipeGestureRecognizerDirectionRight];
}

- (IBAction)reject:(id)sender {
    [self processSwipeInDirection: UISwipeGestureRecognizerDirectionLeft];
}

- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"goToSettings" sender:self];
}

- (IBAction)favorites:(id)sender {
    [self performSegueWithIdentifier:@"goToFavorites" sender:self];
}

- (IBAction)details:(id)sender {
    [self performSegueWithIdentifier:@"goToDetail" sender:self];
}

- (IBAction)tapView:(UITapGestureRecognizer*)tap {
    [self performSegueWithIdentifier:@"goToDetail" sender:self];
}

- (IBAction)swipeView:(UISwipeGestureRecognizer*)swipe {
    [self processSwipeInDirection: swipe.direction];
}

@end
