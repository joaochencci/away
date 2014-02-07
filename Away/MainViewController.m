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
#import "HTTPRequest.h"

@interface MainViewController () <HTTPRequestDelegate>
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
    session.currentDestination = [session.destinations objectAtIndex:0];;
    [self populateView];

//    CALayer *layer = self.destinationImageView.layer;
//    layer.cornerRadius = 5.0;
//    layer.borderColor = [[UIColor grayColor] CGColor];
//    layer.borderWidth = 3;
//    layer.frame = CGRectMake(-3, -3, CGRectGetWidth(self.destinationImageView.frame), CGRectGetHeight(self.destinationImageView.frame)+2);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processSwipeInDirection: (UISwipeGestureRecognizerDirection) direction{
    Session *session = [Session sharedSession];
    Destination *dest = session.currentDestination;
    
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

    [self selectNextDestination];
    [self populateView];
}

- (void) selectNextDestination {
    Session *session = [Session sharedSession];
    NSMutableArray *destinations = session.destinations;
    
    session.currentDestination = [destinations objectAtIndex:0];
    [destinations removeObjectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/api/destination/next"];
    HTTPRequest *request = [[HTTPRequest alloc] initWithRequest:[NSURLRequest requestWithURL:url] andDelegate:self];
    [request executeRequestParsingData:RawHTTPDataTypeJSON asynch:NO];
    
    session.destinations = destinations;
}

- (void) populateView {
    Session *session = [Session sharedSession];
    session.currentDestination = [session.destinations objectAtIndex:0];
    //    NSString *url = @"https://i.imgur.com/St5x1Az.jpg";
    //    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    //    self.destinationImageView.image = [UIImage imageWithData:imageData];
    self.destinationImageView.image = [session.currentDestination getFirstImage];
    self.nameLabel.text = session.currentDestination.title;
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

# pragma mark - HTTPRequest Delegate

- (void)request:(HTTPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error");
}

- (void)request:(HTTPRequest *)request didFinishWithResponseObject:(HTTPResponseObject *)responseObject
{
    Session *session = [Session sharedSession];
    Destination *newDestination = [[Destination alloc] initWithDictionary:responseObject.data];
    [session.destinations addObject: newDestination];
    NSLog(@"%@", responseObject.data);
}

@end
