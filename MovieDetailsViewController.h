//
//  MovieDetailsViewController.h
//  MkdMovieListApp
//
//  Created by Vinayakumar Kolli on 1/23/15.
//  Copyright (c) 2015 Vinayakumar Kolli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDesc;
@property (nonatomic, strong) NSDictionary *movieData;
@end
