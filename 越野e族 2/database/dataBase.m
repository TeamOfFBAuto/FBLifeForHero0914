//
//  dataBase.m
//  QQ
//
//  Created by ibokan1 on 12-2-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
////newsssss

#import "dataBase.h"
#define KBBPath @"recentlook.sqlite"
static sqlite3 * dbPointer = nil;

@implementation dataBase

+(sqlite3 *)openDB
{
    if (dbPointer) {
        return dbPointer;
    }
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"docpath = %@",docPath);
    NSString * sqlFilePath = [docPath stringByAppendingPathComponent:KBBPath];
    NSString * originFilePath = [[NSBundle mainBundle] pathForResource:@"recentlook.sqlite" ofType:nil];
    NSLog(@"orr=%@==sqlfilepath==%@",originFilePath,sqlFilePath);

    NSFileManager * fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:sqlFilePath]==NO) {
        NSError * error = nil;
        if ([fm copyItemAtPath:originFilePath toPath:sqlFilePath error:&error]==NO) {
            NSLog(@"创建数据库的时候出现了错误:%@",[error localizedDescription]);
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
