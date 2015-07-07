//
//  AddExercisesViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddExercisesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *allExercises;
}

@property NSArray *exercisesArr;
@property NSDictionary *workout;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@end
