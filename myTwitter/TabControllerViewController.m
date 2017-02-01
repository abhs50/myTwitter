//
//  TabControllerViewController.m
//  myTwitter
//
//  Created by Abhinav Wagle on 1/31/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "TabControllerViewController.h"
#import "TweetListViewController.h"

@interface TabControllerViewController ()

@end

@implementation TabControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TweetListViewController *tweetListViewController = (TweetListViewController *)[[self viewControllers] objectAtIndex:0];
    [self refreshTitleText];
    
}

- (void)refreshTitleText {
    
    [[self.tabBar.items objectAtIndex:0] setTitle:@"Home Feed"];
    [[self.tabBar.items objectAtIndex:1] setTitle:@"Timeline"];
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
