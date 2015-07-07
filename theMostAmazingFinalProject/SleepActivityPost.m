//
//  SleepActivityPost.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "SleepActivityPost.h"

@implementation SleepActivityPost

-(id)initWithDefault
{
    self = [super init];
    
    if (self)
    {
        //set date/time for activity to current date/time
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy hh:mm:ss"];//Wed, Dec 14 2011 1:50 PM
        NSString *str_date = [dateFormat stringFromDate:[NSDate date]];
        self.strTimestamp = [str_date copy];

        self.strTotalSleep = [NSString stringWithFormat:@"%d", 7*60]; //minutes
        self.strDeep = [NSString stringWithFormat:@"%d", 3*60];       //minutes
        self.strREM = [NSString stringWithFormat:@"%d", 1*60];        //minutes
        self.strLight = [NSString stringWithFormat:@"%d", 2*60];      //minutes
        self.strAwake = [NSString stringWithFormat:@"%d", 1*60];      //minutes
        self.strTimesWoken = [NSString stringWithFormat:@"%d", arc4random()%5]; //number
    }
    
    return self;
}

@end
