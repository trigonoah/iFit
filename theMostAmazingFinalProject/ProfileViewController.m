//
//  ViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ProfileViewController.h"
#import "BackgroundViewHelper.h"
#import "LoginViewController.h"
#import "KeychainHelper.h"
#import "LoginViewController.h"
#import "RunKeeperProfile.h"
#import "ImageHelper.h"

@interface ProfileViewController () <RunKeeperDataSourceDelegate>

@property(strong,nonatomic) RunKeeperDataSource *runKeeperDataSource;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfilePicture;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblBirthday;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;

@end


@implementation ProfileViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Profile";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.lblBirthday.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.lblLocation.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.lblName.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (![KeychainHelper getToken]) {
        LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self presentViewController:lvc animated:YES completion:nil];
    } else {
        self.runKeeperDataSource = [RunKeeperDataSource new];
        self.runKeeperDataSource.delegate = self;
        
        [self.runKeeperDataSource getProfile];
    }
}

#pragma mark - RunKeeper delegate methods
-(void)returnRunKeeperProfile:(RunKeeperProfile *)rkProfile
{
    self.lblBirthday.text = rkProfile.strBirthday;
    self.lblLocation.text = rkProfile.strLocation;
    self.lblName.text = rkProfile.strName;
    
    [ImageHelper setImage:self.imgProfilePicture FromPath:rkProfile.strNormalPicture];
}

@end
