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
#import "NSMutableArray+FIFOQueue.h"

#import "FloatingShadowView.h"

@interface MainViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *money1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money4ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money5ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nextDestinationPlaceholderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *currentDestinationImage;
@property (weak, nonatomic) IBOutlet UIImageView *transportationImage;
@property (weak, nonatomic) IBOutlet UIImageView *friendsImageView;

@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *goAwayButton;
@property (weak, nonatomic) IBOutlet UIButton *dontGoAwayButton;

@property (weak, nonatomic) IBOutlet UILabel *destinationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFriendsLabel;

@property (weak, nonatomic) IBOutlet FloatingShadowView *currentDestinationShadow;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [self.scrollView addGestureRecognizer:tap];

    self.scrollView.delegate = self;

// # request dos primeiros destinos # //
    Session *session = [Session sharedSession];
    session.currentDestination = [session.destinations objectAtIndex:0];
    session.indexCurrentViewPoint = 0;
    [self populateView];
    
    //self.currentDestinationImage.layer.masksToBounds = YES;
    //self.currentDestinationShadow.layer.cornerRadius = 10.0;
    //self.currentDestinationShadow.layer.shadowColor = [[UIColor blackColor] CGColor];
    //self.currentDestinationShadow.layer.shadowOpacity = 1.0;
    //self.currentDestinationShadow.layer.shadowRadius = 10.0;
    //self.currentDestinationShadow.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.currentDestinationShadow startFloatingAnimation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.indicator stopAnimating];

    Session *session = [Session sharedSession];

    self.scrollView.delegate = self;

    [UIView animateWithDuration:0.2
                     animations:^{
                         self.currentDestinationImage.alpha = 1.0;
                         self.currentDestinationShadow.alpha = 1.0;
                         self.destinationTitleLabel.alpha = 1.0;
                         self.toolBar.alpha = 1.0;
                     } completion:^(BOOL finished){
                         Destination *dest = [session.destinations objectAtIndex:1];
                         DestinationViewPoint *dvp = [dest.viewPoints objectAtIndex:0];
                         self.nextDestinationPlaceholderImageView.image = dvp.image;
                     }];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0.0);
}

- (void)viewWillAppear:(BOOL)animated
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0.0);

    [self populateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)decisionDestination: (NSString*) decision
{
    Session *session = [Session sharedSession];
    Destination *dest = session.currentDestination;
    
    if ([decision isEqualToString:@"goAway"]) {
        NSMutableArray *destinationsChoose = session.destinationsChoose;
        [destinationsChoose addObject:dest];
        session.destinationsChoose = destinationsChoose;
    }
    if ([decision isEqualToString:@"dontGoAway"]) {
        NSMutableArray *destinationsReject = session.destinationsReject;
        [destinationsReject addObject:dest];
        session.destinationsReject = destinationsReject;
    }
}

- (void) populateView {
    Session *session = [Session sharedSession];
    Destination *destination = session.currentDestination;
    
    self.destinationTitleLabel.text = destination.title;
    DestinationViewPoint *dvp = [destination.viewPoints objectAtIndex:session.indexCurrentViewPoint];
    self.currentDestinationShadow.image = dvp.image;

    if (destination.basePrice >= 200){
        self.transportationImage.image = [UIImage imageNamed:@"icon_plane"];
    }else{
        self.transportationImage.image = [UIImage imageNamed:@"icon_car"];
    }
}

- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"goToSettings" sender:self];
}

- (IBAction)favorites:(id)sender {
    [self performSegueWithIdentifier:@"goToFavorites" sender:self];
}

- (IBAction)details:(id)sender {
    Session *session = [Session sharedSession];
    session.currentDestinationDetail = session.currentDestination;
    [self performSegueWithIdentifier:@"goToDetail" sender:self];
}

- (IBAction)tapView:(UITapGestureRecognizer*)tap {
    Session *session = [Session sharedSession];
    session.currentDestinationDetail = session.currentDestination;
    [self performSegueWithIdentifier:@"goToDetail" sender:self];
}

# pragma mark - Firulas Layout
# pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"(%f, %f)", scrollView.contentOffset.x, scrollView.contentOffset.y);
    if (scrollView.contentOffset.x < 320) {
//        NSLog(@"LEFT PAGE");
        [self decisionDestination:@"goAway"];
        [self nextDestination];
    } else if (scrollView.contentOffset.x >= 640) {
//        NSLog(@"RIGHT PAGE");
        [self decisionDestination:@"dontGoAway"];
        [self nextDestination];
    } else {
//        NSLog(@"CENTER PAGE");
    }
}

# pragma mark - Flu

- (void)nextDestination
{
    Session *session = [Session sharedSession];

    Destination *d = [session.destinations dequeueObject];
    [session.destinations enqueueObject:d];

    session.currentDestination = [session.destinations objectAtIndex:0];
    session.indexCurrentViewPoint = 0;

    [self populateView];
    //-------[self.currentDestinationImage setNeedsDisplay];
    
    //self.currentDestinationShadow.alpha = 0.0;
    self.currentDestinationShadow.alpha = 0.0;
    
    self.destinationTitleLabel.alpha = 0.0;
    self.toolBar.alpha = 0.0;
    
    [self.scrollView setContentOffset:CGPointMake(320.0, 0.0) animated:NO];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         //self.currentDestinationImage.alpha = 1.0;
                         self.currentDestinationShadow.alpha = 1.0;
                         self.destinationTitleLabel.alpha = 1.0;
                         self.toolBar.alpha = 1.0;
                     } completion:^(BOOL finished){
                         Destination *dest = [session.destinations objectAtIndex:1];
                         DestinationViewPoint *dvp = [dest.viewPoints objectAtIndex:0];
                         self.nextDestinationPlaceholderImageView.image = dvp.image;
                     }];
}


- (IBAction)goAway:(id)sender {
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    [self decisionDestination:@"goAway"];
    [self performSelector:@selector(nextDestination) withObject:Nil afterDelay:0.2];
}

- (IBAction)dontGoAway:(id)sender {
    [self.scrollView setContentOffset:CGPointMake(640.0, 0.0) animated:YES];
    [self decisionDestination:@"dontGoAway"];
    [self performSelector:@selector(nextDestination) withObject:Nil afterDelay:0.2];
}



@end
