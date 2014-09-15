//
//  RankingListCustomCell.h
//  越野e族
//
//  Created by soulnear on 14-7-9.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingListModel.h"

@class RankingListCustomCell;
@protocol RankingListCustomCellDelegate <NSObject>

-(void)cancelOrCollectSectionsWith:(RankingListCustomCell *)cell;

@end

@interface RankingListCustomCell : UITableViewCell
{
    
}


@property(nonatomic,strong)UILabel * ranking_label;//排名

@property(nonatomic,strong)UILabel * title_label;//名称

@property(nonatomic,strong)UILabel * follow_num_label;//跟帖数

@property(nonatomic,strong)UIView * line_view; // 线

@property(nonatomic,strong)UIButton * collection_button;//收藏按钮

@property(nonatomic,assign)id<RankingListCustomCellDelegate>delegate;


-(void)setInfoWith:(int)ranking WithModel:(RankingListModel *)model WithType:(int)theType;



@end
