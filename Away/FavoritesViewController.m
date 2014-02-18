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

@interface FavoritesViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_home_screen"]];
    
    logo.center = self.view.center;
    logo.alpha = 0.1f;
    
//    logo.layer.shadowColor = [UIColor blackColor].CGColor;
//    logo.layer.shadowRadius = 4.0f;
//    logo.layer.shadowOffset = CGSizeMake(1.0, 1.0);
//    
    [self.view insertSubview:logo belowSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UITableView
# pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Session *session = [Session sharedSession];
    return [session.destinationsChoose count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[FavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Session *session = [Session sharedSession];
    Destination *destination = [session.destinationsChoose objectAtIndex:indexPath.row];
    
    // Coloca os valores da célula
    cell.destinationTitle.text = destination.title;
    NSArray *allImages = [destination getAllImages];
    [cell setUpWithImages:allImages andCurrentIndex:destination.indexCurrentViewPoint];
    
    [cell startAnimating];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

# pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(FavoriteTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell stopAnimating];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Apagar";
}

/* Método chamado quando acontece algum tipo de edição em alguma célula do tableView */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Verifica se a ação corresponde a deleção.
    if (editingStyle == UITableViewCellEditingStyleDelete){
        Session *session = [Session sharedSession];
        [session removeDestinationAtIndex:indexPath.row];
        
        // Remove do tableView
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Session *session = [Session sharedSession];
    Destination *destination = [session.destinationsChoose objectAtIndex:indexPath.row];
    
    FavoriteTableViewCell *cell = (FavoriteTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    destination.indexCurrentViewPoint = cell.viewPointIndex;
    session.currentDestinationDetail = destination;
    [self performSegueWithIdentifier:@"goToDetailsFromTable" sender:self];
}

@end
