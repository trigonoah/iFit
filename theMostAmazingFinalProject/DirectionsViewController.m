//
//  DirectionsViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "DirectionsViewController.h"
#import "BackgroundViewHelper.h"

@interface DirectionsViewController ()
@property (strong, nonatomic) IBOutlet UITextView *txtDirections;

@end

@implementation DirectionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtDirections.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];

    self.txtDirections.text = self.currentRecipe.strRecipeInstructions;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finished)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

-(void)finished
{
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
