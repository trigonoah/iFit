//
//  KeychainHelper.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface KeychainHelper : NSObject

+(void)storeTheToken:(NSString *)token;
+(NSString *)getToken;

@end
