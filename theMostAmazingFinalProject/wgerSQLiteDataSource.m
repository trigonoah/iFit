//
//  wgerSQLiteDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "wgerSQLiteDataSource.h"

@implementation wgerSQLiteDataSource

-(void)insertAllNewCategories:(NSArray *)categories{
    for (NSDictionary *category in categories) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_category_catalog WHERE id = %d", [[category objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_category_catalog" andData:category];
        }
    }
}

-(void)insertAllNewEquipments:(NSArray *)equipments{
    for (NSDictionary *equipment in equipments) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_equipment_catalog WHERE id = %d", [[equipment objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_equipment_catalog" andData:equipment];
        }
    }
}

-(void)insertAllNewMuscles:(NSArray *)muscles{
    for (NSDictionary *muscle in muscles) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_muscle_catalog WHERE id = %d", [[muscle objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_muscle_catalog" andData:muscle];
        }
    }
}


-(void)insertAllNewExercises:(NSArray *)exercises{
    for (NSDictionary *exercise in exercises) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_exercise_catalog WHERE id = %d", [[exercise objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_exercise_catalog" andData:exercise];
        }
    }
}

-(void)insertMuscles:(NSArray *)muscles ForExercise:(int)exercise{
    for (NSNumber *muscle in muscles) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id_muscle FROM wger_exercise_muscle WHERE id_muscle = %d AND id_exercise = %d", [muscle intValue], exercise]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_exercise_muscle" andData:[NSDictionary dictionaryWithObjects:@[muscle, [NSNumber numberWithInt:exercise]] forKeys:@[@"id_muscle", @"id_exercise"]]];
        }
    }
}

-(void)insertEquipments:(NSArray *)equipments ForExercise:(int)exercise {
    for (NSNumber *equipment in equipments) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id_equipment FROM wger_exercise_equipment WHERE id_equipment = %d AND id_exercise = %d", [equipment intValue], exercise]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_exercise_equipment" andData:[NSDictionary dictionaryWithObjects:@[equipment, [NSNumber numberWithInt:exercise]] forKeys:@[@"id_equipment", @"id_exercise"]]];
        }
    }
}

-(void)insertAllNewImages:(NSArray *)images{
    for (NSDictionary *image in images) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_image_exercise WHERE id = %d", [[image objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_image_exercise" andData:image];
        }
    }
}

-(NSArray *)getMuscles{
    return [self executeQuery:@"SELECT * FROM wger_muscle_catalog"];
}

-(NSArray *)getExercisesForMuscle:(NSNumber *)muscleId{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSArray *exercises = [self executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT exmus.id_exercise FROM wger_exercise_muscle exmus WHERE exmus.id_muscle = %d;",muscleId.intValue]];
    
    NSMutableArray *objects = [NSMutableArray new];
    for (NSDictionary *exercise in exercises) {
        NSArray *others = [self executeQuery:[NSString stringWithFormat:@"SELECT id, name FROM wger_exercise_catalog WHERE id = %d AND language = 2;",[[exercise objectForKey:@"id_exercise"] intValue]]];
        if (others.count > 0) {
            [objects addObject:[others firstObject]];
        }
    }
    
    
    for (NSDictionary *dic in objects) {
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        NSArray *images = [self executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT image FROM wger_image_exercise WHERE exercise = %d LIMIT 1;",[[mutableDic objectForKey:@"id"] intValue]]];
        if (images.count > 0) {
            [mutableDic setObject:[[images firstObject] objectForKey:@"image"]  forKey:@"image"];
        } else {
            [mutableDic setObject:@""  forKey:@"image"];
        }
        [returnArray addObject:mutableDic];
    }
    
    return returnArray;
}

-(NSDictionary *)getExercisesDetail:(NSNumber *)exerciseId{
    NSMutableDictionary *returnDic = [NSMutableDictionary new];
    [returnDic addEntriesFromDictionary:[[self executeQuery:[NSString stringWithFormat:@"SELECT ex.name, ex.description FROM wger_exercise_catalog ex WHERE ex.id = %d",exerciseId.intValue]] firstObject]];
    NSArray *imageArray = [self executeQuery:[NSString stringWithFormat:@"SELECT im.image FROM wger_image_exercise im WHERE im.exercise = %d", exerciseId.intValue]];
    NSArray *equipmentArray = [self executeQuery:[NSString stringWithFormat:@"SELECT eq.name FROM wger_equipment_catalog eq WHERE id = (SELECT DISTINCT  ex.id_equipment FROM  wger_exercise_equipment ex WHERE ex.id_exercise = %d)", exerciseId.intValue]];
    [returnDic setObject:imageArray forKey:@"images"];
    [returnDic setObject:equipmentArray forKey:@"equipment"];
    
    return returnDic;
}

-(NSArray *)getAllExercises{
    return [self executeQuery:@"SELECT * FROM wger_exercise_catalog WHERE language = 2"];
}

@end
