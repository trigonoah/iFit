//
//  IngredientsTableViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "IngredientsTableViewController.h"
#import "BackgroundViewHelper.h"

@interface IngredientsTableViewController ()

@property (nonatomic, strong) NSMutableArray *arrIngrdients;
@property (nonatomic, strong) NSMutableArray *arrIngredientStrings;

@end

@implementation IngredientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadIngredients];
    
    //Register the cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //Add a touch gesture to the view to dismiss view
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finished)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapGesture];
}

-(void)finished
{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrIngredientStrings.count;
}

-(void)loadIngredients
{
    self.arrIngrdients = [[NSMutableArray alloc] initWithArray:self.currentRecipe.arrRecipeIngredients];
    
    self.arrIngredientStrings = [[NSMutableArray alloc] init];
    //Extract ingredients from array of disctionaries into array of strings
    for (NSDictionary *anIngredient in self.arrIngrdients) {
        NSString *quantity = [anIngredient objectForKey:@"DisplayQuantity"];
        NSString *name = [anIngredient objectForKey:@"Name"];
        NSString *quantityUnit = [anIngredient objectForKey:@"Unit"];
//        NSString *metricUnit = [anIngredient objectForKey:@"MetricUnit"];
//        NSString *metricQuantity = [anIngredient objectForKey:@"MetricDisplayQuantity"];
        
//        NSString *ingredientString = [NSString stringWithFormat:@"%@ %@ (%@ %@) %@", quantity, quantityUnit, metricQuantity, metricUnit, name];
        NSString *ingredientString = [NSString stringWithFormat:@"%@ %@ %@", quantity, quantityUnit, name];
        
        [self.arrIngredientStrings addObject:ingredientString];
    }
    
    //Ingredient strings have been parsed from dictionary.
    //Load the data into the table view cell
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    // Configure the cell...
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    cell.detailTextLabel.backgroundColor = [UIColor colorWithWhite:05. alpha:0.3];
    
    cell.textLabel.text = [self.arrIngredientStrings objectAtIndex:indexPath.row];
    
    NSDictionary *ingredientInfo = [[self.arrIngrdients objectAtIndex:indexPath.row] objectForKey:@"IngredientInfo"];
    if ([ingredientInfo isKindOfClass:[NSDictionary class]])
    {
        cell.detailTextLabel.text = [ingredientInfo objectForKey:@"Department"];
    }
    else
    {
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

@end
