//
//  MusclesTableViewCell.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "MusclesTableViewCell.h"

@implementation MusclesTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupCellWithData:(NSDictionary *)muscle{
    muscleName.text = [muscle objectForKey:@"name"];
}

@end
