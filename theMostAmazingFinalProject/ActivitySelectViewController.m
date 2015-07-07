//
//  PostActivityViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ActivitySelectViewController.h"
#import "BackgroundViewHelper.h"
#import "PostActivityViewController.h"

@interface ActivitySelectViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerActivity;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerDateTime;
@property (strong, nonatomic) NSArray * arrActivities;
@property (strong, nonatomic) NSArray * arrEquipment;
@property (strong, nonatomic) IBOutlet UILabel *lblStartDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblActivityEquipment;
@property (strong, nonatomic) NSString * strActivity;
@property (strong, nonatomic) NSString * strEquipment;

@end

@implementation ActivitySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.arrActivities = @[@"Running", @"Cycling", @"Mountain Biking", @"Walking", @"Hiking", @"Downhill Skiing", @"Cross-Country Skiing", @"Snowboarding", @"Skating", @"Swimming", @"Wheelchair", @"Rowing", @"Elliptical", @"Other"];
    
    self.arrEquipment = @[@"None", @"Treadmill", @"Stationary Bike", @"Elliptical", @"Row Machine"];
    
    //Set the strings to a default value in case user doesn't interact with picker
    self.strActivity = @"Running";
    self.strEquipment = @"None";
    
    self.pickerActivity.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.pickerDateTime.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.lblActivityEquipment.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.lblStartDateTime.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loadNextView)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

#pragma mark - Helper methods
-(void)loadNextView
{
    //Push data to the second post activity view
    PostActivityViewController *pavc = [[PostActivityViewController alloc] initWithNibName:@"PostActivityViewController" bundle:nil];
    
    //Pass the data to the view controller
    pavc.someActivityInfo = [[NSMutableArray alloc] initWithArray:[self formSomeActivityInfo]];
    
    //Set the transition animation and add it to the navigation controller layer
    CATransition* transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    //Push the new view
    [self.navigationController pushViewController:pavc animated:YES];
    
}

-(NSArray *)formSomeActivityInfo
{
    //Set user entered date/time into proper format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];    //Wed, Dec 14 2011 1:50 PM
    NSString *str_date = [dateFormat stringFromDate:[self.pickerDateTime date]];

    //Return array of selections
    return @[self.strActivity, self.strEquipment, str_date];
}

#pragma mark - Picker delegate and datasource methods
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        //Set the activity string
        self.strActivity = [self.arrActivities objectAtIndex:row];
    }
    else if (component == 1)
    {
        //Set the equipment string
        self.strEquipment = [self.arrEquipment objectAtIndex:row];
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    NSInteger numberOfRows;
    
    if (component == 0)
    {
        numberOfRows = self.arrActivities.count;
    }
    else if (component == 1)
    {
        numberOfRows = self.arrEquipment.count;
    }
    
    return numberOfRows;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowTitle = [NSString new];
    
    if (component == 0)
    {
        rowTitle = [self.arrActivities objectAtIndex:row];
    }
    else if (component == 1)
    {
        rowTitle = [self.arrEquipment objectAtIndex:row];
    }
    
    return rowTitle;
}

#pragma mark - Date Picker methods

@end
