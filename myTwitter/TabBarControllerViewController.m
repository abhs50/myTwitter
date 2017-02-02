//
//  TabBarControllerViewController.m
//  myTwitter
//
//  Created by Abhinav Wagle on 2/2/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "TabBarControllerViewController.h"
#import "TweetViewController.h"

@interface TabBarControllerViewController ()

@end

@implementation TabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TweetViewController *tweetViewController = (TweetViewController *)[[self viewControllers] objectAtIndex:0];
    //[self setText];
    
}

-(void) setText {
   
    [[self.tabBar.items objectAtIndex:0] setTitle:@"Home Feed"];
    
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
