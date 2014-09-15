//
//  newslooked.m
//  越野e族
//
//  Created by 史忠坤 on 14-1-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "newslooked.h"
#import "dataBase.h"

@implementation newslooked
@synthesize string_newslookedid;
-(newslooked *)initWithid:(NSString *)theid{
    
    self = [super init];
    if (self) {
        self.string_newslookedid=theid;
    }
    return self;

}

+(int)addid:(NSString *)theid {
    
    sqlite3 * db = [dataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db,"insert into newslooked(newsid) values(?)",-1, &stmt,nil);
    sqlite3_bind_text(stmt, 1,[theid UTF8String], -1, nil);
    
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return result;
    
    
    
    
    return 1;
}
+(NSMutableArray *)findbytheid:(NSString *)thelookedid{
    
    
    sqlite3 *db =[dataBase openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db,"select * from newslooked where newsid=?",-1,&stmt,nil);
    sqlite3_bind_text(stmt, 1,[thelookedid UTF8String], -1, nil);
    
    if (result == SQLITE_OK) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            
            const unsigned char * drafttype=sqlite3_column_text(stmt,0);
            
            
            
            NSString * theid;
            if (drafttype == nil)
            {
                theid = @"";
            }else {
                theid = [NSString stringWithUTF8String:(const char *)drafttype];
            }
            
            newslooked *_looked=[[newslooked alloc]initWithid:theid];
            [array addObject:_looked];
            
        }
        
        sqlite3_finalize(stmt);
        return array;
        
    }else {
        NSLog(@"find all failed with %d",result);
        sqlite3_finalize(stmt);
        return [NSMutableArray array];
    }
}



@end
