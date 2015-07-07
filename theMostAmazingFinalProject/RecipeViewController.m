//
//  RecipeViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RecipeViewController.h"
#import "BackgroundViewHelper.h"
#import "ImageHelper.h"
#import "IngredientsTableViewController.h"
#import "DirectionsViewController.h"
#import "WebViewController.h"
#import "bigOvenSQLiteDataSource.h"



@interface RecipeViewController () <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblToolBarTitle;

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = self.recipeToDisplay.strRecipeTitle;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(btnBookmarkPressed:)];
    
    self.lblCategory.text = [NSString stringWithFormat:@"Category: %@",self.recipeToDisplay.strRecipeCategory];
    self.lblCategory.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.lblCuisine.text = [NSString stringWithFormat:@"Cuisine: %@", self.recipeToDisplay.strRecipeCuisine];
    self.lblCuisine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.lblMainIngredient.text = [NSString stringWithFormat:@"Main ingredient: %@",self.recipeToDisplay.strRecipePrimaryIngredient];
    self.lblMainIngredient.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.lblPrepTime.text = [NSString stringWithFormat:@"Prep time: %@ minutes",self.recipeToDisplay.strRecipeTotalMinutes];
    self.lblPrepTime.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.lblRating.text = [NSString stringWithFormat:@"%g/5 stars", [self.recipeToDisplay.strRecipeStarRating floatValue]];
    self.lblRating.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.lblYield.text = [NSString stringWithFormat:@"Yields: %@ %@", self.recipeToDisplay.strRecipeYieldNumber, self.recipeToDisplay.strRecipeYieldUnit];
    self.lblYield.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    [ImageHelper setImage:self.imgRecipeImage FromPath:self.recipeToDisplay.strRecipeImageURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

#pragma mark - Button methods
- (IBAction)btnBackPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnBookmarkPressed:(id)sender
{
    //Download the recipe and save it to the database
    bigOvenSQLiteDataSource *bosds = [[bigOvenSQLiteDataSource alloc] init];

    NSArray *arrSavedRecipes = [bosds getRecipes];
    BOOL recipeFound = false;
    
    for (NSDictionary *aRecipe in arrSavedRecipes)
    {
        if ([[aRecipe objectForKey:@"id"] isEqualToString:self.recipeToDisplay.strRecipeID])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe already saved" message:@"This recipe is already bookmarked as a favorite. Would you like to remove the from favorites?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Remove", nil];
            [alert setDelegate:self];
            [alert show];
            recipeFound = true;
            break;
        }
    }
    
    if (recipeFound == false) {
        [bosds insertOrUpdate:self.recipeToDisplay];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe saved!" message:@"Recipe has been added to favorites!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)btnIngredientsPressed:(id)sender
{
    //Load a popover with a scrollable table view of ingredients
    IngredientsTableViewController *itvc = [[IngredientsTableViewController alloc] initWithNibName:@"IngredientsTableViewController" bundle:nil];
    itvc.currentRecipe = self.recipeToDisplay;

    itvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:itvc animated:YES completion:nil];
}

- (IBAction)btnDirectionsPressed:(id)sender
{
    DirectionsViewController *dvc = [[DirectionsViewController alloc] initWithNibName:@"DirectionsViewController" bundle:nil];
    dvc.currentRecipe = self.recipeToDisplay;
    
    dvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:dvc animated:YES completion:nil];
}

- (IBAction)btnWebpagePressed:(id)sender
{
    WebViewController *wvc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    wvc.currentRecipe = self.recipeToDisplay;
    
    wvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:wvc animated:YES completion:nil];
}

#pragma mark - UIAlertView delegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Cancel was pressed. Do nothing
    }
    else if (buttonIndex == 1)
    {
        //Remove was pressed. Do something
        bigOvenSQLiteDataSource *bosds = [[bigOvenSQLiteDataSource alloc] init];
        [bosds executeDeleteOperation:@"bigoven_recipes" andFilter:[NSDictionary dictionaryWithObject:self.recipeToDisplay.strRecipeID forKey:@"id"]];
        [bosds executeDeleteOperation:@"bigoven_ingredientsForRecipe" andFilter:[NSDictionary dictionaryWithObject:self.recipeToDisplay.strRecipeID forKey:@"recipe_id"]];
        NSLog(@"Remove entry from the database");
    }
}
@end
