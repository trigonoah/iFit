//
//  ExerciseDetailViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ExerciseDetailViewController.h"
#import "wgerSQLiteDataSource.h"
#import "BackgroundViewHelper.h"
#import "ImageHelper.h"

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Exercise Detail";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    wgerSQLiteDataSource *dataSource = [wgerSQLiteDataSource new];
    exerciseDetail = [dataSource getExercisesDetail:[self.exerciseDic objectForKey:@"id"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
    [self setupView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setupView{
    scrollView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.25];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setNumberOfLines:3];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setText:[exerciseDetail objectForKey:@"name"]];
    [nameLabel setTextColor:[UIColor blueColor]];
    [nameLabel setFont:[UIFont fontWithName:@"Arial" size:30]];
    [scrollView addSubview: nameLabel];
    
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, nameLabel.frame.origin.y+nameLabel.frame.size.height+20, nameLabel.frame.size.width-40, 0)];
    [descriptionLabel setText:[exerciseDetail objectForKey:@"description"]];
    [descriptionLabel setTextColor:[UIColor blueColor]];
    [descriptionLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
    [descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [descriptionLabel setNumberOfLines:0];
    [descriptionLabel sizeToFit];
    [scrollView addSubview: descriptionLabel];
    
    [scrollView setContentSize:CGSizeMake(nameLabel.frame.size.width, descriptionLabel.frame.origin.y+descriptionLabel.frame.size.height+50)];
    
    if ([[exerciseDetail objectForKey:@"equipment"] count] > 0) {
        UILabel *equipmentTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, scrollView.contentSize.height, nameLabel.frame.size.width-40, 50)];
        [equipmentTitle setBackgroundColor:[UIColor clearColor]];
        [equipmentTitle setNumberOfLines:3];
        [equipmentTitle setTextAlignment:NSTextAlignmentLeft];
        [equipmentTitle setText:@"Equipment:"];
        [equipmentTitle setTextColor:[UIColor blueColor]];
        [equipmentTitle setFont:[UIFont fontWithName:@"Arial" size:25]];
        [scrollView addSubview: equipmentTitle];
        
        [scrollView setContentSize:CGSizeMake(nameLabel.frame.size.width, equipmentTitle.frame.origin.y+equipmentTitle.frame.size.height+10)];

        for (NSDictionary *equipmentDic in [exerciseDetail objectForKey:@"equipment"]) {
            UILabel *equipment = [[UILabel alloc] initWithFrame:CGRectMake(20, scrollView.contentSize.height, nameLabel.frame.size.width-40, 30)];
            [equipment setBackgroundColor:[UIColor clearColor]];
            [equipment setNumberOfLines:2];
            [equipment setTextAlignment:NSTextAlignmentLeft];
            [equipment setText:[equipmentDic objectForKey:@"name"]];
            [equipment setTextColor:[UIColor blueColor]];
            [equipment setFont:[UIFont fontWithName:@"Arial" size:18]];
            [scrollView addSubview: equipment];
            
            [scrollView setContentSize:CGSizeMake(nameLabel.frame.size.width, equipment.frame.origin.y+equipment.frame.size.height+10)];
        }
    }
    
    
    for (NSDictionary *imageDic in [exerciseDetail objectForKey:@"images"]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, scrollView.contentSize.height, nameLabel.frame.size.width-40, (1.4)*(nameLabel.frame.size.width-40))];
        [ImageHelper setImage:imageView FromPath:[imageDic objectForKey:@"image"]];
        imageView.clipsToBounds = YES;
        [imageView.layer setCornerRadius:5.0];
        [imageView setBackgroundColor:[UIColor whiteColor]];
        [scrollView addSubview: imageView];
        [scrollView setContentSize:CGSizeMake(nameLabel.frame.size.width, imageView.frame.origin.y+imageView.frame.size.height+80)];
    }
}

@end
