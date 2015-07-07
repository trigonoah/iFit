//
//  FitnessActivityPost.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/31/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "FitnessActivityPost.h"

@implementation FitnessActivityPost

-(id)initDefault
{
    self = [super init];
    
    if (self)
    {
        
        self.strType = @"Running";
        self.strEquipment = @"None";
        
        //set date/time for activity to current date/time
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy hh:mm:ss"];//Wed, Dec 14 2011 1:50 PM
        NSString *str_date = [dateFormat stringFromDate:[NSDate date]];
        self.strStartTime = [str_date copy];
        
        self.strNotes = @"This is just a test";
        self.strTotalDistance = @"130";
        self.strDuration = @"50";
        self.strTotalCalories = @"150";
    }
    
    return self;
}

@end
