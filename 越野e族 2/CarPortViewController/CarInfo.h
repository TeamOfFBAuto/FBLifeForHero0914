//
//  CarInfo.h
//  FbLife
//
//  Created by soulnear on 13-9-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarType.h"

@interface CarInfo : NSObject
{
    
}

@property(nonatomic,strong)NSString * brandname;
@property(nonatomic,strong)NSString * brandphoto;
@property(nonatomic,strong)NSString * brandword;
@property(nonatomic,strong)NSString * brandfwords;
@property(nonatomic,strong)NSMutableArray * serieslist;

@property(nonatomic,strong)CarType * type;


-(CarInfo *)initWithDic:(NSDictionary *)dic;




+(int)deleteAll;
+(int)addWeiBoContentWithCarInfo:(CarInfo *)info;
+(NSMutableArray *)findAll;


@end










