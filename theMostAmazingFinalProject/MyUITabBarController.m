//
//  MyUITabBarController.m
//  SecondWeekendAssignment
//
//  Created by Admin on 5/10/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "MyUITabBarController.h"
#import "AppDelegate.h"

@interface MyUITabBarController ()

@end

@implementation MyUITabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //create a custom view for the tab bar
    CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 48);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[UIColor lightGrayColor]];
    [v setAlpha:0.5];
    [[self tabBar] addSubview:v];
    
    //set the tab bar title appearance for normal state
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    //set the tab bar title appearance for selected state
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end