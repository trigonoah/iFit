//
//  AddExercisesViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "AddExercisesViewController.h"
#import "BackgroundViewHelper.h"
#import "ExerciseDetailViewController.h"
#import "wgerSQLiteDataSource.h"
#import "WorkoutManagerDataSource.h"

@interface AddExercisesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *exerciseTable;

@end

@implementation AddExercisesViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Add Exercise";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    wgerSQLiteDataSource *sqlite = [wgerSQLiteDataSource new];
    allExercises = [[NSMutableArray alloc] initWithArray:[sqlite getAllExercises]];
    NSMutableArray *objectsToRemove = [NSMutableArray new];
    for (NSDictionary *exercise in allExercises) {
        for (NSDictionary *currentExercise in self.exercisesArr) {
            NSArray *exercisesArray = [currentExercise objectForKey:@"exercises"];
            if ([[exercise objectForKey:@"id"] isEqual:[exercisesArray firstObject]]) {
                [objectsToRemove addObject:exercise];
            }
        }
    }
    for (id object in objectsToRemove) {
        [allExercises removeObject:object];
    }
    
    [self.exerciseTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.addButton setEnabled:NO];
    [self.detailButton setEnabled:NO];
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

#pragma mark - User Interaction methods

- (IBAction)addExercise:(id)sender {
    
    NSMutableDictionary *set = [[NSMutableDictionary alloc] initWithDictionary:self.workout];
    [set setObject:[NSNumber numberWithInt:1] forKey:@"order"];
    [set setObject:[NSNumber numberWithInt:1] forKey:@"sets"];
    [set setObject:@[[[allExercises objectAtIndex:[self.exerciseTable indexPathForSelectedRow].row] objectForKey:@"id"]] forKey:@"exercises"];
    WorkoutManagerDataSource *wgerDataSource;
    wgerDataSource = [WorkoutManagerDataSource new];
    [wgerDataSource postAExerciseForWorkout:set];
}

- (IBAction)seeDetail:(id)sender {
    NSDictionary *exercise = [allExercises objectAtIndex:[self.exerciseTable indexPathForSelectedRow].row];
    ExerciseDetailViewController *exerDVC = [[ExerciseDetailViewController alloc] init];
    exerDVC.exerciseDic = exercise;
    [self.navigationController pushViewController:exerDVC animated:YES];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allExercises.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    cell= [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *exercise = [allExercises objectAtIndex:indexPath.row];
    cell.textLabel.text = [exercise objectForKey:@"name"];
    return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.addButton setEnabled:YES];
    [self.detailButton setEnabled:YES];
}

@end
