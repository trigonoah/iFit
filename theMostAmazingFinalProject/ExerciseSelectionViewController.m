//
//  ExerciseSelectionViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ExerciseSelectionViewController.h"
#import "BackgroundViewHelper.h"
#import "wgerSQLiteDataSource.h"
#import "ExerciseTableViewCell.h"
#import "ExerciseDetailViewController.h"

@interface ExerciseSelectionViewController ()

@end

@implementation ExerciseSelectionViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Exercise Selection";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    wgerSQLiteDataSource *dataSource = [wgerSQLiteDataSource new];
    exercises = [[NSMutableArray alloc] initWithArray:[dataSource getExercisesForMuscle:[self.muscleDic objectForKey:@"id"]]];
    [exerciseTableView registerNib:[UINib nibWithNibName:@"ExerciseTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableView DataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return exercises.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    NSDictionary *exerciseDic = [exercises objectAtIndex:indexPath.row];
    ExerciseTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setupCellWithData:exerciseDic];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135.0;
}

#pragma mark - UITableView Delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *exerciseDic = [exercises objectAtIndex:indexPath.row];
    ExerciseDetailViewController *exerDVC = [[ExerciseDetailViewController alloc] init];
    exerDVC.exerciseDic = exerciseDic;
    [self.navigationController pushViewController:exerDVC animated:YES];
}


@end
