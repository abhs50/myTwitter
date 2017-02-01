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
}


- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    [self displayTweet];
}

-(void) displayTweet {
   
    Tweet *tweet = self.tweet;
    self.nameLabel.text = tweet.user.name;
    self.contentLabel.text = tweet.text;
    self.handleLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    NSURL *url = [NSURL URLWithString:tweet.user.profileImageUrl];
    [self.profileImageView setImageWithURL:url];
    
    //format date
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
    formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    formatter.maximumUnitCount = 1;
    NSString *elapsed = [formatter stringFromDate:tweet.createdAt toDate:[NSDate date]];
    
    self.timestampLabel.text = elapsed;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
