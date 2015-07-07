//
//  BackgroundViewHelper.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BackgroundViewHelper : UIView{
    NSTimer *timer;
    UIImageView *animatedImageView;
    NSMutableArray *imageArray;
    NSInteger index;
    UIView *overlay;
}

@property UIView *assignedView;


+(BackgroundViewHelper *)getSharedInstance;
-(void)start;
-(void)stop;

@end
