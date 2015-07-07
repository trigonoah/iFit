//
//  Recipe.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property(strong,nonatomic) NSString * strRecipeCuisine;
@property(strong,nonatomic) NSString * strRecipeStarRating;
@property(strong,nonatomic) NSString * strRecipeReviewCount;
@property(strong,nonatomic) NSString * strRecipePrimaryIngredient;
@property(strong,nonatomic) NSString * strRecipeTotalMinutes;
@property(strong,nonatomic) NSString * strRecipeCategory;
@property(strong,nonatomic) NSDictionary * dictRecipeNutrionInfo;
@property(strong,nonatomic) NSString * strRecipeYieldNumber;
@property(strong,nonatomic) NSString * strRecipeWebURL;
@property(strong,nonatomic) NSString * strRecipeInstructions;
@property(strong,nonatomic) NSString * strRecipeYieldUnit;
@property(strong,nonatomic) NSString * strRecipeID;
@property(strong,nonatomic) NSString * strRecipeTitle;
@property(strong,nonatomic) NSString * strRecipeImageURL;
@property(strong,nonatomic) NSArray * arrRecipeIngredients;
@property(strong,nonatomic) NSString * strRecipePoster;
@property(strong,nonatomic) NSString * strRecipeHeroPhotoURL;
@property(strong,nonatomic) NSString * strRecipeFavoriteCount;
@property(strong,nonatomic) NSString * strRecipeImageURL120;


-(id)initNewRecipeWithJSON:(NSDictionary *)jsonDict;
+(Recipe *)buildRecipeObjectForRecipeDict:(NSDictionary *)dictRecipe andIngredientsArray:(NSArray *)arrIngredients;
@end
