//
//  ExerciseSelectionViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseSelectionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *exerciseTableView;
    NSMutableArray *exercises;
}


@property NSDictionary *muscleDic;

@end
