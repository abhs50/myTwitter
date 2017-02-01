//
//  LoginViewController.m
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetListViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if(user !=nil) {
            // Present Tweets view
            NSLog(@"Scree Name %@", user.screenName);
            TweetListViewController *viewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
            [self presentViewController:viewController animated:NO completion:nil];
        } else {
            NSLog(@"User not found %@", error);
        }
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
