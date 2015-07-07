//
//  BigOvenDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceHandler.h"
#import "Recipe.h"
#import "RecipeSearchResult.h"

@protocol BigOvenDataSourceDelegate <NSObject>

@optional
-(void)returnSearchResults:(NSMutableArray *)arrSeachResults;
-(void)returnRecipe:(Recipe *)recipeObject;

@end

@interface BigOvenDataSource : NSObject <WebServiceHandlerDelegate>{
    int currentOperation;
    WebServiceHandler *webHandler;
}

@property(nonatomic, weak) id <BigOvenDataSourceDelegate> delegate;

-(void)getRecipe:(int)recipeNumber;
-(void)getRecipeSearch:(NSString *)keyword;
-(void)getRecipeFavorites;


@end
