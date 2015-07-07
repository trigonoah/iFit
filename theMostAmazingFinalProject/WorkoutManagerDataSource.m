//
//  WorkoutManagerDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WorkoutManagerDataSource.h"
#import "wgerSQLiteDataSource.h"

@implementation WorkoutManagerDataSource

wgerSQLiteDataSource *sqliteDataSource;

enum OPERATIONS {
    GET_CATEGORIES = 1,
    GET_EQUIPMENTS = 2,
    GET_MUSCLES = 3,
    GET_EXERCISES = 4,
    GET_IMAGES = 5,
    GET_SCHEDULES = 6,
    GET_WORKOUTS = 7,
    GET_SCHEDULE_STEP = 8,
    GET_DAYS = 9,
    GET_EXERCISES_FOR_DAY = 10,
    POST_SCHEDULE = 11,
};

-(instancetype)init{
    self = [super init];
    if (self) {
        currentOperation = 0;
        attempts = 0;
        webHandler = [[WebServiceHandler alloc] initWithDelegate:self];
        sqliteDataSource = [wgerSQLiteDataSource new];
        authenticationCredentials = [NSDictionary dictionaryWithObjects:@[@"Token 821d0e09f08fd6e459f2379e041becdbdc18ab8c"] forKeys:@[@"Authorization"]];
        schedules = [NSMutableArray new];
        workouts = [NSMutableArray new];
        scheduleSteps = [NSMutableArray new];
        days = [NSMutableArray new];
        exercises = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Private methods


-(void)storeCategories:(NSDictionary *)dic{
    NSArray *categories = [dic objectForKey:@"results"];
    [sqliteDataSource insertAllNewCategories:categories];
}

-(void)storeEquipments:(NSDictionary *)dic{
    NSArray *equipments = [dic objectForKey:@"results"];
    [sqliteDataSource insertAllNewEquipments:equipments];
}

-(void)storeMuscles:(NSDictionary *)dic{
    NSArray *muscles = [dic objectForKey:@"results"];
    [sqliteDataSource insertAllNewMuscles:muscles];
}

-(void)storeExercises:(NSDictionary *)dic{
    NSArray *exercisesArr = [dic objectForKey:@"results"];
    NSMutableArray *parsedData = [NSMutableArray new];
    for (NSDictionary *aExercise in exercisesArr) {
        int identifier = [[aExercise objectForKey:@"id"] intValue];
        NSString *description = [aExercise objectForKey:@"description"];
        description = [description stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        description = [description stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        description = [description stringByReplacingOccurrencesOfString:@"'" withString:@""];
        NSArray *muscles = [aExercise objectForKey:@"muscles"];
        NSArray *equipment = [aExercise objectForKey:@"equipment"];
        [sqliteDataSource insertEquipments:equipment ForExercise:identifier];
        [sqliteDataSource insertMuscles:muscles ForExercise:identifier];
        NSMutableDictionary *exercisesDic = [[NSMutableDictionary alloc] initWithDictionary:aExercise];
        [exercisesDic removeObjectsForKeys:@[@"license", @"license_author", @"creation_date", @"muscles", @"muscles_secondary", @"equipment"]];
        [exercisesDic setObject:description forKey:@"description"];
        [parsedData addObject:exercisesDic];
    }
    
    [sqliteDataSource insertAllNewExercises:parsedData];
}

-(void)storeImages:(NSDictionary *)dic{
    NSArray *exercisesArr = [dic objectForKey:@"results"];
    NSMutableArray *parsedData = [NSMutableArray new];
    for (NSDictionary *aExercise in exercisesArr) {
        NSMutableDictionary *exercisesDic = [[NSMutableDictionary alloc] initWithDictionary:aExercise];
        [exercisesDic removeObjectsForKeys:@[@"license", @"license_author", @"status", @"is_main"]];
        [exercisesDic setObject:[NSString stringWithFormat:@"https://wger.de/media/%@",[aExercise objectForKey:@"image"]] forKey:@"image"];
        [parsedData addObject:exercisesDic];
    }
    
    [sqliteDataSource insertAllNewImages:parsedData];
}

#pragma mark - Public methods

-(void)getCatalogs{
    NSDate *lastDate = nil;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"workoutCatalogsDate"]) {
        lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"workoutCatalogsDate"];
    } else {
        lastDate = [NSDate dateWithTimeIntervalSinceNow:-86400];
        [[NSUserDefaults standardUserDefaults] setObject:lastDate forKey:@"workoutCatalogsDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lastDate];
    
    if (interval > 86400) {
        lastDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:lastDate forKey:@"workoutCatalogsDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        currentOperation = GET_CATEGORIES;
        [webHandler doRequest:@"http://wger.de/api/v2/exercisecategory/" withParameters:nil andHeaders:nil andHTTPMethod:@"GET"];
    } else {
        if (self.delegate) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate catalogsUpdated];
            });
        }
    }
}

