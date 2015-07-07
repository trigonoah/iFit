//
//  FitnessActivity.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitnessActivity : NSObject

@property(nonatomic, strong) NSString * strTotalDistance;
@property(nonatomic, strong) NSString * strTrackingMode;
@property(nonatomic, strong) NSString * strSource;
@property(nonatomic, strong) NSString * strStartTime;
@property(nonatomic, strong) NSString * strDuration;
@property(nonatomic, strong) NSString * strEntryMode;
@property(nonatomic, strong) NSString * strType;
@property(nonatomic, strong) NSString * strTotalCalories;
@property(nonatomic, strong) NSString * strActivityID;

-(id)initWithJSONDict:(NSDictionary *)jsonDict;
@end
