//
//  collectdatabase.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "collectdatabase.h"
#import "dataBase.h"
@implementation collectdatabase
@synthesize name=_name,id_ofbbs=_id_ofbbs;
-(collectdatabase *)initWithname:(NSString *)bbsname bbsid:(NSString*)_bbsid{
    self = [super init];
    if (self) {
        self.name=bbsname;
        self.id_ofbbs=_bbsid;
    }
    return self;
    
}
+(NSMutableArray *)findall{
    sqlite3 *db =[dataBase openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db,"select * from collect ",-1,&stmt,nil);
    if (result == SQLITE_OK) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            
            const unsigned char * userproductname=sqlite3_column_text(stmt,0);
            const unsigned char * userproductid=sqlite3_column_text(stmt,1);
            
            NSString * namebbs;
            if (userproductname == nil)
            {
                namebbs = @"";
            }else {
                namebbs = [NSString stringWithUTF8String:(const char *)userproductname];
            }
            
            NSString * idbbs;
            if (userproductid == nil)
            {
                idbbs = @"";
            }else {
                idbbs = [NSString stringWithUTF8String:(const char *)userproductid];
            }
            
            collectdatabase *data_=[[collectdatabase alloc]initWithname:namebbs bbsid:idbbs];
            
            [array addObject:data_];
            
        }
        
        sqlite3_finalize(stmt);
        return array;
        
    }else {
        NSLog(@"find all failed with %d",result);
        sqlite3_finalize(stmt);
        return [NSMutableArray array];
    }
    
}
+(int)addbbsname:(NSString *)thebbsname  id:(NSString *)theid
{
    NSLog(@"name=%@==id=%@",thebbsname,theid);
    sqlite3 * db = [dataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db,"insert into collect(name,id) values(?,?)",-1, &stmt,nil);
    sqlite3_bind_text(stmt, 1,[thebbsname UTF8String], -1, nil);
    
    sqlite3_bind_text(stmt, 2,[theid UTF8String], -1, nil);
    
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return result;
}

+(int) deleteStudentByID:(NSString *) theID
{
	//打开数据库
	sqlite3 *db = [dataBase openDB];
	
	sqlite3_stmt *stmt = nil;
	sqlite3_prepare_v2(db, "delete from collect where id=?", -1, &stmt, nil);
    sqlite3_bind_text(stmt, 1,[theID UTF8String], -1, nil);
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
}

@end
