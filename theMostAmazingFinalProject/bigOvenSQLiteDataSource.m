//
//  bigOvenSQLiteDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "bigOvenSQLiteDataSource.h"

@implementation bigOvenSQLiteDataSource

-(void)insertOrUpdate:(Recipe *)recipe{
    
    for (NSDictionary *anIngredient in recipe.arrRecipeIngredients) {
        NSString *quantity = [anIngredient objectForKey:@"DisplayQuantity"];
        NSString *name = [anIngredient objectForKey:@"Name"];
        NSString *quantityUnit = [anIngredient objectForKey:@"Unit"];
        NSString *metricUnit = [anIngredient objectForKey:@"MetricUnit"];
        NSString *metricQuantity = [anIngredient objectForKey:@"MetricDisplayQuantity"];
        
        NSMutableDictionary *ingredientDic = [NSMutableDictionary new];
        [ingredientDic setObject:[anIngredient objectForKey:@"IngredientID"] forKey:@"IngredientID"];
        [ingredientDic setObject:quantity forKey:@"DisplayQuantity"];
        [ingredientDic setObject:name forKey:@"Name"];
        [ingredientDic setObject:quantityUnit forKey:@"Unit"];
        [ingredientDic setObject:metricUnit forKey:@"MetricUnit"];
        [ingredientDic setObject:metricQuantity forKey:@"MetricDisplayQuantity"];
        
        //Clean up any null values in the dictionary
        ingredientDic = (NSMutableDictionary *)[self cleanupNullVariables:ingredientDic];
        
        NSArray *currentIngredient = [self executeQuery:[NSString stringWithFormat:@"SELECT IngredientID FROM bigoven_ingredients WHERE IngredientID = %@",[anIngredient objectForKey:@"IngredientID"]]];
        if (currentIngredient.count > 0) {
            [self executeUpdateOperation:@"bigoven_ingredients" andData:ingredientDic andFilter:[NSDictionary dictionaryWithObject:[anIngredient objectForKey:@"IngredientID"] forKey:@"IngredientID"]];
        } else {
            [self executeInsertOperation:@"bigoven_ingredients" andData:ingredientDic];
            [self executeInsertOperation:@"bigoven_ingredientsForRecipe" andData:[NSDictionary dictionaryWithObjects:@[recipe.strRecipeID, [anIngredient objectForKey:@"IngredientID"]] forKeys:@[@"recipe_id", @"ingredient_id"]]];
        }
    }

    
    NSMutableDictionary *recipeDic = [NSMutableDictionary new];
    [recipeDic setObject:recipe.strRecipeID forKey:@"id"];
    [recipeDic setObject:recipe.strRecipeCuisine forKey:@"cuisine"];
    [recipeDic setObject:recipe.strRecipeStarRating forKey:@"starRating"];
    [recipeDic setObject:recipe.strRecipePrimaryIngredient forKey:@"primaryIngredient"];
    [recipeDic setObject:recipe.strRecipeTotalMinutes forKey:@"totalMinutes"];
    [recipeDic setObject:recipe.strRecipeCategory forKey:@"category"];
    [recipeDic setObject:recipe.strRecipeYieldNumber forKey:@"yieldNumber"];
    [recipeDic setObject:recipe.strRecipeWebURL forKey:@"webURL"];
    [recipeDic setObject:[recipe.strRecipeInstructions stringByReplacingOccurrencesOfString:@"'" withString:@""] forKey:@"instructions"];
    [recipeDic setObject:recipe.strRecipeYieldUnit forKey:@"yieldUnit"];
    [recipeDic setObject:[recipe.strRecipeTitle stringByReplacingOccurrencesOfString:@"'" withString:@""] forKey:@"title"];
    [recipeDic setObject:recipe.strRecipeImageURL forKey:@"imageURL"];
    [recipeDic setObject:recipe.strRecipePoster forKey:@"poster"];
    [recipeDic setObject:recipe.strRecipeHeroPhotoURL forKey:@"heroPhotoURL"];
    [recipeDic setObject:recipe.strRecipeFavoriteCount forKey:@"favoriteCount"];
    [recipeDic setObject:recipe.strRecipeImageURL120 forKey:@"imageURL120"];
    
    recipeDic = (NSMutableDictionary *)[self cleanupNullVariables:recipeDic];
    
    NSArray *curretObjects = [self executeSingleSelect:@"bigoven_recipes" andColumnNames:@[@"id"] andFilter:[NSDictionary dictionaryWithObject:recipe.strRecipeID forKey:@"id"] andLimit:2];
    if (curretObjects.count > 0) {
        [self executeUpdateOperation:@"bigoven_recipes" andData:recipeDic andFilter:[NSDictionary dictionaryWithObject:[recipeDic objectForKey:@"id"] forKey:@"id"]];
    } else {
        [self executeInsertOperation:@"bigoven_recipes" andData:recipeDic];
    }
}

-(NSArray *)getRecipes
{
    return [self executeSingleSelect:@"bigoven_recipes" andColumnNames:nil andFilter:nil andLimit:0];
}

-(NSArray *)getIngredientsForRecipeID:(NSString *)recipeID
{
    NSArray *arrIngredientIDsForRecipe = [self executeQuery:[NSString stringWithFormat:@"SELECT ingredient_id FROM bigoven_ingredientsForRecipe WHERE recipe_id = %@", recipeID]];
    
    NSMutableArray *arrIngredientsForRecipe = [NSMutableArray new];
    for (NSDictionary *anIngredientID in arrIngredientIDsForRecipe)
    {
        NSString *searchQuery = @"SELECT * FROM bigoven_ingredients WHERE IngredientID = %@";
        
        [arrIngredientsForRecipe addObject:[self executeQuery:[NSString stringWithFormat:searchQuery, [anIngredientID objectForKey:@"ingredient_id"]]]];
    }
    
    return arrIngredientsForRecipe;
}

-(NSDictionary *)cleanupNullVariables:(NSDictionary *)originalDictionary
{
    NSArray *keys = [originalDictionary allKeys];
    NSMutableDictionary *ret = [originalDictionary mutableCopy];
    for (NSString *k in keys) {
        if([[originalDictionary objectForKey:k] isKindOfClass:[NSNull class]])
        {
            [ret removeObjectForKey:k];
        }
    }
    return ret;
}
@end
