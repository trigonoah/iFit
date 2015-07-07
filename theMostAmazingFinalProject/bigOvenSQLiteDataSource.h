//
//  bigOvenSQLiteDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "SQLiteDataSource.h"
#import "Recipe.h"

@interface bigOvenSQLiteDataSource : SQLiteDataSource

-(void)insertOrUpdate:(Recipe *)recipe;
-(NSArray *)getRecipes;
-(NSArray *)getIngredientsForRecipeID:(NSString *)recipeID;

@end
