//
//  AppDelegate.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUITabBarController.h"
#import "ProfileViewController.h"
#import "WorkoutViewController.h"
#import "LoginViewController.h"
#import "CookingViewController.h"
#import "ActivityViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyUITabBarController *tabBarController;

@property (strong, nonatomic) ProfileViewController *firstViewController;
@property (strong, nonatomic) WorkoutViewController *secondViewController;
@property (strong, nonatomic) CookingViewController *thirdViewController;
@property (strong, nonatomic) ActivityViewController *fourthViewController;


@end

