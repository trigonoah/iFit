//
//  ExerciseTableViewCell.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ExerciseTableViewCell.h"
#import "ImageHelper.h"

@implementation ExerciseTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithData:(NSDictionary *)exerciseDic{
    exerciseName.text = [exerciseDic objectForKey:@"name"];
    exerciseImage.clipsToBounds = YES;
    [exerciseImage.layer setCornerRadius:5.0];
    if ([[exerciseDic objectForKey:@"image"] isEqualToString:@""]) {
        [exerciseImage setBackgroundColor:[UIColor clearColor]];
        exerciseImage.image = nil;
    } else {
        [ImageHelper setImage:exerciseImage FromPath:[exerciseDic objectForKey:@"image"]];
        [exerciseImage setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
