//
//  WebViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UIWebView *wvWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.wvWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.currentRecipe.strRecipeWebURL]]];
}

- (IBAction)btnBackPressed:(id)sender
{
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
