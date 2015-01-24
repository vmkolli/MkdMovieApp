//
//  MovieCell.h
//  MkdMovieListApp
//
//  Created by Vinayakumar Kolli on 1/23/15.
//  Copyright (c) 2015 Vinayakumar Kolli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDesc;
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

@end
