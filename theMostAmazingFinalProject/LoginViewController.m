//
//  LoginViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "LoginViewController.h"
#import "BackgroundViewHelper.h"

@interface LoginViewController ()<UIWebViewDelegate, RunKeeperDataSourceDelegate>
@property(strong,nonatomic) RunKeeperDataSource *runKeeperDataSource;
@property (strong, nonatomic) IBOutlet UIWebView *wvWebView;

@end

static NSString * const AUTH_REQUEST_URL = @"https://runkeeper.com/apps/authorize?response_type=code&client_id=21d211d3e8d04362bf4056eca118cca6&redirect_uri=http%3A%2F%2Fwww.google.com";


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.runKeeperDataSource = [RunKeeperDataSource new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    //Comment out to disable RunKeeper authorization page from showing
    [self.wvWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:AUTH_REQUEST_URL]]];
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

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *responseURL = [NSString stringWithString:webView.request.URL.absoluteString];
    
    //Check if the string contains the keyword 'code'
    if ([responseURL containsString:@"code="])
    {
        //Code srting exists. Parse it
        
        NSString *haystack = [responseURL copy];
        NSString *prefix = @"https://www.google.com/?code=";
        NSString *suffix = @"&gws_rd=ssl";
        
        NSRange needleRange = NSMakeRange(prefix.length, haystack.length - prefix.length - suffix.length);
        
        NSString *code = [haystack substringWithRange:needleRange];
        self.runKeeperDataSource.delegate = self;
        [self.runKeeperDataSource getToken:code];
        //        [self.runKeeperDataSource getFitnessActivities];
        //        [self.runKeeperDataSource getUser];
//        [self.runKeeperDataSource getProfile];
        
        [webView removeFromSuperview];
    }
}

-(void)tokenObtained{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
