//
//  DetailTweetViewController.m
//  myTwitter
//
//  Created by Abhinav Wagle on 2/1/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "DetailTweetViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "TweetViewController.h"
#import "TwitterClient.h"

@interface DetailTweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabelCount;
@property (weak, nonatomic) IBOutlet UILabel *favLabelCount;

//@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
//@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
//@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

@end

@implementation DetailTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Detail View is called");
    self.nameLabel.text = self.tweet.user.name;
    self.contentLabel.text = self.tweet.text;
    self.handleLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"dd/mm/yy HH:mm a"];
    NSString *newDate = [objDateFormatter stringFromDate:self.tweet.createdAt];
    self.dateLabel.text = newDate;
    self.retweetLabelCount.text = [NSString stringWithFormat:@"%i",self.tweet.retweetCount.intValue];
    self.favLabelCount.text = [NSString stringWithFormat:@"%i",self.tweet.favoriteCount.intValue];
    NSURL *url = [NSURL URLWithString:self.tweet.user.profileImageUrl];
    [self.profileImageView setImageWithURL:url];
    
    //UINavigationController *navController = (UINavigationController *)[UIApplication.sharedApplication.keyWindow rootViewController];
   // TweetViewController *tweetView = [[TweetViewController alloc] initWithNibName:@"TweetViewController" bundle:nil];
   // [navController addChildViewController:tweetView];

    
}
- (IBAction)onReplyPressed:(id)sender {

}

- (IBAction)onRetweetPressed:(id)sender {
    
    NSLog(@"onRetweetPressed");
    NSDictionary *requestParams = @{@"id":self.tweet.tweetId};
    [[TwitterClient sharedInstance] pushRetweet:requestParams];
    self.tweet.retweetCount = [NSNumber numberWithInt:[self.tweet.retweetCount intValue] + 1];

}


- (IBAction)onFavoritePressed:(id)sender {
    
    NSLog(@"onFavoritePressed");
    NSDictionary *requestParams = @{@"id":self.tweet.tweetId};
    [[TwitterClient sharedInstance] pushFavorite:requestParams];
    self.tweet.favoriteCount = [NSNumber numberWithInt:[self.tweet.favoriteCount intValue] + 1];
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
