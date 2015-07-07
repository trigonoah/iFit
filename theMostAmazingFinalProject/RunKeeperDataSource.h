//
//  RunKeeperDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceHandler.h"
#import "FitnessActivity.h"
#import "RunKeeperUser.h"
#import "RunKeeperProfile.h"
#import "FitnessActivityPost.h"
#import "SleepActivity.h"
#import "SleepActivityPost.h"

@protocol RunKeeperDataSourceDelegate <NSObject>

@optional
-(void)tokenObtained;
-(void)returnRunKeeperProfile:(RunKeeperProfile *)rkProfile;
-(void)returnFitnessActivities:(NSArray*)arrFitnessActivities;

@end

@interface RunKeeperDataSource : NSObject <WebServiceHandlerDelegate> {
    int currentOperation;
    WebServiceHandler *webHandler;
}

@property (weak, nonatomic) id <RunKeeperDataSourceDelegate> delegate;

-(void)getToken:(NSString *)CODE;
-(void)getFitnessActivities;
-(void)getUser;
-(void)getProfile;
-(void)postFitnessActivity:(FitnessActivityPost *)aFitnessActivityPost;
-(void)getSleepFeed;
-(void)getSleepActivity:(NSString *)sleepID;
-(void)postSleepActivity:(SleepActivityPost *)sleepActivity;

@end
