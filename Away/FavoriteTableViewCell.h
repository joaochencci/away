//
//  FavoriteTableViewCell.h
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteTableViewCell : UITableViewCell

@property(nonatomic, strong) NSArray *viewPointsImages;
@property(nonatomic, readonly) NSInteger viewPointIndex;

@property(nonatomic, weak) IBOutlet UIImageView *viewPointImageView;
@property(nonatomic, weak) IBOutlet UILabel *destinationTitle;


- (void)setUpWithImages:(NSArray *)images andCurrentIndex:(NSInteger)currentIndex;
- (void)startAnimating;
- (void)stopAnimating;

@end
