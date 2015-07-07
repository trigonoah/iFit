//
//  ActivityViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ActivityViewController.h"
#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"
#import "OBShapedButton.h"
#import "ActivitySelectViewController.h"
#import "ViewProgressViewController.h"

@interface ActivityViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblPostActivity;
@property (strong, nonatomic) IBOutlet UILabel *lblViewProgress;
@property (strong, nonatomic) IBOutlet OBShapedButton *btnPostActivity;
@property (strong, nonatomic) IBOutlet OBShapedButton *btnViewProgress;
@property (assign, nonatomic) CGRect lblPostActivityOriginalFrame;
@property (assign, nonatomic) CGRect lblViewProgressOriginalFrame;

@end

@implementation ActivityViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Activity";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lblPostActivity.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.lblViewProgress.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.btnPostActivity.alpha = 0.0;
    self.btnViewProgress.alpha = 0.0;
    
    self.lblPostActivityOriginalFrame = CGRectZero;
    self.lblViewProgressOriginalFrame = CGRectZero;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

-(void)viewDidAppear:(BOOL)animated
{
    if (CGRectEqualToRect(_lblPostActivityOriginalFrame, CGRectZero)) {
        _lblPostActivityOriginalFrame = _lblPostActivity.frame;
    }
    if (CGRectEqualToRect(_lblViewProgressOriginalFrame, CGRectZero)) {
        _lblViewProgressOriginalFrame = _lblViewProgress.frame;
    }
    
    _lblPostActivity.frame = CGRectMake(_lblPostActivity.frame.origin.x, _lblPostActivity.frame.origin.y - 500, _lblPostActivity.frame.size.width, _lblPostActivity.frame.size.height);
    _lblViewProgress.frame = CGRectMake(_lblViewProgress.frame.origin.x, _lblViewProgress.frame.origin.y + 500, _lblViewProgress.frame.size.width, _lblViewProgress.frame.size.height);;
    
    [AnimationHelper transitionView:_lblPostActivity toRect:_lblPostActivityOriginalFrame WithSpringWithDamping:0.6 andVelocity:1.0 andTransitionTime:0.5 andWaitTime:0.0];
    [AnimationHelper transitionView:_lblViewProgress toRect:_lblViewProgressOriginalFrame WithSpringWithDamping:0.6 andVelocity:1.0 andTransitionTime:0.5 andWaitTime:0.0];
    
    [AnimationHelper fadeInTransparent:_btnPostActivity withAlpha:1.0 withDuration:0.75 andWait:0];
    [AnimationHelper fadeInTransparent:_btnViewProgress withAlpha:1.0 withDuration:0.75 andWait:0];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.btnPostActivity.alpha = 0.0;
    self.btnViewProgress.alpha = 0.0;
}

- (IBAction)btnPostActivityPressed:(id)sender
{
    //Push the new view
    ActivitySelectViewController *asvc = [[ActivitySelectViewController alloc] initWithNibName:@"ActivitySelectViewController" bundle:nil];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:asvc animated:YES];
    
}

- (IBAction)btnViewProgressPressed:(id)sender
{
    //Push the new view
    ViewProgressViewController *vpvc = [[ViewProgressViewController alloc] initWithNibName:@"ViewProgressViewController" bundle:nil];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:vpvc animated:YES];
}

@end
