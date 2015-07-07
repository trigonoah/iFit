//
//  WorkoutViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutManagerDataSource.h"
#import "OBShapedButton.h"

@interface WorkoutViewController : UIViewController{
    IBOutlet UIActivityIndicatorView *activityView;
    IBOutlet OBShapedButton *scheduleButton;
    IBOutlet OBShapedButton *exerciseButton;
    CGRect scheduleButtonOriginalFrame;
    CGRect exerciseButtonOriginalFrame;
}

@property(strong,nonatomic) WorkoutManagerDataSource *wgerDataSource;

@end
