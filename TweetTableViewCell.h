//
//  TweetTableViewCell.h
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHtConstraint;

// Tweet to be displayed in cell
@property (nonatomic) Tweet *tweet;

//@property (nonatomic, weak) id <TweetCellDelegate> delegate;

@end
