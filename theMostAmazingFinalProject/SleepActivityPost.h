//
//  SleepActivityPost.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SleepActivityPost : NSObject

@property(nonatomic, strong) NSString * strTimestamp;
@property(nonatomic, strong) NSString * strTotalSleep;
@property(nonatomic, strong) NSString * strDeep;
@property(nonatomic, strong) NSString * strREM;
@property(nonatomic, strong) NSString * strLight;
@property(nonatomic, strong) NSString * strAwake;
@property(nonatomic, strong) NSString * strTimesWoken;

-(id)initWithDefault;

@end
