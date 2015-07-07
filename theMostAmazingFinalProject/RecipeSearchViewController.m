//
//  RecipeSearchViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RecipeSearchViewController.h"
#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"
#import "BigOvenDataSource.h"
#import "SearchResultTableViewCell.h"
#import "RecipeSearchResult.h"
#import "RecipeViewController.h"
#import "ImageHelper.h"
#import "bigOvenSQLiteDataSource.h"

enum OPERATIONS {
    SEARCH_LOCAL = 1,
    SEARCH_ONLINE = 2,
};

@interface RecipeSearchViewController () <UISearchBarDelegate,BigOvenDataSourceDelegate,UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray * searchResultsArray;
@property(nonatomic, strong) NSMutableArray * arrRecipeObjects;
@property(nonatomic, strong) NSString *savedImageURL120;
@property(nonatomic, strong) dispatch_queue_t myQueue;
@property(nonatomic, strong) BigOvenDataSource *bods;
@property (strong, nonatomic) IBOutlet UITableView *tableSearchResults;

@end

@implementation RecipeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchResultsArray = [NSMutableArray new];
    
    [self.tableSearchResults registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableSearchResults setHidden:true];
    
    _myQueue = dispatch_queue_create("myQueue", nil);
    
    self.bods = [[BigOvenDataSource alloc] init];
    self.bods.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"User is searching for %@", searchBar.text);
    
    //Dismiss the keyboard
    [searchBar resignFirstResponder];
    
    if (self.searchParameter == SEARCH_LOCAL)
    {
        //Perform the request
        [self localRecipeSearch:searchBar.text];
    }
    else if (self.searchParameter == SEARCH_ONLINE)
    {
        //Perform the request
        NSString *formattedSearchString = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [self.bods getRecipeSearch:formattedSearchString];
    }
}

#pragma mark - Helper methods
-(void)localRecipeSearch:(NSString *)recipeKeywords
{
    //Search the database to see if the name exists
    bigOvenSQLiteDataSource *bosds = [[bigOvenSQLiteDataSource alloc] init];
    
    NSArray *arrSavedRecipes = [bosds getRecipes];
    NSMutableArray *arrMatchedRecipes = [NSMutableArray new];
    BOOL recipeFound = false;
    
    for (NSDictionary *aRecipe in arrSavedRecipes)
    {
        if ([[[aRecipe objectForKey:@"title"] uppercaseString] containsString:[recipeKeywords uppercaseString]])
        {
            recipeFound = true;
            [arrMatchedRecipes addObject:aRecipe];
        }
    }
    
    if (recipeFound == true)
    {
        //Create recipe search result objects for the found recipes
        NSLog(@"Create the recipe for display");
        self.arrRecipeObjects = [NSMutableArray new];
        for (NSDictionary *aRecipe in arrMatchedRecipes)
        {
            //Find the ingredients for the recipe
            NSArray *ingredientsForRecipe = [bosds getIngredientsForRecipeID:[aRecipe objectForKey:@"id"]];
            //Build the recipe object from recipe and ingredient info
            Recipe *recipe = [Recipe buildRecipeObjectForRecipeDict:aRecipe andIngredientsArray:ingredientsForRecipe];
            //Add it to an array of recipe object
            [_arrRecipeObjects addObject:recipe];
        }
        
        NSMutableArray *arrSearchResultObjects = [NSMutableArray new];
        for (Recipe *recipe in _arrRecipeObjects) {
            RecipeSearchResult *searchReult = [RecipeSearchResult buildObjectForRecipe:recipe];
            [arrSearchResultObjects addObject:searchReult];
        }
        
        //Present the table view
        self.searchResultsArray = [[NSMutableArray alloc] initWithArray:arrSearchResultObjects];
        //Load and present the table view
        dispatch_async(_myQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableSearchResults reloadData];
            });
        });
        [self.tableSearchResults setHidden:false];
        
    }
    else if (recipeFound == false)
    {
        //Notify the user the recipe doesn't exist locally
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe not found" message:@"No matching recipes were found locally. Consider searching online." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma  mark - BigOvenDataSource delegate methods
-(void)returnSearchResults:(NSMutableArray *)arrSeachResults
{
    //Assign the class array
    self.searchResultsArray = [[NSMutableArray alloc] initWithArray:arrSeachResults];
    NSString *resultCount = [self.searchResultsArray lastObject];
    [self.searchResultsArray removeLastObject];
    
    //Load and present the table view
   dispatch_async(_myQueue, ^{
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableSearchResults reloadData];
       });
   });
    [self.tableSearchResults setHidden:false];
}

-(void)returnRecipe:(Recipe *)recipeObject
{
    //Load the new view with the recipe object on the main thread
    __weak RecipeSearchViewController *wSelf = self;
    RecipeViewController *rvc = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    recipeObject.strRecipeImageURL120 = _savedImageURL120;
    
    rvc.recipeToDisplay = recipeObject;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wSelf.navigationController pushViewController:rvc animated:YES];
    });
}

#pragma mark - TableView delegate and datasource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //Load the data for the cell to display
    RecipeSearchResult *aSearchResult = [_searchResultsArray objectAtIndex:indexPath.row];
    
    //configure the cell
    cell.lblCategory.text = aSearchResult.strSearchCategory;
    cell.lblCuisine.text = aSearchResult.strSearchCuisine;
    cell.lblStarRating.text = aSearchResult.strSearchStarRating;
    cell.lblTitle.text = aSearchResult.strSearchTitle;
    cell.lblYield.text = [NSString stringWithFormat:@"%@ servings", aSearchResult.strSearchYieldNumber];
    [ImageHelper setImage:cell.imgRecipeImage120 FromPath:aSearchResult.strSearchImageURL120];

    NSLog(@"Completed a cell object");
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchParameter == SEARCH_LOCAL)
    {
        [self returnRecipe:[_arrRecipeObjects objectAtIndex:indexPath.row]];
    }
    else if (self.searchParameter == SEARCH_ONLINE)
    {
        //The user selected a recipe. Get that recipe
        RecipeSearchResult *lookThisUp = [self.searchResultsArray objectAtIndex:indexPath.row];
        _savedImageURL120 = lookThisUp.strSearchImageURL120;
        
        [self.bods getRecipe:[lookThisUp.strSearchRecipeID intValue]];
    }
}

@end
