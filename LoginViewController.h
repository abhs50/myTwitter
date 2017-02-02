//
//  LoginViewController.h
//  myTwitter
//
//  Created by Abhinav Wagle on 1/30/17.
//  Copyright © 2017 Abhinav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    UINavigationController *refNavigationController;
}

- (void) setReferencedNavigation:(UINavigationController *)refNavCon;

@end
