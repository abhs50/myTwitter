//
//  TweetListViewController.h
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 Array containing the tweets to be displayed on timeline
 */
@property (nonatomic) NSArray *tweets;

@end
