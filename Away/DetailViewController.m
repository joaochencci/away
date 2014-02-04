//
//  DetailViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "DetailViewController.h"
#import "Session.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *destinationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money4ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *money5ImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rejectButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

@end

@implementation DetailViewController

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"fbCell" forIndexPath:indexPath];
}

# pragma mark

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

    self.navigationItem.title = @"Detalhes";

    [self.destinationImageView setUserInteractionEnabled:YES];
    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.destinationImageView addGestureRecognizer:swipeLeft];
//    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.destinationImageView addGestureRecognizer:swipeRight];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choose:(id)sender {
    [self processSwipeInDirection: UISwipeGestureRecognizerDirectionRight];
}

- (IBAction)reject:(id)sender {
    [self processSwipeInDirection: UISwipeGestureRecognizerDirectionLeft];
}

- (IBAction)showFriends:(id)sender {
}

//- (IBAction)swipeView:(UISwipeGestureRecognizer*)swipe {
//    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
//        NSLog(@"Left Swipe");
//        
//    }
//    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
//        NSLog(@"Right Swipe");
//    }
//}

@end
