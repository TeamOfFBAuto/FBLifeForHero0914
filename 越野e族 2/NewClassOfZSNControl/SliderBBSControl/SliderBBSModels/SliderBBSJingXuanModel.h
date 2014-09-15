//
//  SliderBBSJingXuanModel.h
//  越野e族
//
//  Created by soulnear on 14-7-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SliderBBSJingXuanModelBlock)(NSMutableArray * array);

@interface SliderBBSJingXuanModel : NSObject
{
    SliderBBSJingXuanModelBlock jxModelBlock;
}


@property(nonatomic,strong)NSString * jx_id;
@property(nonatomic,strong)NSString * jx_photo;
@property(nonatomic,strong)NSString * jx_title;
@property(nonatomic,strong)NSString * jx_stitle;
@property(nonatomic,strong)NSString * jx_publishtime;
@property(nonatomic,strong)NSString * jx_summary;
@property(nonatomic,strong)NSString * jx_comment;
@property(nonatomic,strong)NSString * jx_link;

@property(nonatomic,strong)NSMutableArray * data_array;


-(SliderBBSJingXuanModel *)initWithDictionary:(NSDictionary *)dic;


-(void)loadJXDataWithPage:(int)thePage withBlock:(SliderBBSJingXuanModelBlock)theBlock;




@end
