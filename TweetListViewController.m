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

@interface TweetListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIRefreshControl *refreshTweetsControl;
@property (strong, nonatomic) MBProgressHUD *loadingIndicator;


-(void) getLatestTweets;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
