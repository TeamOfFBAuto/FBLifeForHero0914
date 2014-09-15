//
//  testbase.h
//  testsqlite
//
//  Created by 史忠坤 on 13-3-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//用于最近浏览的数据的存储

#import <Foundation/Foundation.h>

@interface testbase : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *id_ofbbs;
-(testbase *)initWithname:(NSString *)bbsname bbsid:(NSString*)_bbsid;
+(NSMutableArray *)findall;
+(int)addbbsname:(NSString *)thebbsname  id:(NSString *)theid ;
+(int) deleteStudentByID:(NSString*) theID;

@end
