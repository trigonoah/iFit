//
//  SleepActivity.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "SleepActivity.h"

@implementation SleepActivity

-(id)initWithJSONODict:(NSDictionary *)jsonDict
{
    self = [super init];
    
    if (self)
    {
        self.strSource = [jsonDict objectForKey:@"source"];
        self.strTotalSleep = [[jsonDict objectForKey:@"total_sleep"] stringValue];
        self.strUserID = [[jsonDict objectForKey:@"userID"] stringValue];
        self.strURI = [jsonDict objectForKey:@"uri"];
        self.strTimestamp = [jsonDict objectForKey:@"timestamp"];
        self.strDeep = [[jsonDict objectForKey:@"deep"] stringValue];
        self.strREM = [[jsonDict objectForKey:@"rem"] stringValue];
        self.strLight = [[jsonDict objectForKey:@"light"] stringValue];
        self.strAwake = [[jsonDict objectForKey:@"awake"] stringValue];
        self.strTimesWoken = [[jsonDict objectForKey:@"times_woken"] stringValue];
    }
    
    return self;
}

@end
