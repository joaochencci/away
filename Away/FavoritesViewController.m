//
//  FavoritesViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "FavoritesViewController.h"
#import "UserRepository.h"
#import "FavoriteTableViewCell.h"
#import "DetailViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

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

    self.navigationItem.title = @"Favoritos";

//    UserRepository *userRepo = [UserRepository sharedManager];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UserRepository *userRepo = [UserRepository sharedManager];
    return [userRepo.destinationsChoose count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"Cell";
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[FavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    UserRepository *userRepo = [UserRepository sharedManager];
    Destination *dest = [userRepo.destinationsChoose objectAtIndex:indexPath.row];
    
    // Coloca os valores da célula
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:101];
    UILabel *name = (UILabel *)[cell viewWithTag:102];
    UILabel *numberOfFriends = (UILabel *)[cell viewWithTag:103];
    name.text = dest.name;
//    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"placeholder%d", (indexPath.row % 4) + 1]];
    imageView.image = dest.firstImage;
    numberOfFriends.text = [NSString stringWithFormat:@"%ld", (long)dest.numberOfFriends];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserRepository *userRepo = [UserRepository sharedManager];
    Destination *dest = [userRepo.destinationsChoose objectAtIndex:indexPath.row];
    userRepo.destination = dest;
    [self performSegueWithIdentifier:@"goToDetailsFromTable" sender:self];
}

@end
