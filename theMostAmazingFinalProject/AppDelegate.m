//
//  AppDelegate.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //create the view controller for the first tab
    self.firstViewController = [[ProfileViewController alloc] initWithNibName:nil bundle:NULL];
    self.secondViewController = [[WorkoutViewController alloc] initWithNibName:nil bundle:NULL];
    self.thirdViewController = [[CookingViewController alloc] initWithNibName:nil bundle:NULL];
    self.fourthViewController = [[ActivityViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *firstTAB = [[UINavigationController alloc] initWithRootViewController:self.firstViewController];
    
    UINavigationController *secondTAB = [[UINavigationController alloc] initWithRootViewController:self.secondViewController];
    
    UINavigationController *thirdTAB = [[UINavigationController alloc] initWithRootViewController:self.thirdViewController];
    
    UINavigationController *fourthTAB = [[UINavigationController alloc] initWithRootViewController:self.fourthViewController];
    
    
    //create an array of all view controllers that will represent the tab at the bottom
    NSArray *myViewControllers = [[NSArray alloc] initWithObjects:
                                  firstTAB,
                                  secondTAB,
                                  thirdTAB,
                                  fourthTAB,
                                  nil];
    
    self.window.rootViewController = self.firstViewController;
    
    //initialize the tab bar controller
    self.tabBarController = [[MyUITabBarController alloc] init];
    
    //set the view controllers for the tab bar controller
    [self.tabBarController setViewControllers:myViewControllers];
    
    //add the tab bar controllers view to the window
    [self.window addSubview:self.tabBarController.view];
    
    //make the tab bar controller translucent
//    [self.tabBarController.tabBar setBackgroundColor:[UIColor clearColor]];
    
    //set the window background color and make it visible
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
