//
//  TweetTableViewCell.m
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#define TIMESTAMP_LABEL_HOUR_TEXT LocalizedString(@"%@h")
#define TIMESTAMP_LABEL_MINUTE_TEXT LocalizedString(@"%@m")
#define TIMESTAMP_LABEL_SECOND_TEXT LocalizedString(@"%@s")


@interface  TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;





@end


@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timestampLabel.text = @"4h";
}


- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    [self displayTweet];
}

-(void) displayTweet {
   
    Tweet *tweet = self.tweet;
    self.nameLabel.text = tweet.user.name;
    self.contentLabel.text = tweet.text;
    self.handleLabel.text = tweet.user.screenName;
    NSURL *url = [NSURL URLWithString:tweet.user.profileImageUrl];
    [self.profileImageView setImageWithURL:url];
    //self.timestampLabel = tweet.createdAt;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
