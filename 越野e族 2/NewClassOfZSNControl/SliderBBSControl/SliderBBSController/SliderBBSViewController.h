//
//  SliderBBSViewController.h
//  越野e族
//
//  Created by soulnear on 14-7-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderBBSJingXuanModel.h"
#import "LoadingIndicatorView.h"
#import "ASINetworkQueue.h"
#import "SliderForumCollectionModel.h"



@interface SliderBBSForumModel : NSObject
{
    
}


@property(nonatomic,strong)NSString * forum_fid;

@property(nonatomic,strong)NSString * forum_name;

@property(nonatomic,assign)BOOL forum_isOpen;

@property(nonatomic,assign)BOOL forum_isHave_sub;

@property(nonatomic,strong)NSMutableArray * forum_sub;



-(SliderBBSForumModel *)initWithDictionary:(NSDictionary *)dic;

@end




typedef enum{
    ForumDiQuType = 0,
    ForumCheXingType,
    ForumZhuTiType,
    ForumJiaoYiType
} ForumType;



@interface SliderBBSViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,LogInViewControllerDelegate>
{
    int data_currentPage;//论坛精选加载页数
    
    LoadingIndicatorView *loadview;//上拉加载的view
    
    NSArray * forum_title_array;//存放论坛版块标题
    
    ForumType theType; // 当前论坛版块
    
    int current_forum;//当前论坛板块
    
    int history_second_cell;//是否点开第三层
    
    EGORefreshTableHeaderView *_refreshHeaderView;//下拉刷新
    
    BOOL _reloading;
    
    
    int current_dingyue_zuijin;//显示我的订阅还是最新浏览
    
    
    SliderForumCollectionModel * collection_model;//所有收藏的论坛版块数据
    
    int current_seg_index;//存储当前的选择(我的订阅，最近浏览，排行榜)
    
    int history_forum_on;//记录上次展开的
    
}
@property(nonatomic,assign)BOOL isMain;//是否是主视图


@property(nonatomic,strong)UITableView * myTableView1;//精品推荐

@property(nonatomic,strong)UITableView * myTableView2;//全部版块

@property(nonatomic,strong)UIScrollView * myScrollView; //滚动视图承载

@property(nonatomic,strong)NSMutableArray * array_collect;//存放所有我的订阅数据

@property(nonatomic,strong)NSMutableArray * data_array;//存放论坛精选数据

@property(nonatomic,strong)NSMutableArray * forum_diqu_array;//地区版块数据

@property(nonatomic,strong)NSMutableArray * forum_chexing_array;//车型版块数据

@property(nonatomic,strong)NSMutableArray * forum_zhuti_array;//主题版块数据

@property(nonatomic,strong)NSMutableArray * forum_jiaoyi_array;//交易版块数据

@property(nonatomic,strong)NSMutableArray * forum_temp_array;//存放四个板块数组

@property(nonatomic,strong)NSMutableArray * forum_section_collection_array;//存放所有收藏的论坛版块的id

@property(nonatomic,strong)NSMutableArray * recently_look_array;//存放最近浏览数据

@property(nonatomic,strong)SliderBBSTitleView * seg_view;//精选 全部版块 选择

@property(nonatomic,assign)int seg_current_page;//记录当前是 精选还是版块(0为精选  1为论坛版块)


@property(nonatomic,strong)SliderBBSJingXuanModel * myModel;


+(SliderBBSViewController *)shareManager;


@end
