//
//  DraftDatabase.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-18.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "DraftDatabase.h"
#import "dataBase.h"

@implementation DraftDatabase
@synthesize type,content,date,huifubbsid,fabiaogid,username,weiboid;
@synthesize huifubbsfid;
@synthesize title;
@synthesize columns;
@synthesize image;

-(DraftDatabase *)initWithtype:(NSString *)_type thecontent:(NSString*)_content thedate:(NSString*)_date thehuifubbsid:(NSString*)_bbsid thefabiaoid:(NSString*)_fabiaoid theweiboid:(NSString*)_weiboid theusername:(NSString*)_username thehuifubbsfid:(NSString*)_fid thetitle:(NSString*)_title columns:(NSString *)_columns image:(NSString *)_image
{
    self = [super init];
    if (self) {
        self.type=_type;
        self.content=_content;
        self.date=_date;
        self.huifubbsid=_bbsid;
        self.fabiaogid=_fabiaoid;
        self.weiboid=_weiboid;
        self.username=_username;
        self.huifubbsfid=_fid;
        self.title=_title;
        self.columns = _columns;
        self.image = _image;
        
    }
    return self;

    
}    
+(NSMutableArray *)findallbytheColumns:(NSString *)type
{
    sqlite3 *db =[dataBase openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db,"select * from DraftBox where columns=? order by date desc",-1,&stmt,nil);
    sqlite3_bind_text(stmt, 1,[type UTF8String], -1, nil);

    if (result == SQLITE_OK) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            
            const unsigned char * drafttype=sqlite3_column_text(stmt,0);
            const unsigned char * draftcontent=sqlite3_column_text(stmt,1);
            const unsigned char * draftdate=sqlite3_column_text(stmt,2);
            const unsigned char * drafthuifubbsid=sqlite3_column_text(stmt,3);
            const unsigned char * draftfabiaogid=sqlite3_column_text(stmt,4);
            const unsigned char * draftusername=sqlite3_column_text(stmt,5);
            const unsigned char * draftweiboid=sqlite3_column_text(stmt,6);
            const unsigned char * drafthuifubbsfid=sqlite3_column_text(stmt,7);
            const unsigned char * drafttitle=sqlite3_column_text(stmt,8);
            const unsigned char * drafcolumns=sqlite3_column_text(stmt,9);
            const unsigned char * drafimage=sqlite3_column_text(stmt,10);
            


            NSString * thetype;
            if (drafttype == nil)
            {
                thetype = @"";
            }else {
                thetype = [NSString stringWithUTF8String:(const char *)drafttype];
            }
            
            NSString * thecontent;
            if (draftcontent == nil)
            {
                thecontent = @"";
            }else {
                thecontent = [NSString stringWithUTF8String:(const char *)draftcontent];
            }

            NSString * thedate;
            if (draftdate == nil)
            {
                thedate = @"";
            }else {
                thedate = [NSString stringWithUTF8String:(const char *)draftdate];
            }

            NSString * thehuifubbsid;
            if (drafthuifubbsid == nil)
            {
                thehuifubbsid = @"";
            }else {
                thehuifubbsid = [NSString stringWithUTF8String:(const char *)drafthuifubbsid];
            }

            NSString * thefabiaogid;
            if (draftfabiaogid == nil)
            {
                thefabiaogid = @"";
            }else {
                thefabiaogid = [NSString stringWithUTF8String:(const char *)draftfabiaogid];
            }

            NSString * theusername;
            if (draftusername == nil)
            {
                theusername = @"";
            }else {
                theusername = [NSString stringWithUTF8String:(const char *)draftusername];
            }

            NSString * theweiboid;
            if (draftweiboid == nil)
            {
                theweiboid = @"";
            }else {
                theweiboid = [NSString stringWithUTF8String:(const char *)draftweiboid];
            }
            
            NSString * thehuifubbsfid;
            if (drafthuifubbsfid == nil)
            {
                thehuifubbsfid = @"";
            }else {
                thehuifubbsfid = [NSString stringWithUTF8String:(const char *)drafthuifubbsfid];
            }
            
            NSString * thetitle;
            if (drafttitle == nil)
            {
                thetitle = @"";
            }else {
                thetitle = [NSString stringWithUTF8String:(const char *)drafttitle];
            }
            
            NSString * thecolumns;
            if (drafcolumns == nil)
            {
                thecolumns = @"";
            }else {
                thecolumns = [NSString stringWithUTF8String:(const char *)drafcolumns];
            }
            
            NSString * theimage;
            if (drafimage == nil)
            {
                theimage = @"";
            }else {
                theimage = [NSString stringWithUTF8String:(const char *)drafimage];
            }

         
             DraftDatabase *data_=[[DraftDatabase alloc]initWithtype:thetype thecontent:thecontent thedate:thedate thehuifubbsid:thehuifubbsid thefabiaoid:thefabiaogid theweiboid:theweiboid theusername:theusername thehuifubbsfid:thehuifubbsfid thetitle:thetitle columns:thecolumns image:theimage];
            
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
+(NSMutableArray *)findalldata
{
    
    sqlite3 *db =[dataBase openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db,"select * from DraftBox order by date desc",-1,&stmt,nil);
//    sqlite3_bind_text(stmt, 1,[type UTF8String], -1, nil);
    
    if (result == SQLITE_OK) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            
            const unsigned char * drafttype=sqlite3_column_text(stmt,0);
            const unsigned char * draftcontent=sqlite3_column_text(stmt,1);
            const unsigned char * draftdate=sqlite3_column_text(stmt,2);
            const unsigned char * drafthuifubbsid=sqlite3_column_text(stmt,3);
            const unsigned char * draftfabiaogid=sqlite3_column_text(stmt,4);
            const unsigned char * draftusername=sqlite3_column_text(stmt,5);
            const unsigned char * draftweiboid=sqlite3_column_text(stmt,6);
            const unsigned char * drafthuifubbsfid=sqlite3_column_text(stmt,7);
            const unsigned char * drafttitle=sqlite3_column_text(stmt,8);
            const unsigned char * drafcolumns=sqlite3_column_text(stmt,9);
            const unsigned char * drafimage=sqlite3_column_text(stmt,10);
            
            
            
            NSString * thetype;
            if (drafttype == nil)
            {
                thetype = @"";
            }else {
                thetype = [NSString stringWithUTF8String:(const char *)drafttype];
            }
            
            NSString * thecontent;
            if (draftcontent == nil)
            {
                thecontent = @"";
            }else {
                thecontent = [NSString stringWithUTF8String:(const char *)draftcontent];
            }
            
            NSString * thedate;
            if (draftdate == nil)
            {
                thedate = @"";
            }else {
                thedate = [NSString stringWithUTF8String:(const char *)draftdate];
            }
            
            NSString * thehuifubbsid;
            if (drafthuifubbsid == nil)
            {
                thehuifubbsid = @"";
            }else {
                thehuifubbsid = [NSString stringWithUTF8String:(const char *)drafthuifubbsid];
            }
            
            NSString * thefabiaogid;
            if (draftfabiaogid == nil)
            {
                thefabiaogid = @"";
            }else {
                thefabiaogid = [NSString stringWithUTF8String:(const char *)draftfabiaogid];
            }
            
            NSString * theusername;
            if (draftusername == nil)
            {
                theusername = @"";
            }else {
                theusername = [NSString stringWithUTF8String:(const char *)draftusername];
            }
            
            NSString * theweiboid;
            if (draftweiboid == nil)
            {
                theweiboid = @"";
            }else {
                theweiboid = [NSString stringWithUTF8String:(const char *)draftweiboid];
            }
            
            NSString * thehuifubbsfid;
            if (drafthuifubbsfid == nil)
            {
                thehuifubbsfid = @"";
            }else {
                thehuifubbsfid = [NSString stringWithUTF8String:(const char *)drafthuifubbsfid];
            }
            
            NSString * thetitle;
            if (drafttitle == nil)
            {
                thetitle = @"";
            }else {
                thetitle = [NSString stringWithUTF8String:(const char *)drafttitle];
            }
            
            NSString * thecolumns;
            if (drafcolumns == nil)
            {
                thecolumns = @"";
            }else {
                thecolumns = [NSString stringWithUTF8String:(const char *)drafcolumns];
            }
            
            NSString * theimage;
            if (drafimage == nil)
            {
                theimage = @"";
            }else {
                theimage = [NSString stringWithUTF8String:(const char *)drafimage];
            }
            
            
            DraftDatabase *data_=[[DraftDatabase alloc]initWithtype:thetype thecontent:thecontent thedate:thedate thehuifubbsid:thehuifubbsid thefabiaoid:thefabiaogid theweiboid:theweiboid theusername:theusername thehuifubbsfid:thehuifubbsfid thetitle:thetitle columns:thecolumns image:theimage];
            
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


+(NSMutableArray *)findallbytheContent:(NSString *)theContent
{
    sqlite3 *db =[dataBase openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db,"select * from DraftBox where content=? order by date desc",-1,&stmt,nil);
    sqlite3_bind_text(stmt, 1,[theContent UTF8String], -1, nil);
    
    if (result == SQLITE_OK) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            
            const unsigned char * drafttype=sqlite3_column_text(stmt,0);
            const unsigned char * draftcontent=sqlite3_column_text(stmt,1);
            const unsigned char * draftdate=sqlite3_column_text(stmt,2);
            const unsigned char * drafthuifubbsid=sqlite3_column_text(stmt,3);
            const unsigned char * draftfabiaogid=sqlite3_column_text(stmt,4);
            const unsigned char * draftusername=sqlite3_column_text(stmt,5);
            const unsigned char * draftweiboid=sqlite3_column_text(stmt,6);
            const unsigned char * drafthuifubbsfid=sqlite3_column_text(stmt,7);
            const unsigned char * drafttitle=sqlite3_column_text(stmt,8);
            const unsigned char * drafcolumns=sqlite3_column_text(stmt,9);
            const unsigned char * drafimage=sqlite3_column_text(stmt,10);
            
            
            
            NSString * thetype;
            if (drafttype == nil)
            {
                thetype = @"";
            }else {
                thetype = [NSString stringWithUTF8String:(const char *)drafttype];
            }
            
            NSString * thecontent;
            if (draftcontent == nil)
            {
                thecontent = @"";
            }else {
                thecontent = [NSString stringWithUTF8String:(const char *)draftcontent];
            }
            
            NSString * thedate;
            if (draftdate == nil)
            {
                thedate = @"";
            }else {
                thedate = [NSString stringWithUTF8String:(const char *)draftdate];
            }
            
            NSString * thehuifubbsid;
            if (drafthuifubbsid == nil)
            {
                thehuifubbsid = @"";
            }else {
                thehuifubbsid = [NSString stringWithUTF8String:(const char *)drafthuifubbsid];
            }
            
            NSString * thefabiaogid;
            if (draftfabiaogid == nil)
            {
                thefabiaogid = @"";
            }else {
                thefabiaogid = [NSString stringWithUTF8String:(const char *)draftfabiaogid];
            }
            
            NSString * theusername;
            if (draftusername == nil)
            {
                theusername = @"";
            }else {
                theusername = [NSString stringWithUTF8String:(const char *)draftusername];
            }
            
            NSString * theweiboid;
            if (draftweiboid == nil)
            {
                theweiboid = @"";
            }else {
                theweiboid = [NSString stringWithUTF8String:(const char *)draftweiboid];
            }
            
            NSString * thehuifubbsfid;
            if (drafthuifubbsfid == nil)
            {
                thehuifubbsfid = @"";
            }else {
                thehuifubbsfid = [NSString stringWithUTF8String:(const char *)drafthuifubbsfid];
            }
            
            NSString * thetitle;
            if (drafttitle == nil)
            {
                thetitle = @"";
            }else {
                thetitle = [NSString stringWithUTF8String:(const char *)drafttitle];
            }
            
            NSString * thecolumns;
            if (drafcolumns == nil)
            {
                thecolumns = @"";
            }else {
                thecolumns = [NSString stringWithUTF8String:(const char *)drafcolumns];
            }
            
            NSString * theimage;
            if (drafimage == nil)
            {
                theimage = @"";
            }else {
                theimage = [NSString stringWithUTF8String:(const char *)drafimage];
            }
            
            
            DraftDatabase *data_=[[DraftDatabase alloc]initWithtype:thetype thecontent:thecontent thedate:thedate thehuifubbsid:thehuifubbsid thefabiaoid:thefabiaogid theweiboid:theweiboid theusername:theusername thehuifubbsfid:thehuifubbsfid thetitle:thetitle columns:thecolumns image:theimage];
            
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





+(int)addtype:(NSString *)thetype content:(NSString *)thecontent date:(NSString *)thedate username:(NSString *)theusername fabiaogid:(NSString *)thefabiaogid huifubbsid:(NSString *)thebbsid weiboid:(NSString *)theweiboid thehuifubbsfid:(NSString*)_fid thetitle:(NSString*)_title columns:(NSString *)_columns image:(NSString *)_image
{
    sqlite3 * db = [dataBase openDB];
    sqlite3_stmt * stmt = nil;
    //insert into DraftBox(type, content, date, huifubbsid, fabiaogid, username, weiboid, huifubbsfid) values('a','v','c','d','e','f','g','h')
    //sqlite3_prepare_v2(db,"insert into DraftBox(type,content,date,huifubbsid,fabiaogid,username,weiboid,huifubbsfid) values(?,?,?,?,?,?,?,?)",-1, &stmt,nil);
    //    sqlite3_prepare_v2(db,"insert into look(name,id) values(?,?)",-1, &stmt,nil);

    sqlite3_prepare_v2(db,"insert into DraftBox(type,content,date,huifubbsid,fabiaogid,username,weiboid,huifubbsfid,title,columns,image) values(?,?,?,?,?,?,?,?,?,?,?)",-1, &stmt,nil);
    sqlite3_bind_text(stmt, 1,[thetype UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 2,[thecontent UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 3,[thedate UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 4,[thebbsid UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 5,[thefabiaogid UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 6,[theusername UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 7,[theweiboid UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 8,[_fid UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 9,[_title UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 10,[_columns UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 11,[_image UTF8String], -1, nil);
    
    int result = sqlite3_step(stmt);
    NSLog(@"result=%d",result);
    sqlite3_finalize(stmt);
    return result;
}

+(int) deleteStudentBythecontent:(NSString *)thecontent
{
	//打开数据库
	sqlite3 *db = [dataBase openDB];
	
	sqlite3_stmt *stmt = nil;
	sqlite3_prepare_v2(db, "delete from DraftBox where content=?", -1, &stmt, nil);
    sqlite3_bind_text(stmt, 1,[thecontent UTF8String], -1, nil);
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
}

@end
