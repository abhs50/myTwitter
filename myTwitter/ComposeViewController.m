//
//  ComposeViewController.m
//  myTwitter
//
//  Created by Abhinav Wagle on 2/2/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "ComposeViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "TwitterClient.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIButton *closeView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Compose View Controller");
    [[TwitterClient sharedInstance] getProfileView:^(User *user, NSError *error) {
        if(user !=nil) {
            NSURL *url = [NSURL URLWithString:user.profileImageUrl];
            [self.profileImageView setImageWithURL:url];
            
        } else {
            NSLog(@"User not found %@", error);
        }
    }];
    
    [self.tweetTextView setDelegate:self];
    self.tweetTextView.text = @"What's happening?";
    self.tweetTextView.textColor = [UIColor lightGrayColor];
    
}

- (IBAction)onButtonClose:(id)sender {
    
    NSLog(@"Posting Tweet canceled by the user,dismissing view");
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)postTweet:(id)sender {
    
    NSLog(@"Trying to post a message");
    NSDictionary *requestParams = @{@"status":self.tweetTextView.text};
    [[TwitterClient sharedInstance] postTweet:requestParams];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"What's happening?"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"What's happening?.";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
