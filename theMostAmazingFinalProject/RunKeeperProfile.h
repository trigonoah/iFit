//
//  RunKeeperProfile.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/31/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunKeeperProfile : NSObject

@property(nonatomic, strong) NSString * strGender;
@property(nonatomic, strong) NSString * strName;
@property(nonatomic, strong) NSString * strLocation;
@property(nonatomic, strong) NSString * strNormalPicture;
@property(nonatomic, strong) NSString * strBirthday;
@property(nonatomic, strong) NSString * strProfileURL;
@property(nonatomic, strong) NSString * strSmallPicture;

-(id)initWithJSONDict:(NSDictionary *)jsonDict;


@end
