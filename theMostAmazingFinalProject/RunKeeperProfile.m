//
//  RunKeeperProfile.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/31/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RunKeeperProfile.h"

@implementation RunKeeperProfile

-(id)initWithJSONDict:(NSDictionary *)jsonDict
{
    self = [super init];
    
    if (self)
    {
        self.strGender = [jsonDict objectForKey:@"gender"];
        self.strName = [jsonDict objectForKey:@"name"];
        self.strLocation = [jsonDict objectForKey:@"location"];
        self.strNormalPicture = [jsonDict objectForKey:@"normal_picture"];
        self.strBirthday = [jsonDict objectForKey:@"birthday"];
        self.strProfileURL = [jsonDict objectForKey:@"profile"];
        self.strSmallPicture = [jsonDict objectForKey:@"small_picture"];
    }
    
    return self;
}

@end
