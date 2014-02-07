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

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
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
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

@end

@implementation DetailViewController {
//    NSOperationQueue *queue;
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    Session *session = [Session sharedSession];
    return [session.user getNumberOfFriendsFromDestination:session.currentDestinationDetail];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"fbCell";
    DetailFriendCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    NSString *url = @"http://graph.facebook.com/#ID#/picture?type=square";
    // TRAZER LISTA DE AMIGOS QUE CURTIRAM TAMBÉM ESSE DESTINO, PRA PEGAR O ID, PARA USAR NA IMAGEM.
    url = [url stringByReplacingOccurrencesOfString:@"#ID#" withString:@"100001257114590"];

//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
            cell.friendImageView.image = [UIImage imageWithData: imageData];
//            [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundView:cell.friendImageView];
//        }];
//    }];
//    [queue addOperation:operation];
    return cell;
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

    Session *session = [Session sharedSession];

    for (int i = 0; i < [session.currentDestinationDetail.viewPoints count]; i++) {
//    for (int i = 0; i < 3; i++) {
        CGFloat xOrigin = i * self.imageScrollView.frame.size.width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.height)];
        DestinationViewPoint *dvp = [session.currentDestinationDetail.viewPoints objectAtIndex:i];
        imageView.image = dvp.image;
//        imageView.image = [UIImage imageNamed:@"placeholder"];
        [self.imageScrollView addSubview:imageView];
    }
    self.imageScrollView.contentSize = CGSizeMake(self.imageScrollView.frame.size.width * [session.currentDestinationDetail.viewPoints count], self.imageScrollView.frame.size.height);
//    self.imageScrollView.contentSize = CGSizeMake(self.imageScrollView.frame.size.width * 3, self.imageScrollView.frame.size.height);

//    queue = [[NSOperationQueue alloc] init];
    
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
