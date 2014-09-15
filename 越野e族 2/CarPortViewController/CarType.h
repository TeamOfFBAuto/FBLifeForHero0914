//
//  CarType.h
//  FbLife
//
//  Created by soulnear on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarType : NSObject
{
    
}


@property(nonatomic,strong)NSString * area;//国别
@property(nonatomic,strong)NSString * carfrom;//车系产地 一汽丰田
@property(nonatomic,strong)NSString * carnum;//车型数量
@property(nonatomic,strong)NSString * content;//介绍
@property(nonatomic,strong)NSString * fid;//论坛版面id
@property(nonatomic,strong)NSString * fwords;//首字母
@property(nonatomic,strong)NSString * groupid;//级别组id 0品牌 1车系 2车型
@property(nonatomic,strong)NSString * carid;//车系id
@property(nonatomic,strong)NSString * name;//车系中文名
@property(nonatomic,strong)NSString * nwords;//新闻关键词
@property(nonatomic,strong)NSString * photo;//品牌/车系logo
@property(nonatomic,strong)NSString * picnum;//图片数量
@property(nonatomic,strong)NSString * pid;//父系id
@property(nonatomic,strong)NSString * price;//价格
@property(nonatomic,strong)NSString * price_range;//价格范围
@property(nonatomic,strong)NSString * priority;//排序优先级
@property(nonatomic,strong)NSString * recommend;//是否推荐
@property(nonatomic,strong)NSString * series_price_max;//车系最高价
@property(nonatomic,strong)NSString * series_price_min;//车系最低价
@property(nonatomic,strong)NSString * size;//尺寸
@property(nonatomic,strong)NSString * type;//车系分类
@property(nonatomic,strong)NSString * url;//车系图片链接
@property(nonatomic,strong)NSString * words;//英文



-(CarType *)initWithDictionary:(NSDictionary *)dic;



@end



















