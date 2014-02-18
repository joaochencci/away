//
//  FavoriteTableViewCell.m
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "FavoriteTableViewCell.h"

@interface FavoriteTableViewCell ()

@property(nonatomic, readwrite) NSInteger viewPointIndex;

@end

@implementation FavoriteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

# pragma mark - Public Methods

- (void)setUpWithImages:(NSArray *)images andCurrentIndex:(NSInteger)currentIndex
{
    self.viewPointsImages = images;
    self.viewPointImageView.image = [images objectAtIndex:currentIndex];
}

- (void)startAnimating
{
    
}

- (void)stopAnimating
{
    
}

@end
