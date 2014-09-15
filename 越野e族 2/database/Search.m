//
//  Search.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-29.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "Search.h"
#import "dataBase.h"

@implementation Search
-(Search *)initWithname:(NSString *)bbsname bbsid:(NSString*)_bbsid{
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
    int result=sqlite3_prepare_v2(db,"select * from search ",-1,&stmt,nil);
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
            
            Search *data_=[[Search alloc]initWithname:namebbs bbsid:idbbs];
            
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
    sqlite3_prepare_v2(db,"insert into search(name,id) values(?,?)",-1, &stmt,nil);
    sqlite3_bind_text(stmt, 1,[thebbsname UTF8String], -1, nil);
    
    sqlite3_bind_text(stmt, 2,[theid UTF8String], -1, nil);
    
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return result;
}
@end
