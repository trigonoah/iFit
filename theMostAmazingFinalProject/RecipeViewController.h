//
//  RecipeViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imgRecipeImage;
@property (strong, nonatomic) IBOutlet UILabel *lblMainIngredient;
@property (strong, nonatomic) IBOutlet UILabel *lblCuisine;
@property (strong, nonatomic) IBOutlet UILabel *lblCategory;
@property (strong, nonatomic) IBOutlet UILabel *lblPrepTime;
@property (strong, nonatomic) IBOutlet UILabel *lblYield;
@property (strong, nonatomic) IBOutlet UILabel *lblRating;
@property (strong, nonatomic) IBOutlet UIButton *btnIngredients;
@property (strong, nonatomic) IBOutlet UIButton *btnDirections;
@property (strong, nonatomic) IBOutlet UIButton *btnWebPage;
@property (strong, nonatomic) Recipe * recipeToDisplay;


@end
