//
//  DetailViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "DetailViewController.h"
#import "UserRepository.h"

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

@end

@implementation DetailViewController

@synthesize destination;

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

    UserRepository *userRepo = [UserRepository sharedManager];
    Destination *dest = [[Destination alloc] init];
    if (userRepo.destination != nil){
        dest = userRepo.destination;
        userRepo.destination = nil;
    }else{
        dest = [userRepo.destinations objectAtIndex:(userRepo.indexDestinations % 4)];
    }
    
    self.nameLabel.text = dest.name;
//    self.destinationImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"placeholder%d", (userRepo.indexDestinations % 4) + 1]];
    self.destinationImageView.image = dest.firstImage;
    self.titleLabel.text = dest.title;

    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.destinationImageView addGestureRecognizer:swipeLeft];
//    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.destinationImageView addGestureRecognizer:swipeRight];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processSwipeInDirection: (UISwipeGestureRecognizerDirection) direction{
    UserRepository *userRepo = [UserRepository sharedManager];

    Destination *dest = [userRepo.destinations objectAtIndex:(userRepo.indexDestinations % 4)];
    
    if (direction == UISwipeGestureRecognizerDirectionRight) {
        // NSLog(@"Right Swipe");
        NSMutableArray *destinationsChoose = userRepo.destinationsChoose;
        [destinationsChoose addObject:dest];
        userRepo.destinationsChoose = destinationsChoose;
    }
    if (direction == UISwipeGestureRecognizerDirectionLeft) {
        // NSLog(@"Left Swipe");
        NSMutableArray *destinationsReject = userRepo.destinationsReject;
        [destinationsReject addObject:dest];
        userRepo.destinationsReject = destinationsReject;
    }
    
    userRepo.indexDestinations++;
    Destination *newDest = [userRepo.destinations objectAtIndex:(userRepo.indexDestinations % 4)];
    
    self.nameLabel.text = newDest.name;
//    self.destinationImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"placeholder%d", (userRepo.indexDestinations % 4) + 1]];
    self.destinationImageView.image = newDest.firstImage;
    self.titleLabel.text = newDest.title;

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
