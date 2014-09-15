//
//  DraftDatabase.h
//  FbLife
//
//  Created by 史忠坤 on 13-6-18.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DraftDatabase : NSObject
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *huifubbsid;
@property(nonatomic,strong)NSString *fabiaogid;
@property(nonatomic,strong)NSString *weiboid;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *huifubbsfid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *columns;
@property(nonatomic,strong)NSString * image;


-(DraftDatabase *)initWithtype:(NSString *)_type thecontent:(NSString*)_content thedate:(NSString*)_date thehuifubbsid:(NSString*)_bbsid thefabiaoid:(NSString*)_fabiaoid theweiboid:(NSString*)_weiboid theusername:(NSString*)_username thehuifubbsfid:(NSString*)_fid thetitle:(NSString*)_title columns:(NSString *)_columns image:(NSString *)_image;

+(NSMutableArray *)findallbytheColumns:(NSString *)type;

+(NSMutableArray *)findallbytheContent:(NSString *)theContent;
+(NSMutableArray *)findalldata;



+(int)addtype:(NSString *)thetype  content:(NSString *)thecontent date:(NSString *)thedate username:(NSString *)theusername fabiaogid:(NSString *)thefabiaogid huifubbsid:(NSString *)thebbsid weiboid:(NSString *)theweiboid thehuifubbsfid:(NSString*)_fid thetitle:(NSString*)_title columns:(NSString *)_columns image:(NSString *)_image;

+(int) deleteStudentBythecontent:(NSString*) thecontent;

@end















