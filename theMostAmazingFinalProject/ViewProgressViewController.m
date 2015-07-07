//
//  ViewProgressViewController.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ViewProgressViewController.h"
#import "BackgroundViewHelper.h"
#import <ShinobiCharts/ShinobiCharts.h>
#import "RunKeeperDataSource.h"


enum{
    SC_DISTANCE = 0,
    SC_DURATION = 1,
    SC_CALORIES = 2,
};

@interface ViewProgressViewController () <SChartDatasource, RunKeeperDataSourceDelegate>

@property (strong, nonatomic) NSArray * arrFitnessActivies;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segcntrSelection;
@property (strong, nonatomic) NSMutableArray * arrDataToLoad;

@end

@implementation ViewProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.arrDataToLoad = [[NSMutableArray alloc] init];
    
    self.segcntrSelection.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    RunKeeperDataSource *rkds = [[RunKeeperDataSource alloc] init];
    rkds.delegate = self;
    [rkds getFitnessActivities];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

#pragma mark - Helper methods
-(void)configureChart
{
    //Initialize the chart
    ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(30, self.segcntrSelection.frame.origin.y+self.segcntrSelection.frame.size.height+30, self.view.frame.size.width-60, 450)];   //instantiate the chart
    chart.title = @"Daily activity"; //set the chart title
    
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    //Set the trial license key
    chart.licenseKey = @"g3MoJO2p3emjyUgMjAxNTA3MDVzYW11ZWxoZmFuZmFuQGdtYWlsLmNvbQ==YNbe1JymsrRXQHbWBBX2Hfpre5wPdzUE2aPmUUQp0UoIYs7I0iIxyBXogzGTHGQUIn8WYYdL2p2McXccQZcg6aPn8+rT2tjl9hWGfukYGoebFz5eSwFz+jKqO+0DAWD480cpTqb+xxa7/17g/kyg+Gdlk0WU=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";
    
    //Add axes to the chart
    SChartNumberAxis *xAxis = [SChartNumberAxis new];
    xAxis.title = @"Datapoint";
    chart.xAxis = xAxis;    //set the chart's x axis
    
    SChartNumberAxis *yAxis = [SChartNumberAxis new];
    
    if (self.segcntrSelection.selectedSegmentIndex == SC_DISTANCE)
    {
        yAxis.title = @"Distance (meters)";
    }
    else if (self.segcntrSelection.selectedSegmentIndex == SC_DURATION)
    {
        yAxis.title = @"Time (minutes)";
    }
    if (self.segcntrSelection.selectedSegmentIndex == SC_CALORIES)
    {
        yAxis.title = @"Calories burned";
    }
    
    yAxis.rangePaddingLow = @(0.1);     //?
    yAxis.rangePaddingHigh = @(0.1);    //?
    chart.yAxis = yAxis;    //set the charts' y axis
    
    // enable gestures
    yAxis.enableGesturePanning = YES;
    yAxis.enableGestureZooming = YES;
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;
    
    //Set the legend for iPad
    chart.legend.hidden = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    
    //Set the datasource
    chart.datasource = self;
    chart.tag = 1;
    
    //Add the chart to the view
    [self.view addSubview:chart];
}

-(void)reloadChart
{
    //Remove the chart from the view if it exists
    if ([self.view viewWithTag:1])
    {
        [[self.view viewWithTag:1] removeFromSuperview];
   
    }
    
    //Configure the chart
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configureChart];
    });
}

#pragma mark - Segment control method
- (IBAction)segcntrSelectionValueChanged:(id)sender
{
    if (self.segcntrSelection.selectedSegmentIndex == SC_DISTANCE)
    {
        //Load chart with distance data
        [self.arrDataToLoad removeAllObjects];
        for (FitnessActivity *anActivity in self.arrFitnessActivies)
        {
            [self.arrDataToLoad addObject:[NSNumber numberWithFloat:[anActivity.strTotalDistance floatValue]]];
        }

        //Reload the chart upon completion
        [self reloadChart];
    }
    else if (self.segcntrSelection.selectedSegmentIndex == SC_DURATION)
    {
        //Load chart with duration data
        [self.arrDataToLoad removeAllObjects];
        for (FitnessActivity *anActivity in self.arrFitnessActivies)
        {
            [self.arrDataToLoad addObject:[NSNumber numberWithFloat:([anActivity.strDuration floatValue] *60)]];    //value in minutes
        }
        
        //Reload the chart upon completion
        [self reloadChart];
    }
    else if (self.segcntrSelection.selectedSegmentIndex == SC_CALORIES)
    {
        //Load chart with calorie data
        [self.arrDataToLoad removeAllObjects];
        for (FitnessActivity *anActivity in self.arrFitnessActivies)
        {
            [self.arrDataToLoad addObject:[NSNumber numberWithFloat:[anActivity.strTotalCalories floatValue]]];
        }
        
        //Reload the chart upon completion
        [self reloadChart];
    }
}

#pragma mark - RunKeeper delegate methods
-(void)returnFitnessActivities:(NSArray*)arrFitnessActivities
{
    self.arrFitnessActivies = [[NSArray alloc] initWithArray:arrFitnessActivities];
    
    //Load chart with distance data
    [self.arrDataToLoad removeAllObjects];
    for (FitnessActivity *anActivity in self.arrFitnessActivies)
    {
        [self.arrDataToLoad addObject:[NSNumber numberWithFloat:[anActivity.strTotalDistance floatValue]]];
    }
    [self reloadChart];
}


#pragma mark - Shinobi Charts datasource methods
- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1; //number of seperate lines to be represented in the chart
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    SChartLineSeries *lineSeries = [SChartLineSeries new];
    
    lineSeries.selectionMode = SChartSelectionPoint;
    
    lineSeries.animationEnabled = YES;
    
    SChartLineSeriesStyle *style = [SChartLineSeriesStyle new];
    style.pointStyle = [SChartPointStyle new];
    style.pointStyle.showPoints = YES;
    style.pointStyle.radius = @(5);
    
    style.selectedPointStyle = [SChartPointStyle new];
    style.selectedPointStyle.showPoints = YES;
    style.selectedPointStyle.color = [UIColor orangeColor];
    style.selectedPointStyle.radius = @(15);
    
    style.showFill = YES;
    
    SChartAnimation *animation = [SChartAnimation fadeAnimation];
    
    if (self.segcntrSelection.selectedSegmentIndex == SC_DURATION)
    {
        lineSeries.title = @"Duration Spent";
        style.lineColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        animation = [SChartAnimation televisionAnimation];
    }
    else if (self.segcntrSelection.selectedSegmentIndex == SC_DISTANCE)
    {
        lineSeries.title = @"Distance Traveled";
        style.lineColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
        animation = [SChartAnimation growAnimation];
    }
    else if (self.segcntrSelection.selectedSegmentIndex == SC_CALORIES)
    {
        lineSeries.title = @"Calories Burned";
        style.lineColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
        animation = [SChartAnimation fadeAnimation];
    }

    lineSeries.entryAnimation = animation;
    [lineSeries setStyle:style];
    
    return lineSeries;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    return self.arrFitnessActivies.count; //Self explanitory
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    SChartDataPoint *datapoint = [SChartDataPoint new];
    
    // compute x-values for series
    double xValue = dataIndex;
    datapoint.xValue = [NSNumber numberWithDouble:xValue];
    
    // compute the y-values for series
    datapoint.yValue = [self.arrDataToLoad objectAtIndex:dataIndex];
    
    return datapoint;
}

@end
