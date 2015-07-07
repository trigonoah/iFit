//
//  PostActivityViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "PostActivityViewController.h"
#import "BackgroundViewHelper.h"
#import "FitnessActivityPost.h"
#import "RunKeeperDataSource.h"

@interface PostActivityViewController () <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtDistance;
@property (strong, nonatomic) IBOutlet UITextField *txtDuration;
@property (strong, nonatomic) IBOutlet UITextField *txtCaloriesBurned;
@property (strong, nonatomic) IBOutlet UITextView *txtNotes;

@end

@implementation PostActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Set a border for the text view
    self.txtNotes.layer.borderWidth = 1.0f;
    self.txtNotes.layer.borderColor = [[UIColor grayColor] CGColor];
    
    //Simulate placeholder text in textview
    self.txtNotes.text = @"Enter any notes here";
    self.txtNotes.textColor = [UIColor lightGrayColor];
    
    self.txtNotes.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.txtDuration.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.txtDistance.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.txtCaloriesBurned.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    //Add a "done" button to the navigation controller to post the fitness activity
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(postActivity)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

#pragma mark - Helper methods
-(void)postActivity
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Preparing Submission" message:@"Are you sure you want to post this activity to Runkeeper (make sure you've entered all relevant fields)?"delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Post!", nil];
    [alert show];
}

#pragma mark - Textfield delegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Dismiss the keyboard
    [textField resignFirstResponder];
    return true;
}


#pragma mark - Textview delegate methods
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        textView.text = @"Enter any notes here";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Do nothing
    }
    else if (buttonIndex == 1)
    {
        //Create the fitness activity post object
        FitnessActivityPost *aNewPost = [[FitnessActivityPost alloc] init];
        aNewPost.strType = [self.someActivityInfo objectAtIndex:0];
        aNewPost.strEquipment = [self.someActivityInfo objectAtIndex:1];
        aNewPost.strStartTime = [self.someActivityInfo objectAtIndex:2];
        aNewPost.strTotalDistance = self.txtDistance.text;
        aNewPost.strDuration = [NSString stringWithFormat:@"%d", [self.txtDuration.text intValue] * 60];
        aNewPost.strTotalCalories = self.txtCaloriesBurned.text;
        aNewPost.strNotes = [self.txtNotes.text isEqualToString:@"Enter any notes here"] ? @"" : self.txtNotes.text;
        
        //Post the activity
        RunKeeperDataSource * rkds = [[RunKeeperDataSource alloc] init];
        [rkds postFitnessActivity:aNewPost];
        
        //Dismiss the view
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
