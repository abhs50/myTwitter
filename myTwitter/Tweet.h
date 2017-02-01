//
//  Tweet.h
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;

-(id) initWithDictionary:(NSDictionary *) dictionary;

+ (NSArray *) tweetsWithArray:(NSArray *)array;


// Helper function


@end
