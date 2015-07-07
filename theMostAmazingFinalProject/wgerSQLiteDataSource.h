//
//  wgerSQLiteDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "SQLiteDataSource.h"

@interface wgerSQLiteDataSource : SQLiteDataSource

-(void)insertAllNewCategories:(NSArray *)categories;
-(void)insertAllNewEquipments:(NSArray *)equipments;
-(void)insertAllNewMuscles:(NSArray *)muscles;
-(void)insertAllNewExercises:(NSArray *)exercises;
-(void)insertMuscles:(NSArray *)muscles ForExercise:(int)exercise;
-(void)insertEquipments:(NSArray *)equipments ForExercise:(int)exercise;
-(void)insertAllNewImages:(NSArray *)images;

-(NSArray *)getMuscles;
-(NSArray *)getExercisesForMuscle:(NSNumber *)muscleId;
-(NSDictionary *)getExercisesDetail:(NSNumber *)exerciseId;
-(NSArray *)getAllExercises;

@end