-(void)getSchedules{
    currentOperation = GET_SCHEDULES;
    [webHandler doRequest:@"http://wger.de/api/v2/schedule/?format=json" withParameters:nil andHeaders:authenticationCredentials andHTTPMethod:@"GET"];
}

-(void)postAExerciseForWorkout:(NSDictionary *)set{
    [webHandler doRequest:@"http://wger.de/api/v2/set/" withParameters:set andHeaders:authenticationCredentials andHTTPMethod:@"POST"];
}

-(void)postASchedule:(NSDictionary *)set{
    [webHandler doRequest:@"http://wger.de/api/v2/schedule/" withParameters:set andHeaders:authenticationCredentials andHTTPMethod:@"POST"];
}

#pragma mark - WebServiceHandler delegate methods

-(void)webServiceCallFinished:(id)data{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSString *nextPage = nil;
    if (![[jsonObject objectForKey:@"next"] isKindOfClass:[NSNull class]]) {
        nextPage = [jsonObject objectForKey:@"next"];
    }
    
    switch (currentOperation) {
        case GET_CATEGORIES:
            [self storeCategories:jsonObject];
            if (!nextPage) {
                currentOperation = GET_EQUIPMENTS;
                nextPage = @"http://wger.de/api/v2/equipment/";
            }
            break;
            
        case GET_EQUIPMENTS:
            [self storeEquipments:jsonObject];
            if (!nextPage) {
                currentOperation = GET_MUSCLES;
                nextPage = @"http://wger.de/api/v2/muscle/";
            }
            break;
            
        case GET_MUSCLES:
            [self storeMuscles:jsonObject];
            if (!nextPage) {
                currentOperation = GET_EXERCISES;
                nextPage = @"http://wger.de/api/v2/exercise/";
            }
            break;
            
        case GET_EXERCISES:
            [self storeExercises:jsonObject];
            if (!nextPage) {
                currentOperation = GET_IMAGES;
                nextPage = @"http://wger.de/api/v2/exerciseimage/";
            }
            break;
            
        case GET_IMAGES:
            [self storeImages:jsonObject];
            break;
            
        case GET_SCHEDULES:
            [schedules addObjectsFromArray:(NSArray *)[jsonObject objectForKey:@"results"]];
            if (!nextPage) {
                currentOperation = GET_WORKOUTS;
                nextPage = @"http://wger.de/api/v2/workout/";
            }
            break;
            
        case GET_WORKOUTS:
            [workouts addObjectsFromArray:(NSArray *)[jsonObject objectForKey:@"results"]];
            if (!nextPage) {
                currentOperation = GET_SCHEDULE_STEP;
                nextPage = @"http://wger.de/api/v2/schedulestep/";
            }
            break;
            
        case GET_SCHEDULE_STEP:
            [scheduleSteps addObjectsFromArray:(NSArray *)[jsonObject objectForKey:@"results"]];
            if (!nextPage) {
                currentOperation = GET_DAYS;
                nextPage = @"http://wger.de/api/v2/day/";
            }
            break;
            
        case GET_DAYS:
            [days addObjectsFromArray:(NSArray *)[jsonObject objectForKey:@"results"]];
            if (!nextPage) {
                currentOperation = GET_EXERCISES_FOR_DAY;
                nextPage = @"http://wger.de/api/v2/set/";
            }
            break;
            
        case GET_EXERCISES_FOR_DAY:
            [exercises addObjectsFromArray:(NSArray *)[jsonObject objectForKey:@"results"]];
            if (!nextPage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate schedulesSyncronized:[NSDictionary dictionaryWithObjects:@[schedules, workouts, scheduleSteps, days, exercises] forKeys:@[@"schedules", @"workouts", @"scheduleSteps", @"days", @"exercises"]]];
                });
            }
            break;
            
        case POST_SCHEDULE:
            [self getSchedules];
            break;
            
        default:
            break;
    }
        
    if (nextPage) {
        [webHandler doRequest:nextPage withParameters:nil andHeaders:authenticationCredentials andHTTPMethod:@"GET"];
    } else {
        if (currentOperation == GET_IMAGES && self.delegate) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate catalogsUpdated];
            });
        }
    }

}

-(void)webServiceCallError:(NSError *)error{
    NSLog(@"Operation:%d, %@",currentOperation, error.description);
    if ([error.userInfo objectForKey:@"NSErrorFailingURLStringKey"]) {
        if (attempts < 3) {
            NSString *strURL = [error.userInfo objectForKey:@"NSErrorFailingURLStringKey"];
            [webHandler doRequest:strURL withParameters:nil andHeaders:authenticationCredentials andHTTPMethod:@"GET"];
            attempts ++;
        } else {
            if (self.delegate) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self.delegate respondsToSelector:@selector(catalogsUpdated)]) {
                        [self.delegate catalogsUpdated];
                    }
                    if ([self.delegate respondsToSelector:@selector(schedulesSyncronized:)]) {
                        [self.delegate schedulesSyncronized:@{}];
                    }
                });
            }
        }
    }
}

@end
