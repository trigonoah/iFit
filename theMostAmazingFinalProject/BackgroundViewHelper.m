//
//  BackgroundViewHelper.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"

@implementation BackgroundViewHelper
static BackgroundViewHelper *sharedInstance = nil;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:frame];
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9];
        index=0;
        timer=nil;
        imageArray=[[NSMutableArray alloc] init];
        for (int i=0; i<=6; i++) {
            [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"workout%d",i]]];
        }
        animatedImageView=[[UIImageView alloc] initWithFrame:self.bounds];
        [animatedImageView setImage:[imageArray objectAtIndex:index]];
        overlay = [[UIView alloc] initWithFrame:animatedImageView.bounds];
        [overlay setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
        
        index++;
        [self addSubview:animatedImageView];
        [self addSubview:overlay];
    }
    return self;
}

#pragma mark
#pragma mark  Singleton Methods

+(BackgroundViewHelper *)getSharedInstance
{
    if(!sharedInstance)
    {
        sharedInstance = [[BackgroundViewHelper alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return sharedInstance;
}

-(void)start{
    [self stop];
    [self setUserInteractionEnabled:YES];
    if (![self isDescendantOfView:self.assignedView]) {
        [self.assignedView setUserInteractionEnabled:YES];
        [self.assignedView addSubview:self];
        [self.assignedView sendSubviewToBack:self];
        [self animate];
//        if (timer!=nil) {
//            [timer invalidate];
//            timer=nil;
//        }
//        [self animate];
//        timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(animate) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

-(void)stop{
    if ([self isDescendantOfView:self.assignedView]) {
        if (timer!=nil) {
            [timer invalidate];
            timer=nil;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            [self.assignedView setUserInteractionEnabled:YES];
        });
    }
}

-(void)animate{
    if (self.subviews.count > 2) {
        UIView *subview = [self.subviews firstObject];
        [subview removeFromSuperview];
        subview = nil;
    }
    UIImageView *prevImage = [[UIImageView alloc] initWithFrame:self.bounds];
    prevImage.image = animatedImageView.image;
    [self addSubview:prevImage];
    [AnimationHelper fadeOut:prevImage withDuration:0.8 andWait:0.0];
    
    index=(index<imageArray.count-1?++index:0);
    [animatedImageView setImage:[imageArray objectAtIndex:index]];
    animatedImageView.alpha = 0;
    [AnimationHelper fadeIn:prevImage withDuration:0.8 andWait:0.8];
    [self bringSubviewToFront:animatedImageView];
    [self bringSubviewToFront:overlay];
}


//- (UIViewController *)topViewController{
//    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
//}
//
//- (UIViewController *)topViewController:(UIViewController *)rootViewController
//{
//    if (rootViewController.presentedViewController == nil) {
//        return rootViewController;
//    }
//    
//    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
//        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
//        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
//        return [self topViewController:lastViewController];
//    }
//    
//    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
//    return [self topViewController:presentedViewController];
//}
@end
