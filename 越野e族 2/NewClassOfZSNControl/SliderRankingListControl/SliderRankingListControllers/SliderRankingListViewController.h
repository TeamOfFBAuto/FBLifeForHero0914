//
//  SliderRankingListViewController.h
//  越野e族
//
//  Created by soulnear on 14-7-9.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingListCustomCell.h"

@interface SliderRankingListViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,RankingListCustomCellDelegate>
{
    
}


@property(nonatomic,strong)UITableView * myTableView;


@property(nonatomic,strong)NSMutableArray * data_array;//二维数组，存放所有数据

@property(nonatomic,assign)int currentPage;//记录当前选中项

@property(nonatomic,strong)NSMutableArray * bbs_forum_collection_array;//论坛版块收藏的数据

@property(nonatomic,strong)NSMutableArray * bbs_post_collection_array;//论坛帖子收藏的数据


@end
