//
//  FavoritesViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Session.h"
#import "FavoriteTableViewCell.h"

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Session *session = [Session sharedSession];
    return [session.destinationsChoose count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"Cell";
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[FavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    Session *session = [Session sharedSession];
    Destination *dest = [session.destinationsChoose objectAtIndex:indexPath.row];
    
    // Coloca os valores da célula
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:101];
    UILabel *name = (UILabel *)[cell viewWithTag:102];
    UILabel *numberOfFriends = (UILabel *)[cell viewWithTag:103];
    imageView.image = [dest getFirstImage];
    name.text = dest.title;
    numberOfFriends.text = [NSString stringWithFormat:@"%d", [dest getNumberOfFriendsFromUser:session.user]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Session *session = [Session sharedSession];
    Destination *dest = [session.destinationsChoose objectAtIndex:indexPath.row];
    session.currentDestination = dest;
    [self performSegueWithIdentifier:@"goToDetailsFromTable" sender:self];
}

@end
