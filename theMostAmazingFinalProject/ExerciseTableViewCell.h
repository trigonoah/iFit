//
//  ExerciseTableViewCell.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseTableViewCell : UITableViewCell{
    IBOutlet UILabel *exerciseName;
    IBOutlet UIImageView *exerciseImage;
}

-(void)setupCellWithData:(NSDictionary *)exerciseDic;

@end
