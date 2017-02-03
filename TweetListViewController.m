//
//  TweetListViewController.m
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "MBProgressHUD.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "DetailTweetViewController.h"
#import "ComposeViewController.h"
#import "NavigationManager.h"

@interface TweetListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIRefreshControl *refreshTweetsControl;
@property (strong, nonatomic) MBProgressHUD *loadingIndicator;


- (void) getLatestTweets;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *homeImg = [UIImage imageNamed:@"compose.png"];
    UIImage *signoutImg = [UIImage imageNamed:@"signout.png"];
    
    
    UIBarButtonItem *composeButton = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(createTweet:)];
    [composeButton setImage:homeImg];
    
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut:)];
    [signOutButton setImage:signoutImg];
    
    
    [self.navigationItem setRightBarButtonItem:composeButton];
    [self.navigationItem setLeftBarButtonItem:signOutButton];
    
    
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.refreshTweetsControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshTweetsControl];
    [self.refreshTweetsControl addTarget:self
                                  action:@selector(getLatestTweets)
                        forControlEvents:UIControlEventValueChanged];
    
    self.loadingIndicator = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getLatestTweets];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    cell.tweet = self.tweets[indexPath.row];
   // cell.delegate = self;
    //[cell setNeedsUpdateConstraints];
    return cell;
    
}

// Push to DetailTweetView Controller on cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"I am calling the detailViewController");
    DetailTweetViewController *detailView = [[DetailTweetViewController alloc] initWithNibName:@"DetailTweetViewController" bundle:nil];
    Tweet *tweetModel = self.tweets[indexPath.row];
    detailView.tweet = tweetModel;
    [self.navigationController pushViewController:detailView animated:YES];
}

-(void) getLatestTweets {
    
     NSLog(@"Fetching tweets");
    [[TwitterClient sharedInstance] getHomeTimeLine:^(NSArray *tweetsFromCall, NSError *error) {
            if(tweetsFromCall) {
                NSLog(@" Incoming Tweets %@", tweetsFromCall);
                self.tweets = tweetsFromCall;
                [self.tableView reloadData];
            }
        [self.loadingIndicator hideAnimated:YES];
        [self.refreshTweetsControl endRefreshing];
    }];
}
     
-(void) createTweet {

    NSLog(@"Calling Create Tweet Method");
}

// Composing a tweet Action
-(IBAction)createTweet:(UIBarButtonItem*)btn
{
    NSLog(@"Composing tweet %@", btn.title);
    ComposeViewController *composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    [self.navigationController pushViewController:composeViewController animated:YES];
    
}

// Signing out of App
-(IBAction)signOut:(UIBarButtonItem*)btn
{
    NSLog(@"Signing out %@", btn.title);
    [self.navigationController popViewControllerAnimated:YES];
    [[NavigationManager shared] logOut];
}
     

- (void) setReferencedNavigation:(UINavigationController *)refNavCon {
    refNavigationController = refNavCon;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
