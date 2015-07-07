//
//  SearchResultTableViewCell.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "SearchResultTableViewCell.h"

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.lblTitle.backgroundColor = [UIColor colorWithWhite:.5 alpha:0.5];
    self.lblCategory.backgroundColor = [UIColor colorWithWhite:.5 alpha:0.5];
    self.lblCuisine.backgroundColor = [UIColor colorWithWhite:.5 alpha:0.5];
    self.lblStarRating.backgroundColor = [UIColor colorWithWhite:.5 alpha:0.5];
    self.lblYield.backgroundColor = [UIColor colorWithWhite:.5 alpha:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
