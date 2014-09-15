//
//  NewWeiBoViewController.h
//  FbLife
//
//  Created by soulnear on 13-11-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingIndicatorView.h"
#import "EGORefreshTableHeaderView.h"
#import "AlertRePlaceView.h"
#import "ATMHud.h"
#import "FbFeed.h"
#import "WeiBoCustomSegmentView.h"
#import "NewWeiBoCustomCell.h"
#import "RTLabel.h"
#import "fbWebViewController.h"
#import "MWPhotoBrowser.h"
#import "WriteBlogViewController.h"

#import "SliderSegmentView.h"
#import "NewWeiBoCommentViewController.h"
#import "ForwardingViewController.h"
#import "LogInViewController.h"




@interface NewWeiBoViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,AlertRePlaceViewDelegate,WeiBoCustomSegmentViewDelegate,NewWeiBoCustomCellDelegate,MWPhotoBrowserDelegate,SliderSegmentViewDelegate,UITextFieldDelegate,ForwardingViewControllerDelegate,NewWeiBoCommentViewControllerDelegate>
{
    LogInViewController * logIn;
    
    LoadingIndicatorView * loadview;
    LoadingIndicatorView * loadview1;
    LoadingIndicatorView * loadview3;
    
    AlertRePlaceView * _replaceAlertView;
    
    ATMHud * hud;
    
    ASIHTTPRequest * weiBo_request;
    
    BOOL isLoadMore;
    
    BOOL _reloading;
    
    
    int selectedView;
    
    int pageCount[10];
    
    int isCacheData[10];
    
    RTLabel * test_label;
    
    NewWeiBoCustomCell * test_cell;
    
    
    //选择搜索板块还是帖子
    
    ASIHTTPRequest * search_request;
    
    UITableView * xiala_tab;
    
    UIView * temp_view;
    
    UITextField *_searchbar;
    
    BOOL issearchon;
    
    SliderSegmentView *_slsV;
    
    NSMutableArray *array_searchresault;//搜索结果的
    
    NSMutableArray * array_weibo_search;//保存搜索到的微博信息
    
    NSMutableArray * array_user_search;//保存搜索到的用户信息
    
    
    UIImageView *viewsearch;
    UIView *view_xialaherader;
    
    //search的上拉加载
    
    int current_select;
    
    int mysearchPage;
    BOOL issearchloadsuccess;
    LoadingIndicatorView *searchloadingview;//search的tab的footview
    
    NSMutableArray * array_cache;
    UIButton *cancelButton;
    
    NSMutableArray * array_search_temp;
    
    BOOL loadMoreData;
    
    
    
    //左右滑动
    
    UIScrollView * _rootScrollView;
    
    float _userContentOffsetX;
    
    BOOL _isLeftScroll;
    
    
    UIImageView * place_imageView1;//无数据时显示的图片
    UIImageView * place_imageView2;//无数据时显示的图片
    UIImageView * place_imageView3;//无数据时显示的图片
    
    
    
    
    //搜索用户
    
    int search_user_page; //搜索第几页
    
    NSMutableArray * search_user_array;//搜索用户结果
    
    int total_count_users;
    
    
    
}

@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)UITableView * myTableView1;
@property(nonatomic,strong)UITableView * myTableView2;
@property(nonatomic,strong)EGORefreshTableHeaderView * refreshHeaderView1;
@property(nonatomic,strong)EGORefreshTableHeaderView * refreshHeaderView2;
@property(nonatomic,strong)EGORefreshTableHeaderView * refreshHeaderView3;

@property(nonatomic,strong)WeiBoCustomSegmentView * weibo_seg;//顶头切换按钮

@property(nonatomic,strong)NSMutableArray * data_array;

@property(nonatomic,strong)NSMutableArray * array1;//好友圈
@property(nonatomic,strong)NSMutableArray * array2;//微博广场
@property(nonatomic,strong)NSMutableArray * array3;//我的微博

@property(nonatomic,strong)NSMutableArray * photos;

@property(nonatomic,strong)NSArray * choose_array;


@property(nonatomic,strong)NSString * selected_index;//跳到对应的微博列表


-(void)ClickWeiBoCustomSegmentWithIndex:(int)index;//点击切换按钮，加载当前选中数据

+ (NewWeiBoViewController *)sharedManager;//单例

@end










