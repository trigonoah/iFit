//
//  Recipe.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

-(id)initNewRecipeWithJSON:(NSDictionary *)jsonDict{
    self = [super init];
    
    if (self)
    {
        //Check the jsonDict for any nil entries. Replace nil entries with empty string
        NSMutableDictionary *jsonDictMutable = [[NSMutableDictionary alloc] initWithDictionary:jsonDict];
        
        for (NSString *key in jsonDict.allKeys) {
            if ([[jsonDictMutable objectForKey:key] isKindOfClass:[NSNull class]])
            {
//                NSLog(@"Found a nil entry");
                [jsonDictMutable setObject:@"" forKey:key];
            }
        }
        
        self.strRecipeCuisine = [jsonDictMutable objectForKey:@"Cuisine"];
        self.strRecipeStarRating = [[jsonDictMutable objectForKey:@"StarRating"] stringValue];
        self.strRecipeReviewCount = [[jsonDictMutable objectForKey:@"ReviewCount"] stringValue];
        self.strRecipePrimaryIngredient = [jsonDictMutable objectForKey:@"PrimaryIngredient"];

        if ([[jsonDictMutable objectForKey:@"TotalMinutes"] isKindOfClass:[NSString class]] && [[jsonDictMutable objectForKey:@"TotalMinutes"] isEqualToString:@""])
        {
            self.strRecipeTotalMinutes = @"";
        }
        else if ([[[jsonDictMutable objectForKey:@"TotalMinutes"] stringValue] isEqualToString: @""])
        {
            self.strRecipeTotalMinutes = @"";
        }
        else
        {
            self.strRecipeTotalMinutes = [[jsonDictMutable objectForKey:@"TotalMinutes"] stringValue];
        }
    
        self.strRecipeCategory = [jsonDictMutable objectForKey:@"Category"];
        self.dictRecipeNutrionInfo = [jsonDictMutable objectForKey:@"NutritionInfo"];
        
        if ([[[jsonDictMutable objectForKey:@"YieldNumber"] stringValue] isEqualToString: @""])
        {
            self.strRecipeYieldNumber = @"";
        }
        else
        {
            self.strRecipeYieldNumber = [[jsonDictMutable objectForKey:@"YieldNumber"] stringValue];
        }
        
        self.strRecipeWebURL = [jsonDictMutable objectForKey:@"WebURL"];
        self.strRecipeInstructions = [jsonDictMutable objectForKey:@"Instructions"];
        self.strRecipeYieldUnit = [jsonDictMutable objectForKey:@"YieldUnit"];
        
        if ([[[jsonDictMutable objectForKey:@"RecipeID"] stringValue] isEqualToString:@""])
        {
            self.strRecipeID = @"";
        }
        else
        {
            self.strRecipeID = [[jsonDictMutable objectForKey:@"RecipeID"] stringValue];
            
        }
        
        self.strRecipeTitle = [jsonDictMutable objectForKey:@"Title"];
        self.strRecipeImageURL = [jsonDictMutable objectForKey:@"ImageURL"];
        self.arrRecipeIngredients = [jsonDictMutable objectForKey:@"Ingredients"];
        self.strRecipePoster = [[jsonDictMutable objectForKey:@"Poster"] objectForKey:@"UserName"];
        self.strRecipeHeroPhotoURL = [jsonDictMutable objectForKey:@"HeroPhotoUrl"];
        
        if ([[[jsonDictMutable objectForKey:@"FavoriteCount"] stringValue] isEqualToString:@""])
        {
            self.strRecipeFavoriteCount = @"";

        }
        else
        {
            self.strRecipeFavoriteCount = [[jsonDictMutable objectForKey:@"FavoriteCount"] stringValue];

        }
        
    }
    
    return self;
}

+(Recipe *)buildRecipeObjectForRecipeDict:(NSDictionary *)dictRecipe andIngredientsArray:(NSArray *)arrIngredients
{
    Recipe *recipe = [[Recipe alloc] init];
    
    recipe.arrRecipeIngredients = arrIngredients;
    recipe.strRecipeCuisine = [dictRecipe objectForKey:@"cuisine"];
    recipe.strRecipeStarRating = [dictRecipe objectForKey:@"starRating"];
    recipe.strRecipeReviewCount = @"";
    recipe.strRecipePrimaryIngredient = [dictRecipe objectForKey:@"primaryIngredient"];
    recipe.strRecipeTotalMinutes = [dictRecipe objectForKey:@"totalMinutes"];
    recipe.strRecipeCategory = [dictRecipe objectForKey:@"category"];
    recipe.dictRecipeNutrionInfo = @{};
    recipe.strRecipeYieldNumber = [dictRecipe objectForKey:@"yieldNumber"];
    recipe.strRecipeWebURL = [dictRecipe objectForKey:@"webURL"];
    recipe.strRecipeInstructions = [dictRecipe objectForKey:@"instructions"];
    recipe.strRecipeYieldUnit = [dictRecipe objectForKey:@"yieldUnit"];
    recipe.strRecipeID = [dictRecipe objectForKey:@"id"];
    recipe.strRecipeTitle = [dictRecipe objectForKey:@"title"];
    recipe.strRecipeImageURL = [dictRecipe objectForKey:@"imageURL"];
    recipe.strRecipePoster = [dictRecipe objectForKey:@"poster"];
    recipe.strRecipeHeroPhotoURL = [dictRecipe objectForKey:@"heroPhotoURL"];
    recipe.strRecipeFavoriteCount = [dictRecipe objectForKey:@"favoriteCount"];
    recipe.strRecipeImageURL120 = [dictRecipe objectForKey:@"imageURL120"];
    
    return recipe;
}


@end
