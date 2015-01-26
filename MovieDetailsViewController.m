//
//  MovieDetailsViewController.m
//  MkdMovieListApp
//
//  Created by Vinayakumar Kolli on 1/23/15.
//  Copyright (c) 2015 Vinayakumar Kolli. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *movieImage;
@property float ScrollCount;
@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ScrollCount = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setScrollEnabled:YES];
    self.title = self.movieData[@"title"];
    
    self.movieTitle.text = self.movieData[@"title"];
    self.movieDesc.text = self.movieData[@"synopsis"];
    self.movieDesc.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.movieDesc.textColor = [UIColor whiteColor];

    
    
    
    
    
    
    self.movieDesc.frame = CGRectMake(0,0, self.movieDesc.frame.size.width, self.movieDesc.frame.size.height);
    [self.movieImage setImageWithURL:[NSURL URLWithString:[self.movieData valueForKeyPath:@"posters.original"]]];

    self.movieImage.frame = CGRectMake(0,0, self.movieImage.frame.size.width, self.movieImage.frame.size.height);
    
    UIView *view = [[UIView alloc] initWithFrame:self.movieDesc.frame];
    
    [self.scrollView addSubview:view];
    //[self.scrollView addSubview:self.movieImage];
    
    
    float sizeOfContent = 0;
    int i;
    for (i = 0; i < [self.scrollView.subviews count]; i++) {
        UIView *view =[self.scrollView.subviews objectAtIndex:i];
        sizeOfContent += view.frame.size.height;
    }
    
    // Set content size for scroll view
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, sizeOfContent);
    self.view.autoresizesSubviews=YES;
    self.scrollView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Doing Scroll");
    self.ScrollCount += 0.05;
    NSLog(@"%lf",self.scrollView.contentOffset.y);
    if(self.scrollView.frame.origin.y - self.ScrollCount > 370){
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y - self.ScrollCount, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
