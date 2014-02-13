//
//  DetailViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailFriendCustomCell.h"
#import "DestinationViewPoint.h"
#import "Session.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate>
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
@property (weak, nonatomic) IBOutlet UIScrollView *viewPointsScrollView;

@end

@implementation DetailViewController {
//    NSOperationQueue *queue;
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    Session *session = [Session sharedSession];
//    return [session.user getNumberOfFriendsFromDestination:session.destination];
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"fbCell";
    DetailFriendCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

//    NSString *url = @"http://graph.facebook.com/#ID#/picture?type=square";
    // TRAZER LISTA DE AMIGOS QUE CURTIRAM TAMBÉM ESSE DESTINO, PRA PEGAR O ID, PARA USAR NA IMAGEM.
//    url = [url stringByReplacingOccurrencesOfString:@"#ID#" withString:@"100001257114590"];

//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
//            cell.friendImageView.image = [UIImage imageWithData: imageData];
//            [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundView:cell.friendImageView];
//        }];
//    }];
//    [queue addOperation:operation];
    return cell;
}

# pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    Session *session = [Session sharedSession];
    Destination *dest = session.currentDestinationDetail;
    DestinationViewPoint *dvp = [dest.viewPoints objectAtIndex:self.viewPointsScrollView.contentOffset.x / 300];
    self.nameLabel.text = dvp.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%d km", dvp.distance];
}

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

    Session *session = [Session sharedSession];
    Destination *dest = session.currentDestinationDetail;

    for (int i = 0; i < [dest.viewPoints count]; i++) {
        CGFloat xOrigin = i * self.viewPointsScrollView.frame.size.width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.viewPointsScrollView.frame.size.width, self.viewPointsScrollView.frame.size.height)];
        DestinationViewPoint *dvp = [dest.viewPoints objectAtIndex:i];
        imageView.image = dvp.image;
        [self.viewPointsScrollView addSubview:imageView];
    }
    self.viewPointsScrollView.contentSize = CGSizeMake(self.viewPointsScrollView.frame.size.width * [dest.viewPoints count], self.viewPointsScrollView.frame.size.height);
    DestinationViewPoint *dvp = [dest.viewPoints objectAtIndex:0];
    self.nameLabel.text = dvp.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%d km", dvp.distance];

    [self populateView];

//    queue = [[NSOperationQueue alloc] init];
}

- (void) populateView {
    Session *session = [Session sharedSession];
    Destination *destination = session.currentDestinationDetail;
    
    self.titleLabel.text = destination.title;
    self.descriptionLabel.text = destination.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showFriends:(id)sender {
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
