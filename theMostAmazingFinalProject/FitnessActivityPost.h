//
//  FitnessActivityPost.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/31/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitnessActivityPost : NSObject

@property(nonatomic, strong) NSString * strType;
@property(nonatomic, strong) NSString * strEquipment;
@property(nonatomic, strong) NSString * strStartTime;       //"Sun, 31 May 2015 14:31:00" format
@property(nonatomic, strong) NSString * strNotes;
@property(nonatomic, strong) NSString * strTotalDistance;   //meters
@property(nonatomic, strong) NSString * strDuration;        //seconds
@property(nonatomic, strong) NSString * strTotalCalories;

-(id)initDefault;

@end
