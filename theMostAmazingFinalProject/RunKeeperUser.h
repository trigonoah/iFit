//
//  RunKeeperUser.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/31/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunKeeperUser : NSObject

@property(nonatomic, strong) NSString * strBackgroundActivities;
@property(nonatomic, strong) NSString * strGeneralMeasurements;
@property(nonatomic, strong) NSString * strProfile;
@property(nonatomic, strong) NSString * strStrengthTrainingActivities;
@property(nonatomic, strong) NSString * strUserID;
@property(nonatomic, strong) NSString * strNutrition;
@property(nonatomic, strong) NSString * strSettings;
@property(nonatomic, strong) NSString * strWeight;
@property(nonatomic, strong) NSString * strTeam;
@property(nonatomic, strong) NSString * strChangeLog;
@property(nonatomic, strong) NSString * strDiabetes;
@property(nonatomic, strong) NSString * strFitnessActivities;
@property(nonatomic, strong) NSString * strSleep;
@property(nonatomic, strong) NSString * strRecords;

-(id)initWithJSONDict:(NSDictionary *)jsonDict;
@end
