//
//  TwitterClient.h
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import <BDBOAuth1RequestOperationManager.h>
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager {
    
}
+(TwitterClient *) sharedInstance;

-(void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion;
-(void) openURL:(NSURL *) url;
-(void) getHomeTimeLine:(void (^)(NSArray *tweets, NSError *error)) completion;
-(void) pushRetweet:(NSDictionary *)requestParams;
-(void) pushFavorite:(NSDictionary *)requestParams;

@end
