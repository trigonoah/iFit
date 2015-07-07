//
//  SearchResultTableViewCell.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgRecipeImage120;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblCategory;
@property (strong, nonatomic) IBOutlet UILabel *lblCuisine;
@property (strong, nonatomic) IBOutlet UILabel *lblYield;
@property (strong, nonatomic) IBOutlet UILabel *lblStarRating;

@end
