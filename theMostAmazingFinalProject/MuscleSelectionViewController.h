//
//  MuscleSelectionViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MuscleSelectionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *muscleTableView;
    NSMutableArray *muscles;
}

@end
