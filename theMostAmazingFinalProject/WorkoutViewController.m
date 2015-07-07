//
//  WorkoutViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WorkoutViewController.h"
#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"
#import "MuscleSelectionViewController.h"
#import "ScheduleWorkoutViewController.h"

@interface WorkoutViewController () <WorkoutManagerDataSourceDelegate>

@end

@implementation WorkoutViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Workout";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.wgerDataSource = [WorkoutManagerDataSource new];
    self.wgerDataSource.delegate = self;
    [activityView startAnimating];
    [scheduleButton setAlpha:0.0];
    [exerciseButton setAlpha:0.0];
    scheduleButtonOriginalFrame = CGRectZero;
    exerciseButtonOriginalFrame = CGRectZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

-(void)viewDidAppear:(BOOL)animated{
    if (CGRectEqualToRect(scheduleButtonOriginalFrame, CGRectZero)) {
        scheduleButtonOriginalFrame = scheduleButton.frame;
    }
    if (CGRectEqualToRect(exerciseButtonOriginalFrame, CGRectZero)) {
        exerciseButtonOriginalFrame = exerciseButton.frame;
    }
    [AnimationHelper changeViewSize:scheduleButton withFrame:CGRectMake(scheduleButtonOriginalFrame.origin.x-500, scheduleButtonOriginalFrame.origin.y, scheduleButtonOriginalFrame.size.width, scheduleButtonOriginalFrame.size.height) withDuration:0.0 andWait:0.0];
    [AnimationHelper changeViewSize:exerciseButton withFrame:CGRectMake(exerciseButtonOriginalFrame.origin.x+500, exerciseButtonOriginalFrame.origin.y, exerciseButtonOriginalFrame.size.width, exerciseButtonOriginalFrame.size.height) withDuration:0.0 andWait:0.0];
    [self.wgerDataSource getCatalogs];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [scheduleButton setAlpha:0.0];
    [exerciseButton setAlpha:0.0];
}

#pragma mark - WorkoutManagerDataSourceDelegate methods

-(void)catalogsUpdated{
    
    [activityView stopAnimating];
    [self performSelector:@selector(animateAfter) withObject:nil afterDelay:0.5];
}

#pragma mark - UI methods

-(void)animateAfter{
    [AnimationHelper fadeIn:scheduleButton withDuration:0.4 andWait:0.0];
    [AnimationHelper fadeIn:exerciseButton withDuration:0.4 andWait:0.0];
    [AnimationHelper transitionView:scheduleButton toRect:scheduleButtonOriginalFrame WithSpringWithDamping:0.6 andVelocity:1.0 andTransitionTime:0.8 andWaitTime:0.0];
    [AnimationHelper transitionView:exerciseButton toRect:exerciseButtonOriginalFrame WithSpringWithDamping:0.6 andVelocity:1.0 andTransitionTime:0.8 andWaitTime:0.0];
}

#pragma mark - User interaction methods

- (IBAction)goToScheduleView:(id)sender {
    ScheduleWorkoutViewController *scheduleVC = [[ScheduleWorkoutViewController alloc] init];
    [self.navigationController pushViewController:scheduleVC animated:YES];
}

- (IBAction)goToMuscleSelection:(id)sender {
    MuscleSelectionViewController *muscleSelection = [[MuscleSelectionViewController alloc] init];
    [self.navigationController pushViewController:muscleSelection animated:YES];
}


@end
