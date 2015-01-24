//
//  MovieDetailsViewController.m
//  MkdMovieListApp
//
//  Created by Vinayakumar Kolli on 1/23/15.
//  Copyright (c) 2015 Vinayakumar Kolli. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

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
    self.title = self.movieData[@"title"];
    self.movieTitle.text = self.movieData[@"title"];
    self.movieDesc.text = self.movieData[@"synopsis"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
