//
//  DvdViewController.m
//  MkdMovieListApp
//
//  Created by Vinayakumar Kolli on 1/24/15.
//  Copyright (c) 2015 Vinayakumar Kolli. All rights reserved.
//

#import "DvdViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"


@interface DvdViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *dvdTableView;

- (void)makeRequest: (Boolean)isPartial;
@end

@implementation DvdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"DVDs";
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = [[NSDictionary alloc]initWithDictionary:self.movies[indexPath.row]];
    cell.movieTitle.text = self.movies[indexPath.row][@"title"];
    cell.movieDesc.text = self.movies[indexPath.row][@"synopsis"];
    [cell.moviePoster setImageWithURL:[NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]]];
    
    NSLog(@"movie name is %@", self.movies[indexPath.row][@"title"]);
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeRequest:NO];
    self.dvdTableView.dataSource = self;
    self.dvdTableView.delegate = self;
    self.dvdTableView.rowHeight = 128;
    
    [self.dvdTableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [self.dvdTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.dvdTableView;
    [tableViewController setRefreshControl:refreshControl];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)refreshTable :(UIRefreshControl *) refreshControl {
    [self makeRequest:YES];
    [refreshControl endRefreshing];
}

- (void) makeRequest : (Boolean)isPartial {
    NSLog(@"Making call for partial %d", isPartial);
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=kjh6zyazfeaxvmjt5kq7d64j"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = responseDictionary[@"movies"];
        //NSArray *dummymovies = [[NSArray alloc]initWithObjects:@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",@"xyz",nil];
        //self.movies = [self.movies arrayByAddingObjectsFromArray:dummymovies];
        [self.dvdTableView reloadData];
        //NSLog(@"Data is %@", responseDictionary[@"movies"]);
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailsViewController *mdvc = [[MovieDetailsViewController alloc] init];
    
    mdvc.movieData = self.movies[indexPath.row];
    
    [self.navigationController pushViewController:mdvc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
