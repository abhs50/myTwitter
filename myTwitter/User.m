//
//  User.m
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "User.h"

@implementation User

-(id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if(self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagLine = dictionary[@"description"];
        self.followersCount = dictionary[@"followers_count"];
        self.followingCount = dictionary[@"friends_count"];
    }
    return self;
}

@end
