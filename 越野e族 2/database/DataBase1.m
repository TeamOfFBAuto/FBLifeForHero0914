//
//  DataBase.m
//  FbLife
//
//  Created by soulnear on 13-6-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "DataBase1.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


#define KBBPath @"WeiBoList.sqlite"
static sqlite3 * dbPointer = nil;

@implementation DataBase1
+(sqlite3 *)openDB
{
    if (dbPointer) {
        return dbPointer;
    }
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"docpath = %@",docPath);
    NSString * sqlFilePath = [docPath stringByAppendingPathComponent:KBBPath];
    NSString * originFilePath = [[NSBundle mainBundle] pathForResource:@"WeiBoList.sqlite" ofType:nil];
    NSLog(@"orr=%@==sqlfilepath==%@",originFilePath,sqlFilePath);
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:sqlFilePath]==NO)
    {
        NSError * error = nil;
        if ([fm copyItemAtPath:originFilePath toPath:sqlFilePath error:&error]==NO)
        {
            NSLog(@"创建数据库的时候出现了错误:%@",[error localizedDescription]);
        }
    }else
    {
        
        FMDatabase* db = [FMDatabase databaseWithPath:sqlFilePath];
        
        [db open];
        
        NSLog(@"----------%d",[db open]);
        
        FMResultSet *rs = [db executeQuery:@"select * from sqlite_master where tbl_name = 'all'"];
        if(![rs next])
        {
//            BOOL isSuccess = [db executeUpdate:
//                              @"CREATE TABLE IF NOT EXISTS all ("
//                              "SettingName TEXT NOT NULL DEFAULT NULL PRIMARY KEY,"
//                              "SettingValue TEXT Not NULL DEFAULT NULL)"
//                              ];
            
            BOOL isSuccess = [db executeUpdate:
                              @"CREATE TABLE IF NOT EXISTS allcars (name TEXT NOT NULL DEFAULT NULL PRIMARY KEY,word TEXT Not NULL DEFAULT NULL,photo TEXT Not NULL DEFAULT NULL,fwords TEXT Not NULL DEFAULT NULL)"];
            
            NSLog(@"made -------  %d",isSuccess);
		}
    }
    
    sqlite3_open([sqlFilePath UTF8String], &dbPointer);
    return dbPointer;
}
+(void)closeDB
{
    if (dbPointer) {
        sqlite3_close(dbPointer);
        dbPointer = nil;
    }
}

@end
