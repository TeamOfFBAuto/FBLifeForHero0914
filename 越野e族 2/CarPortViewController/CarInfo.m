//
//  CarInfo.m
//  FbLife
//
//  Created by soulnear on 13-9-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "CarInfo.h"
#import "DataBase1.h"

@implementation CarInfo
@synthesize brandname = _brandname;
@synthesize brandphoto = _brandphoto;
@synthesize brandword = _brandword;
@synthesize brandfwords = _brandfwords;
@synthesize serieslist = _serieslist;
@synthesize type = _type;




-(CarInfo *)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    
    if (self)
    {
        self.brandname = [NSString stringWithFormat:@"%@",[dic objectForKey:@"brandname"]];
        self.brandphoto = [NSString stringWithFormat:@"%@",[dic objectForKey:@"brandphoto"]];
        self.brandword = [NSString stringWithFormat:@"%@",[dic objectForKey:@"brandword"]];
        
        self.serieslist = [[NSMutableArray alloc] init];
        @try
        {
            NSMutableArray * temp_array = [dic objectForKey:@"serieslist"];
                        
            for (NSDictionary * dic1 in temp_array)
            {
                CarType * type = [[CarType alloc] initWithDictionary:dic1];
                
                [self.serieslist addObject:type];
            }
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
                
        }
    }
    
    return self;
}





//////////////////////////////////////////////////////数据库


+(NSMutableArray *)findAll
{
    sqlite3 * db = [DataBase1 openDB];
    sqlite3_stmt * stmt = nil;
    int result = sqlite3_prepare_v2(db,"select * from allcars", -1,&stmt,nil);    
    if (result == SQLITE_OK)
    {
        NSMutableArray * perArray = [[NSMutableArray alloc] init];
        
        while (SQLITE_ROW == sqlite3_step(stmt))
        {
            const unsigned char * name = sqlite3_column_text(stmt,0);
            const unsigned char * word = sqlite3_column_text(stmt,1);
            const unsigned char * photo = sqlite3_column_text(stmt,2);
            const unsigned char * fwords = sqlite3_column_text(stmt,3);            
            
            CarInfo * per = [[CarInfo alloc] init];            
            
            per.brandname= name?[NSString stringWithUTF8String:(const char *)name]:@"";
            per.brandword = word?[NSString stringWithUTF8String:(const char *)word]:@"";
            per.brandphoto = photo?[NSString stringWithUTF8String:(const char *)photo]:@"";
            per.brandfwords = fwords?[NSString stringWithUTF8String:(const char *)fwords]:@"";
            
            [perArray addObject:per];
        }
        sqlite3_finalize(stmt);
        return perArray;
    }else
    {
        return [NSMutableArray array];
    }
}

+(int)addWeiBoContentWithCarInfo:(CarInfo *)info//Name:(NSString *)theName WithPhoto:(NSString *)thePhoto WithWord:(NSString *)theWord WithFwords:(NSString *)theFwords
{
    sqlite3 * db = [DataBase1 openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db,"insert into allcars(name,word,photo,fwords) values(?,?,?,?)", -1,&stmt,nil);
    
    sqlite3_bind_text(stmt,1,[info.brandname UTF8String],-1,nil);
    sqlite3_bind_text(stmt,2,[info.brandword UTF8String],-1,nil);
    sqlite3_bind_text(stmt,3,[info.brandphoto UTF8String],-1,nil);
    sqlite3_bind_text(stmt,4,[info.brandfwords UTF8String],-1,nil);
    
    
    //    sqlite3_bind_int(stmt,2,thePage);
    
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return  result;
    
}

+(int)deleteAll
{
    sqlite3 * db = [DataBase1 openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db, "delete from allcars", -1, &stmt, nil);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return result;
}




@end
