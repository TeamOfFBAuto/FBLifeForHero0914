//
//  DataBase.m
//  FbLife
//
//  Created by soulnear on 13-6-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "DataBase.h"
#define KBBPath @"WeiBoList.sqlite"
static sqlite3 * dbPointer = nil;

@implementation DataBase
+(sqlite3 *)openDB
{
    if (dbPointer)
    {
        return dbPointer;
    }
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * sqlFilePath = [docPath stringByAppendingPathComponent:KBBPath];
    NSString * originFilePath = [[NSBundle mainBundle] pathForResource:@"WeiBoList.sqlite" ofType:nil];
    
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
        
        FMResultSet *rs = [db executeQuery:@"select * from sqlite_master where tbl_name = 'all'"];
        if(![rs next])
        {
            BOOL isSuccess = [db executeUpdate:
                              @"CREATE TABLE IF NOT EXISTS newcontent(tid TEXT PRIMARY KEY,uid TEXT,username TEXT,content TEXT,imageOriginal TEXT,imageSmall TEXT,froms TEXT,type TEXT,sort TEXT,sortId TEXT,jingLng TEXT,weiLat TEXT,locality TEXT,faceOriginal TEXT,faceSmall TEXT,rootFlg TEXT,imageFlg TEXT,dateLine TEXT,replys TEXT,forwards TEXT,ruid TEXT,rtid TEXT,rusername TEXT,rcontent TEXT,rimageOriginal TEXT,rimageSmall TEXT,rfroms TEXT,rtype TEXT,rsort TEXT,rsortId TEXT,rjingLng TEXT,rweiLat TEXT,rlocality TEXT,rfaceOriginal TEXT,rfaceSmall TEXT,rrootFlg TEXT,rimageFlg TEXT,rdateLine TEXT,rreplys TEXT,rforwards TEXT,WeiBoType TEXT,imageOriginalM TEXT,imageSmallM TEXT,rimageOriginalM TEXT,rimageSmallM TEXT,aid TEXT,raid TEXT,titleContent TEXT,musicurl TEXT,olink TEXT,rtitleContent TEXT,rmusicurl TEXT,rolink TEXT,photoTitle TEXT)"];
            
            
            
            NSLog(@"数据库添加数据成功 -------  %d",isSuccess);
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
