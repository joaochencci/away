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

@interface MainViewController () <UIScrollViewDelegate> {
    Boolean didTouchButton;
}

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
@property (weak, nonatomic) IBOutlet UIImageView *goAwayHoverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *dontGoAwayHoverImageView;

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
    session.currentDestination.indexCurrentViewPoint = 0;
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
    if ([decision isEqualToString:@"goAway"]) {
        [self addDestination];
    }else if ([decision isEqualToString:@"dontGoAway"]) {
        //
    }
}

- (void) populateView {
    Session *session = [Session sharedSession];
    Destination *destination = session.currentDestination;
    
    self.destinationTitleLabel.text = destination.title;
    DestinationViewPoint *dvp = [destination.viewPoints objectAtIndex:destination.indexCurrentViewPoint];
    self.currentDestinationShadow.image = dvp.image;

    if (dvp.distance >= 600){
        self.transportationImage.image = [UIImage imageNamed:@"icon_plane"];
    }else{
        self.transportationImage.image = [UIImage imageNamed:@"icon_car"];
    }

    NSArray *array;
    if (destination.basePrice <= 200){
        array = @[@1,@0,@0,@0,@0];
    }else if (destination.basePrice > 200 && destination.basePrice <= 400){
        array = @[@1,@1,@0,@0,@0];
    }else if (destination.basePrice > 400 && destination.basePrice <= 600){
        array = @[@1,@1,@1,@0,@0];
    }else if (destination.basePrice > 600 && destination.basePrice <= 800){
        array = @[@1,@1,@1,@1,@0];
    }else if (destination.basePrice > 800){
        array = @[@1,@1,@1,@1,@1];
    }
    [self populateMoneyWithArray:array];
}

- (void)populateMoneyWithArray:(NSArray*)array {
    UIImage *moneyYes = [UIImage imageNamed:@"icon_money_yes"];
    UIImage *moneyNo = [UIImage imageNamed:@"icon_money_no"];
    NSNumber *n1 = [NSNumber numberWithInt:1];
    if ([[array objectAtIndex:0] isEqualToNumber:n1]){
        self.money1ImageView.image = moneyYes;
    }else{
        self.money1ImageView.image = moneyNo;
    }

    if ([[array objectAtIndex:1] isEqualToNumber:n1]){
        self.money2ImageView.image = moneyYes;
    }else{
        self.money2ImageView.image = moneyNo;
    }

    if ([[array objectAtIndex:2] isEqualToNumber:n1]){
        self.money3ImageView.image = moneyYes;
    }else{
        self.money3ImageView.image = moneyNo;
    }

    if ([[array objectAtIndex:3] isEqualToNumber:n1]){
        self.money4ImageView.image = moneyYes;
    }else{
        self.money4ImageView.image = moneyNo;
    }

    if ([[array objectAtIndex:4] isEqualToNumber:n1]){
        self.money5ImageView.image = moneyYes;
    }else{
        self.money5ImageView.image = moneyNo;
    }
}

- (void)addDestination {
    Session *session = [Session sharedSession];
    Destination *dest = session.currentDestination;
    NSMutableArray *destinationsChoose = session.destinationsChoose;
    [destinationsChoose addObject:dest];

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    NSArray *array = [[NSArray alloc] initWithArray:destinationsChoose];
    array = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    session.destinationsChoose = [[NSMutableArray alloc] initWithArray:array];
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
    self.goAwayButton.enabled = TRUE;
    self.dontGoAwayButton.enabled = TRUE;
    if (scrollView.contentOffset.x < 320) {
        [self resetConfigButtons];
        [self decisionDestination:@"goAway"];
        [self nextDestination];
    } else if (scrollView.contentOffset.x >= 640) {
        [self resetConfigButtons];
        [self decisionDestination:@"dontGoAway"];
        [self nextDestination];
    } else {
        // CENTER PAGE
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // Increasing nextImageAlpha
    NSInteger offset = fabs(scrollView.contentOffset.x - 320.0);
    CGFloat nextDestinationAlpha = (((0.98f - 0.6f)/320.0f) * offset) + 0.6f;
    self.nextDestinationPlaceholderImageView.alpha = nextDestinationAlpha;
    
    
    if (!didTouchButton){
        if (scrollView.contentOffset.x < 320){
            self.goAwayButton.enabled = FALSE;
            self.dontGoAwayButton.enabled = FALSE;
            self.goAwayHoverImageView.hidden = NO;
            self.goAwayHoverImageView.alpha = 1 - (scrollView.contentOffset.x / 320);
            self.goAwayButton.alpha = scrollView.contentOffset.x / 320;
        }
        if (scrollView.contentOffset.x > 320){
            self.goAwayButton.enabled = FALSE;
            self.dontGoAwayButton.enabled = FALSE;
            float diff = scrollView.contentOffset.x - 320;
            self.dontGoAwayHoverImageView.hidden = NO;
            self.dontGoAwayHoverImageView.alpha = diff / 320;
            self.dontGoAwayButton.alpha = 1 - (diff / 320);
        }
    }
}

# pragma mark - Flu

- (void)resetConfigButtons {
    self.goAwayHoverImageView.hidden = YES;
    self.dontGoAwayHoverImageView.hidden = YES;
    self.goAwayButton.alpha = 1;
    self.dontGoAwayButton.alpha = 1;
    self.nextDestinationPlaceholderImageView.alpha = 0.6;
}

- (void)nextDestination
{
    Session *session = [Session sharedSession];

    Destination *d = [session.destinations dequeueObject];
    [session.destinations enqueueObject:d];

    session.currentDestination = [session.destinations objectAtIndex:0];
    session.currentDestination.indexCurrentViewPoint = 0;

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
    [self resetConfigButtons];
    didTouchButton = false;
}


- (IBAction)goAway:(id)sender {
    didTouchButton = true;
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    [self decisionDestination:@"goAway"];
    [self performSelector:@selector(nextDestination) withObject:Nil afterDelay:0.2];
    self.dontGoAwayButton.enabled = TRUE;
}

- (IBAction)dontGoAway:(id)sender {
    didTouchButton = true;
    [self.scrollView setContentOffset:CGPointMake(640.0, 0.0) animated:YES];
    [self decisionDestination:@"dontGoAway"];
    [self performSelector:@selector(nextDestination) withObject:Nil afterDelay:0.2];
    self.goAwayButton.enabled = TRUE;
}

- (IBAction)dontGoAwayPress:(id)sender {
    self.goAwayButton.enabled = FALSE;
}

- (IBAction)goAwayPress:(id)sender {
    self.dontGoAwayButton.enabled = FALSE;
}

@end
