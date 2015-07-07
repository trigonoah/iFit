//
//  RunKeeperUser.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/31/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RunKeeperUser.h"

@implementation RunKeeperUser

-(id)initWithJSONDict:(NSDictionary *)jsonDict
{
    self = [super init];
    
    if (self)
    {
        self.strBackgroundActivities = [jsonDict objectForKey:@"background_activities"];
        self.strGeneralMeasurements = [jsonDict objectForKey:@"general_measurements"];
        self.strProfile = [jsonDict objectForKey:@"profile"];
        self.strStrengthTrainingActivities = [jsonDict objectForKey:@"strength_training_activities"];
        self.strUserID = [[jsonDict objectForKey:@"userID"] stringValue];
        self.strNutrition = [jsonDict objectForKey:@"nutrition"];
        self.strSettings = [jsonDict objectForKey:@"settings"];
        self.strWeight = [jsonDict objectForKey:@"weight"];
        self.strTeam = [jsonDict objectForKey:@"team"];
        self.strChangeLog = [jsonDict objectForKey:@"change_log"];
        self.strDiabetes = [jsonDict objectForKey:@"diabetes"];
        self.strFitnessActivities = [jsonDict objectForKey:@"fitness_activities"];
        self.strSleep = [jsonDict objectForKey:@"sleep"];
        self.strRecords = [jsonDict objectForKey:@"records"];
    }

    return self;
}

@end
