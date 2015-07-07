//
//  BigOvenDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "BigOvenDataSource.h"

static NSString * const BIGOVEN_RECIPE_REQUEST_URL = @"http://api.bigoven.com/recipe/%d?api_key=dvx0869aFk8U96H9396Ocbux33T0YYM6";

static NSString * const BIGOVER_RECIPE_SEARCH_REQUEST_URL = @"http://api.bigoven.com/recipes/?api_key=dvx0869aFk8U96H9396Ocbux33T0YYM6&pg=1&rpp=50&title_kw=%@";

static NSString * const BIGOVEN_RECIPE_FAVORITES_REQUEST_URL = @"http://api.bigoven.com/favorites?api_key=dvx0869aFk8U96H9396Ocbux33T0YYM6&pg=1&rpp=25";

@implementation BigOvenDataSource

enum OPERATIONS {
    GET_RECIPE = 1,
    GET_RECIPE_SEARCH = 2,
    GET_RECIPE_FAVORITES = 3,
};

-(instancetype)init{
    self = [super init];
    if (self) {
        currentOperation = 0;
        webHandler = [[WebServiceHandler alloc] initWithDelegate:self];
    }
    return self;
}

-(void)getRecipe:(int)recipeNumber
{
    currentOperation = GET_RECIPE;
    NSDictionary *jsonHeader = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Accept", nil];
    [webHandler doRequest:[NSString stringWithFormat:BIGOVEN_RECIPE_REQUEST_URL,recipeNumber] withParameters:nil andHeaders:jsonHeader andHTTPMethod:@"GET"];
}

-(void)getRecipeSearch:(NSString *)keyword
{
    currentOperation = GET_RECIPE_SEARCH;
    NSDictionary *jsonHeader = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Accept", nil];
    [webHandler doRequest:[NSString stringWithFormat:BIGOVER_RECIPE_SEARCH_REQUEST_URL, keyword] withParameters:nil andHeaders:jsonHeader andHTTPMethod:@"GET"];
}

-(void)getRecipeFavorites
{
    currentOperation = GET_RECIPE_FAVORITES;
    NSDictionary *jsonHeader = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Accept", @"Basic dHJpZ29ub2FoOmVzcGVvbg==", @"Authorization", nil];
    [webHandler doRequest:BIGOVEN_RECIPE_FAVORITES_REQUEST_URL withParameters:nil andHeaders:jsonHeader andHTTPMethod:@"GET"];
}

-(void)webServiceCallFinished:(id)data
{
    NSError *error;
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"There was an error in parsing the recipe's JSON file");
    }
    else if (currentOperation == GET_RECIPE)
    {
        //Create a recipe object
        Recipe *myRecipe = [[Recipe alloc] initNewRecipeWithJSON:jsonObject];
        NSLog(@"Recipe for %@ recieved", myRecipe.strRecipeTitle);
        
        //Return the recipe object
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(returnRecipe:)]) {
                [self.delegate returnRecipe:myRecipe];
            } else {
                NSLog(@"delegate doesn't respond to selector");
            }
        } else {
            NSLog(@"delegate is nil");
        }
    }
    else if (currentOperation == GET_RECIPE_SEARCH)
    {
        NSMutableArray *arrSearchResults = [NSMutableArray new];
        NSMutableArray *searchResultsArray = [[NSMutableArray alloc] initWithArray:[jsonObject objectForKey:@"Results"]];
        
        NSMutableArray *newArray = [NSMutableArray new];
        for (NSDictionary *dic in searchResultsArray) {
            NSMutableDictionary *newDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
            [newArray addObject:newDic];
        }
        
        for (NSMutableDictionary *dic in newArray) {
            for (NSString *key in dic.allKeys) {
                if ([[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
                    [dic setObject:@"" forKey:key];
                }
            }
        }
        
        for (NSDictionary *aSearchResultDict in newArray) {
            
            RecipeSearchResult *aSearch = [[RecipeSearchResult alloc] initWithJSONDict:aSearchResultDict];
            [arrSearchResults addObject:aSearch];
        }
        
        //Add total number of results as the last object in the array
        [arrSearchResults addObject:[[jsonObject objectForKey:@"ResultCount"] stringValue]];
        [self.delegate returnSearchResults:arrSearchResults];
         
        NSLog(@"Description of search results: %@", arrSearchResults);
        
    }
    else if (currentOperation == GET_RECIPE_FAVORITES)
    {
        NSLog(@"Favorites were obtained. Do something useful");
    }

}

-(void)webServiceCallError:(NSError *)error
{
    NSLog(@"%@",error.description);
}

@end
