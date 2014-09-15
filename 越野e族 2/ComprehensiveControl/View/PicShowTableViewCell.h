//
//  PicShowTableViewCell.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-16.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicShowTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *bigLabel;//图集的大标题

@property(nonatomic,strong)AsyncImageView *leftImageV;//左边的图片

@property(nonatomic,strong)AsyncImageView *centerImageV;//中间的图片

@property(nonatomic,strong)AsyncImageView *rightImageV;//右边的图片

@property(nonatomic,strong)UIImageView *zanImageV;//赞的图标

@property(nonatomic,strong)UILabel *zanlabel;//赞的数量

@property(nonatomic,strong)UILabel *textBigLabel;//时间

@property(nonatomic,strong)UIView *normalLine;//分割线


-(void)picCellSetDic:(NSDictionary *)myDic;

@end
