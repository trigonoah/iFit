//
//  FavoritesViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "FavoritesViewController.h"
#import "BackgroundViewHelper.h"
#import "Recipe.h"
#import "RecipeSearchResult.h"
#import "bigOvenSQLiteDataSource.h"
#import "SearchResultTableViewCell.h"
#import "ImageHelper.h"
#import "RecipeViewController.h"

@interface FavoritesViewController () <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrRecipeObjects;
@property (nonatomic, strong) NSMutableArray *arrSearchResultObjects;
@property (nonatomic, strong) dispatch_queue_t myQueue;
@property (strong, nonatomic) IBOutlet UITableView *tableSearchResults;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Setup the navigation bar
    self.navigationItem.title = @"My Fav Recipes";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeAllRecipes)];
    
    //Get recipes to display from the database
    //Search the database to see if the name exists
    bigOvenSQLiteDataSource *bosds = [[bigOvenSQLiteDataSource alloc] init];
    
    NSArray *arrSavedRecipes = [bosds getRecipes];

    //Create recipe search result objects for the found recipes
    NSLog(@"Create the recipe search result for display");
    self.arrRecipeObjects = [NSMutableArray new];
    for (NSDictionary *aRecipe in arrSavedRecipes)
    {
        //Find the ingredients for the recipe
        NSArray *ingredientsForRecipe = [bosds getIngredientsForRecipeID:[aRecipe objectForKey:@"id"]];
        //Build the recipe object from recipe and ingredient info
        Recipe *recipe = [Recipe buildRecipeObjectForRecipeDict:aRecipe andIngredientsArray:ingredientsForRecipe];
        //Add it to an array of recipe object
        [_arrRecipeObjects addObject:recipe];
    }
    
    _arrSearchResultObjects = [NSMutableArray new];
    for (Recipe *recipe in _arrRecipeObjects) {
        RecipeSearchResult *searchReult = [RecipeSearchResult buildObjectForRecipe:recipe];
        [self.arrSearchResultObjects addObject:searchReult];
    }
    
    //Load and present the table view
    _myQueue = dispatch_queue_create("myQueue", nil);
    dispatch_async(_myQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableSearchResults reloadData];
        });
    });
    
    
    
    //Register the table cell
    [self.tableSearchResults registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

-(void)removeAllRecipes
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Do you want to delete all saved recipes?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Do nothing
    }
    else if (buttonIndex == 1)
    {
        //Delete everything from the database
        bigOvenSQLiteDataSource *bosds = [[bigOvenSQLiteDataSource alloc] init];
        [bosds executeQuery:@"DELETE FROM bigoven_recipes"];
        [bosds executeQuery:@"DELETE FROM bigoven_ingredients"];
        [bosds executeQuery:@"DELETE FROM bigoven_ingredientsForRecipe"];
        
        [self.arrSearchResultObjects removeAllObjects];
        [self.arrRecipeObjects removeAllObjects];
        [self.tableSearchResults reloadData];
        NSLog(@"Favorites database has been cleared");
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrSearchResultObjects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //Configure the cell
    RecipeSearchResult *aSearchResult = [self.arrSearchResultObjects objectAtIndex:indexPath.row];
    
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
    //Load the new view with the recipe object on the main thread
    RecipeViewController *rvc = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    rvc.recipeToDisplay = [self.arrRecipeObjects objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:rvc animated:YES];
    });
}

@end
