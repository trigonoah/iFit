//
//  WorkoutManagerDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceHandler.h"

@protocol WorkoutManagerDataSourceDelegate <NSObject>

@optional

-(void)catalogsUpdated;
-(void)schedulesSyncronized:(NSDictionary *)schedules;

@end

@interface WorkoutManagerDataSource : NSObject <WebServiceHandlerDelegate> {
    int currentOperation;
    int attempts;
    WebServiceHandler *webHandler;
    NSDictionary *authenticationCredentials;
    NSMutableArray *schedules;
    NSMutableArray *workouts;
    NSMutableArray *scheduleSteps;
    NSMutableArray *days;
    NSMutableArray *exercises;
}

@property (nonatomic, weak) id <WorkoutManagerDataSourceDelegate> delegate;

-(void)getCatalogs;
-(void)getSchedules;

-(void)postAExerciseForWorkout:(NSDictionary *)set;
-(void)postASchedule:(NSDictionary *)set;

@end
