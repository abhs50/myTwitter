//
//  ProfilePageViewController.m
//  myTwitter
//
//  Created by Abhinav Wagle on 2/2/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "ProfilePageViewController.h"
#import "TwitterClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProfilePageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation ProfilePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Profile View Loaded");
    [[TwitterClient sharedInstance] getProfileView:^(User *user, NSError *error) {
        if(user !=nil) {
            NSLog(@"Screen Name %@", user.screenName);
            self.nameLabel.text = user.name;
            NSURL *url = [NSURL URLWithString:user.profileImageUrl];
            [self.profileImageView setImageWithURL:url];
            self.followingCount.text = [NSString stringWithFormat:@"%i",user.followingCount.intValue];
            self.followersCount.text = [NSString stringWithFormat:@"%i",user.followersCount.intValue];
            
        } else {
            NSLog(@"User not found %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
