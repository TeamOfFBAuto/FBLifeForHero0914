//
//  collectdatabase.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//用于收藏的数据存储

#import <Foundation/Foundation.h>

@interface collectdatabase : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *id_ofbbs;
-(collectdatabase *)initWithname:(NSString *)bbsname bbsid:(NSString*)_bbsid;
+(NSMutableArray *)findall;
+(int)addbbsname:(NSString *)thebbsname  id:(NSString *)theid ;
+(int) deleteStudentByID:(NSString*) theID;
@end
