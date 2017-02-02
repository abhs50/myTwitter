//
//  TwitterClient.m
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "TwitterClient.h"


NSString *const kTwitterConsumerKey = @"jrQe6akJqQQDMg442rKZeIY4q";
NSString *const kTwitterConsumerSecret = @"K487s2tLGz7hIUU6IEI3KogYAOkwafI90n6f21Y5DLlb1X0WGE";
NSString *const KTwitterBaseUrl = @"https://api.twitter.com";
NSString *const kTwitterHomeTimeLine = @"1.1/statuses/home_timeline.json";
NSString * const retweetApiUrl = @"1.1/statuses/retweet/%@.json";
NSString * const tweetFavoriteApiUrl = @"1.1/favorites/create.json";


@interface TwitterClient()


@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end


@implementation TwitterClient

+(TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if( instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:KTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

-(void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion {
    
    
    self.loginCompletion = completion;
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"mytwitterdemo://oauth" ] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@" Got Request Token");
        NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@",requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl options: @{} completionHandler:nil];
    } failure:^(NSError *error) {
        NSLog(@" Failed to fetch Request Token");
        self.loginCompletion(nil, error);
    }];
    
}

-(void) openURL:(NSURL *)url {
    
    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Success Got Access Token");
        [self.requestSerializer saveAccessToken:accessToken];
        // Account Verify
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"current user %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"Fail to get current user");
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Failure Getting Access Token");
        self.loginCompletion(nil, error);
    }];

}

-(void) getHomeTimeLine:(void (^)(NSArray *tweets, NSError *error)) completion {
    
    //Check my Tweets
     [[TwitterClient sharedInstance] GET:kTwitterHomeTimeLine parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         //NSLog(@"Tweets %@", responseObject);
         //NSArray *tweets = [Tweet tweetsWithArray:responseObject];
         NSArray *tweets = [Tweet tweetsWithArray:responseObject];
         //NSLog(@"My Tweets : %@ ", tweets);
         completion(tweets, nil);
     } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         NSLog(@"Fail to get current Tweets");
         completion(nil,error);
     }];
    
}


-(void) pushRetweet:(NSDictionary *)requestParams {
    
    NSString *retweetApiEndPoint = [NSString stringWithFormat:retweetApiUrl, requestParams[@"id"]];
    
    [[TwitterClient sharedInstance] POST:retweetApiEndPoint parameters:requestParams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"Pushed Retweet Successfully");
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Failed to retweet %@", error);
        
    }];
    
    
}

-(void) pushFavorite:(NSDictionary *)requestParams {
    
    [[TwitterClient sharedInstance] POST:tweetFavoriteApiUrl parameters:requestParams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"Pushed Favorite Successfully");
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Failed to retweet %@", error);
        
    }];
    
    
}



@end
