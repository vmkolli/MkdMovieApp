//
//  MKDMovieViewController.m
//  MkdMovieListApp
//
//  Created by Vinayakumar Kolli on 1/21/15.
//  Copyright (c) 2015 Vinayakumar Kolli. All rights reserved.
//

#import "MKDMovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"

@interface MKDMovieViewController () <UITableViewDataSource,UITableViewDelegate, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *MovieTableView;
@property (nonatomic, strong) NSArray *movies;

- (void)makeRequest: (Boolean)isPartial;
@end

@implementation MKDMovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        /*UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
        
        scroll.delegate = self;*/
        self.title = @"Movies";
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = [[NSDictionary alloc]initWithDictionary:self.movies[indexPath.row]];
    UIColor *color = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    cell.backgroundColor = color;
    cell.movieTitle.textColor = [UIColor whiteColor];
    cell.movieDesc.textColor = [UIColor whiteColor];
    
    cell.movieTitle.text = self.movies[indexPath.row][@"title"];
    cell.movieDesc.text = self.movies[indexPath.row][@"synopsis"];
    [cell.moviePoster setImageWithURL:[NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]]];
    
    NSLog(@"movie name is %@", self.movies[indexPath.row][@"title"]);
    return cell;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    [self makeRequest:NO];
    
    self.MovieTableView.dataSource = self;
    self.MovieTableView.delegate = self;
    self.MovieTableView.rowHeight = 128;
    
    [self.MovieTableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [self.MovieTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.MovieTableView;
    [tableViewController setRefreshControl:refreshControl];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailsViewController *mdvc = [[MovieDetailsViewController alloc] init];

    mdvc.movieData = self.movies[indexPath.row];
    
    [self.navigationController pushViewController:mdvc animated:YES];
}

- (void)refreshTable :(UIRefreshControl *) refreshControl {
    [self makeRequest:YES];
    [refreshControl endRefreshing];
}

- (void) makeRequest : (Boolean)isPartial {
    NSLog(@"Making call for partial %d", isPartial);
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=kjh6zyazfeaxvmjt5kq7d64j"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = responseDictionary[@"movies"];
        //NSArray *dummymovies = [[NSArray alloc]initWithObjects:@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",nil];
        //self.movies = [self.movies arrayByAddingObjectsFromArray:dummymovies];
        [self.MovieTableView reloadData];
        //NSLog(@"Data is %@", responseDictionary[@"movies"]);
    }];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
