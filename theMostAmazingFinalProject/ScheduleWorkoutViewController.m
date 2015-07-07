//
//  ScheduleWorkoutViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ScheduleWorkoutViewController.h"
#import "BackgroundViewHelper.h"
#import "ExerciseDetailViewController.h"
#import "wgerSQLiteDataSource.h"
#import "AddExercisesViewController.h"

@interface ScheduleWorkoutViewController ()

@property (weak, nonatomic) IBOutlet UITableView *schedulesTableView;
@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;
@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;

@end

@implementation ScheduleWorkoutViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Schedule you workout";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.schedulesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"scheduleCell"];
    [self.workoutsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"workoutCell"];
    [self.exercisesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"exerciseCell"];
    schedulesArr = [NSMutableArray new];
    workoutsArr = [NSMutableArray new];
    scheduleStepsArr = [NSMutableArray new];
    daysArr = [NSMutableArray new];
    exercisesArr = [NSMutableArray new];
    workoutsArrFiltered = [NSMutableArray new];
    exercisesArrFiltered = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
    [schedulesArr removeAllObjects];
    [workoutsArr removeAllObjects];
    [daysArr removeAllObjects];
    [exercisesArr removeAllObjects];
    [workoutsArrFiltered removeAllObjects];
    [exercisesArrFiltered removeAllObjects];
    [addExerciseButton setEnabled:NO];
    [addWorkoutButton setEnabled:NO];
    [self.schedulesTableView reloadData];
    [self.workoutsTableView reloadData];
    [self.exercisesTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    WorkoutManagerDataSource *wgerDataSource;
    wgerDataSource = [WorkoutManagerDataSource new];
    wgerDataSource.delegate = self;
    [wgerDataSource getSchedules];
    [activityView startAnimating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - User Interaction methods

- (IBAction)addScheduleButtonPressed:(id)sender {
}

- (IBAction)addWorkoutButtonPressed:(id)sender {
}

- (IBAction)addExercisesButtonPressed:(id)sender {
    AddExercisesViewController *aevc = [AddExercisesViewController new];
    NSDictionary *workoutDic = [workoutsArrFiltered objectAtIndex:self.workoutsTableView.indexPathForSelectedRow.row];
    NSNumber *workoutId = [workoutDic objectForKey:@"id"];
    NSNumber *dayId;
    for (NSDictionary *day in daysArr) {
        if ([[day objectForKey:@"training"] isEqual:workoutId]) {
            dayId = [day objectForKey:@"id"];
        }
    }
    aevc.workout = [NSDictionary dictionaryWithObject:dayId forKey:@"exerciseday"];
    aevc.exercisesArr = [NSArray arrayWithArray:exercisesArrFiltered];
    [self.navigationController pushViewController:aevc animated:YES];
}

#pragma mark - WorkoutManagerDataSourceDelegate methods

-(void)schedulesSyncronized:(NSDictionary *)schedules{
    [activityView stopAnimating];
    
    [schedulesArr removeAllObjects];
    [schedulesArr addObjectsFromArray:[schedules objectForKey:@"schedules"]];
    
    [workoutsArr removeAllObjects];
    [workoutsArr addObjectsFromArray:[schedules objectForKey:@"workouts"]];
    
    [scheduleStepsArr removeAllObjects];
    [scheduleStepsArr addObjectsFromArray:[schedules objectForKey:@"scheduleSteps"]];
    
    [daysArr removeAllObjects];
    [daysArr addObjectsFromArray:[schedules objectForKey:@"days"]];
    
    [exercisesArr removeAllObjects];
    [exercisesArr addObjectsFromArray:[schedules objectForKey:@"exercises"]];
    
    [workoutsArrFiltered removeAllObjects];
    [exercisesArrFiltered removeAllObjects];
    [addExerciseButton setEnabled:NO];
    [addWorkoutButton setEnabled:NO];
    [self.schedulesTableView reloadData];
    [self.workoutsTableView reloadData];
    [self.exercisesTableView reloadData];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.schedulesTableView) {
        return schedulesArr.count;
    }
    if (tableView == self.workoutsTableView) {
        return workoutsArrFiltered.count;
    }
    if (tableView == self.exercisesTableView) {
        return exercisesArrFiltered.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (tableView == self.schedulesTableView) {
        cell= [tableView dequeueReusableCellWithIdentifier:@"scheduleCell"];
        NSDictionary *scheduleDic = [schedulesArr objectAtIndex:indexPath.row];
        cell.textLabel.text = [scheduleDic objectForKey:@"name"];
    }
    if (tableView == self.workoutsTableView) {
        cell= [tableView dequeueReusableCellWithIdentifier:@"workoutCell"];
        NSDictionary *workoutDic = [workoutsArrFiltered objectAtIndex:indexPath.row];
        cell.textLabel.text = [workoutDic objectForKey:@"comment"];
    }
    if (tableView == self.exercisesTableView) {
        cell= [tableView dequeueReusableCellWithIdentifier:@"exerciseCell"];
        NSDictionary *exerciseDic = [exercisesArrFiltered objectAtIndex:indexPath.row];
        NSArray *exercisesArray = [exerciseDic objectForKey:@"exercises"];
        wgerSQLiteDataSource *sqlite = [wgerSQLiteDataSource new];
        cell.textLabel.text = [[sqlite getExercisesDetail:[exercisesArray firstObject]] objectForKey:@"name"];
    }
    
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.25];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.schedulesTableView) {
        [workoutsArrFiltered removeAllObjects];
        [self.workoutsTableView reloadData];
        [exercisesArrFiltered removeAllObjects];
        [self.exercisesTableView reloadData];
        NSDictionary *scheduleDic = [schedulesArr objectAtIndex:indexPath.row];
        NSNumber *scheduleId = [scheduleDic objectForKey:@"id"];
        for (NSDictionary *scheduleStep in scheduleStepsArr) {
            if ([[scheduleStep objectForKey:@"schedule"] isEqual:scheduleId]) {
                NSNumber *workoutId = [scheduleStep objectForKey:@"workout"];
                for (NSDictionary *workout in workoutsArr) {
                    if ([[workout objectForKey:@"id"] isEqual:workoutId]) {
                        [workoutsArrFiltered addObject:workout];
                    }
                }
            }
        }
        [self.workoutsTableView reloadData];
        [addExerciseButton setEnabled:NO];
        [addWorkoutButton setEnabled:YES];
    }
    if (tableView == self.workoutsTableView) {
        [exercisesArrFiltered removeAllObjects];
        [self.exercisesTableView reloadData];
        NSDictionary *workoutDic = [workoutsArrFiltered objectAtIndex:indexPath.row];
        NSNumber *workoutId = [workoutDic objectForKey:@"id"];
        for (NSDictionary *day in daysArr) {
            if ([[day objectForKey:@"training"] isEqual:workoutId]) {
                NSNumber *dayId = [day objectForKey:@"id"];
                self.title = [day objectForKey:@"description"];
                for (NSDictionary *exercise in exercisesArr) {
                    if ([[exercise objectForKey:@"exerciseday"] isEqual:dayId]) {
                        [exercisesArrFiltered addObject:exercise];
                    }
                }
            }
        }
        [self.exercisesTableView reloadData];
        [addExerciseButton setEnabled:YES];
        [addWorkoutButton setEnabled:YES];
    }
    if (tableView == self.exercisesTableView) {
        NSDictionary *exerciseDic = [exercisesArrFiltered objectAtIndex:indexPath.row];
        NSArray *exercisesArray = [exerciseDic objectForKey:@"exercises"];
        ExerciseDetailViewController *exerDVC = [[ExerciseDetailViewController alloc] init];
        exerDVC.exerciseDic = [NSDictionary dictionaryWithObject:[exercisesArray firstObject] forKey:@"id"];
        [self.navigationController pushViewController:exerDVC animated:YES];
    }
}

@end
