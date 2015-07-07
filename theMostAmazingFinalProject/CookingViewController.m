//
//  CookingViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "CookingViewController.h"
#import "RecipeSearchViewController.h"
#import "BackgroundViewHelper.h"
#import "FavoritesViewController.h"
#import "AnimationHelper.h"

enum OPERATIONS {
    SEARCH_LOCAL = 1,
    SEARCH_ONLINE = 2,
};

@interface CookingViewController () <UIAlertViewDelegate>

@end

@implementation CookingViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cook";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

-(void)viewDidAppear:(BOOL)animated
{
    [AnimationHelper popIn:self.btnSearchForRecipes withDuration:1.0 andWait:0 andScaleFactor:.25];
    [AnimationHelper popIn:self.btnViewSavedRecipes withDuration:1.0 andWait:0 andScaleFactor:.25];

    [AnimationHelper popIn:self.btnSearchForRecipes withDuration:2.0 andWait:0 andScaleFactor:1];
    [AnimationHelper popIn:self.btnViewSavedRecipes withDuration:2.0 andWait:0 andScaleFactor:1];
}

#pragma mark - Button methods
- (IBAction)btnSearchForRecipesPressed:(UIButton *)sender
{
    //Launch a UIAlertview prompting the user for where to search
    UIAlertView *alertRecipeSearchDomain = [[UIAlertView alloc] initWithTitle:@"Recipe Search"
message:@"Please select where I should search" delegate:self cancelButtonTitle:@"Local" otherButtonTitles:@"BigOven.com", nil];
    [alertRecipeSearchDomain show];
}


-(IBAction)btnViewSavedRecipesPressed:(UIButton *)sender
{
    FavoritesViewController *fvc = [[FavoritesViewController alloc] initWithNibName:@"FavoritesViewController" bundle:nil];
    
    CATransition* transition = [CATransition animation];
    transition.duration = .5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:fvc animated:YES];
    });
}

#pragma mark - UIAlertView delegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"The user selected %@", [alertView buttonTitleAtIndex:buttonIndex]);
    
    RecipeSearchViewController *recipeSVC = [[RecipeSearchViewController alloc] initWithNibName:@"RecipeSearchViewController" bundle:nil];
    
    if (buttonIndex == 0)
    {
        recipeSVC.searchParameter = SEARCH_LOCAL;
    }
    else if (buttonIndex == 1)
    {
        recipeSVC.searchParameter = SEARCH_ONLINE;
    }
    
    //Set animations
    CATransition* transition = [CATransition animation];
    transition.duration = .5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    //Present the next view controller
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:recipeSVC animated:YES];
}

@end
