//
//  IngredientsTableViewController.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface IngredientsTableViewController : UITableViewController

@property (nonatomic, strong) Recipe *currentRecipe;

-(void)loadIngredients;

@end
