//
//  ExerciseDetailViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseDetailViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
    UILabel *nameLabel;
    UILabel *descriptionLabel;
    NSDictionary *exerciseDetail;
}

@property NSDictionary *exerciseDic;

@end
