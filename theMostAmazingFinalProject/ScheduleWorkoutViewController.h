//
//  ScheduleWorkoutViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutManagerDataSource.h"

@interface ScheduleWorkoutViewController : UIViewController <WorkoutManagerDataSourceDelegate, UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UIActivityIndicatorView *activityView;
    __weak IBOutlet UIButton *addScheduleButton;
    __weak IBOutlet UIButton *addWorkoutButton;
    __weak IBOutlet UIButton *addExerciseButton;
    NSMutableArray *schedulesArr;
    NSMutableArray *workoutsArr;
    NSMutableArray *scheduleStepsArr;
    NSMutableArray *daysArr;
    NSMutableArray *exercisesArr;
    NSMutableArray *workoutsArrFiltered;
    NSMutableArray *exercisesArrFiltered;
}

@end
