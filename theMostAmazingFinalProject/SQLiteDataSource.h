//
//  SQLiteDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface SQLiteDataSource : NSObject
{
    NSString *dbPath;
    NSDateFormatter *insertDateTimeFormatter;
}

-(id)executeQuery:(NSString *)query;
-(id)executeSingleSelect:(NSString *)tableName andColumnNames:(NSArray *)columnNames andFilter:(NSDictionary *)filterData andLimit:(int)limit;
-(BOOL)executeInsertOperation:(NSString *)tableName andData:(NSDictionary *)insertData;
-(BOOL)executeUpdateOperation:(NSString *)tableName andData:(NSDictionary *)updateData andFilter:(NSDictionary *)filterData;
-(BOOL)executeDeleteOperation:(NSString *)tableName andFilter:(NSDictionary *)filter;


@end
