//
//  AppDelegate.m
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import "AppDelegate.h"
#import "TweetListViewController.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "NavigationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[NavigationManager shared] rootViewController];
    [self.window makeKeyAndVisible];
    
    //LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    //self.window.rootViewController = vc;
    //[self.window makeKeyAndVisible];
    /*
    // Add to Array
    NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    // Create Home Feed
    TweetListViewController *viewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    viewController.tabBarItem.title = @"Home Feed";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [localViewControllersArray addObject:navController];

    
    // Create Login
    LoginViewController *loginViewController = [[ LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [localViewControllersArray addObject:loginViewController];

    
    // Create Tab Bar
    UITabBarController *tabBars = [[UITabBarController alloc] init];
    tabBars.viewControllers = localViewControllersArray;
    tabBars.view.autoresizingMask=(UIViewAutoresizingFlexibleHeight);
    
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:frame];
    
    // Root Screen
    //self.window.rootViewController = self.navController;
    //self.window.rootViewController = loginViewController;
    self.window.rootViewController = tabBars;
    [self.window makeKeyAndVisible];*/
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    [[TwitterClient sharedInstance] openURL:url];
    return YES;
}


@end
