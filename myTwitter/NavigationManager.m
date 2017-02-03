//
//  NavigationManager.m
//  myTwitter
//
//  Created by Abhinav Wagle on 2/2/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "NavigationManager.h"
#import "TweetListViewController.h"
#import "ProfilePageViewController.h"
#import "LoginViewController.h"

@interface NavigationManager ()

@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation NavigationManager

+(instancetype)shared
{
    static NavigationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NavigationManager alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoggedIn = NO;
        //UIViewController *root = self.isLoggedIn ? [self loggedInVC] : nil;
        UIViewController *root = [self loggedInVC];
        
        self.navigationController = [[UINavigationController alloc] init];
        self.navigationController.viewControllers = @[root];
        [self.navigationController setNavigationBarHidden:YES];
    }
    return self;
}


- (UIViewController *)rootViewController
{
    return self.navigationController;
}


- (UIViewController *)loggedInVC
{
    // Create root VC for the tab's navigation controller
    TweetListViewController *viewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    ProfilePageViewController *profileViewController = [[ProfilePageViewController alloc] initWithNibName:@"ProfilePageViewController" bundle:nil];
    
    
    //viewController.title = @"Logged In";
    
    // create tab item
    UIImage *homeImg = [UIImage imageNamed:@"home.png"];
    UIImage *profileImg = [UIImage imageNamed:@"profile.png"];
    
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
    
    UITabBar *myTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UITabBarItem *itemHome = [[UITabBarItem alloc] initWithTitle:@"Home" image:homeImg tag:0];
    UITabBarItem *itemProfile = [[UITabBarItem alloc] initWithTitle:@"Me" image:profileImg tag:0];
    [tabBarItems addObject:itemHome];
    [tabBarItems addObject:itemProfile];
    myTabBar.items = tabBarItems;
    
    viewController.tabBarItem = itemHome;
    profileViewController.tabBarItem = itemProfile;
    
    
    // Create navigation controller - Top Section
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIColor *color = [UIColor colorWithRed:0/255.0 green:172/255.0 blue:237/255.0 alpha:1.0];
    [navController.navigationBar setBarTintColor:color];
    [navController addChildViewController:viewController];
    
    // create tab bar view controller ( Bottom switch)
    UITabBarController *tabController = [[UITabBarController alloc] init];
    // Add navigationcontroller, profilecontroller to tab bar controller
    tabController.viewControllers = @[navController, profileViewController];
    
    return tabController;
}

/*
- (UIViewController *)loggedOutVC
{
    LoggedOutViewController *vc = [[LoggedOutViewController alloc] initWithNibName:@"LoggedOutViewController" bundle:nil];
    
    return vc;
}*/


- (void)logIn
{
    self.isLoggedIn = YES;
    
    NSArray *vcs = @[[self loggedInVC]];
    [self.navigationController setViewControllers:vcs];
}

/*
- (void)logOut
{
    self.isLoggedIn = NO;
    self.navigationController.viewControllers = @[[self loggedOutVC]];
}*/

@end
