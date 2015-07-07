//
//  RecipeSearchResult.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"

@interface RecipeSearchResult : NSObject

@property(strong,nonatomic) NSString * strSearchYieldNumber;
@property(strong,nonatomic) NSString * strSearchTitle;
@property(strong,nonatomic) NSString * strSearchQualityScore;
@property(strong,nonatomic) NSString * strSearchImageURL120;
@property(strong,nonatomic) NSString * strSearchStarRating;
@property(strong,nonatomic) NSString * strSearchRecipeID;
@property(strong,nonatomic) NSString * strSearchCategory;
@property(strong,nonatomic) NSString * strSearchCuisine;

-(id)initWithJSONDict:(NSDictionary *)jsonDict;
+(RecipeSearchResult *)buildObjectForRecipe:(Recipe *)recipe;

@end
