//
//  FitnessActivity.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "FitnessActivity.h"

@implementation FitnessActivity

-(id)initWithJSONDict:(NSDictionary *)jsonDict
{
    self = [super init];
    
    if (self)
    {
        self.strTotalDistance = [[jsonDict objectForKey:@"total_distance"] stringValue];
        self.strTrackingMode = [jsonDict objectForKey:@"tracking_mode"];
        self.strSource = [jsonDict objectForKey:@"source"];
        self.strStartTime = [jsonDict objectForKey:@"start_time"];
        self.strDuration = [[jsonDict objectForKey:@"duration"] stringValue];
        self.strEntryMode = [jsonDict objectForKey:@"entry_mode"];
        self.strType = [jsonDict objectForKey:@"type"];
        self.strTotalCalories = [jsonDict objectForKey:@"total_calories"];
        self.strActivityID = [jsonDict objectForKey:@"uri"];
        
        //Parse the activity ID
        self.strActivityID = [self.strActivityID stringByReplacingOccurrencesOfString:@"/fitnessActivities/" withString:@""];
    }
    
    return self;
}

@end
