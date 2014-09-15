//
//  RootViewController.h
//  FbLife
//
//  Created by szk on 13-2-21.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import "LoadingIndicatorView.h"
#import "newsimage_scro.h"
#import "EGORefreshTableHeaderView.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>
#import "downloadtool.h"
#import "SMPageControl.h"
#import "fbWebViewController.h"
#import "NewMineViewController.h"
#import "AdvertisingModel.h"
#import "CustomSegmentView.h"
#import "SearchNewsView.h"
#import "NewWeiBoCustomCell.h"
#import "LogInViewController.h"
#import "MWPhotoBrowser.h"
#import "newsTableview.h"
#import "rootnewsModel.h"
#import "FBNotificationViewController.h"//fb系统通知
#import "MessageViewController.h"//私信列表
@interface RootViewController : MyViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,AlertRePlaceViewDelegate,ASIHTTPRequestDelegate,downloaddelegate,AsyncImageDelegate,AdvertisingModelDelegate,UISearchBarDelegate,CustomSegmentViewDelegate,NewWeiBoCustomCellDelegate,MWPhotoBrowserDelegate,UITextFieldDelegate,rootNewsModelDelegate,newsTableviewDelegate>
{
    UIScrollView *newsScrow;
    NSArray * array_lanmu;
    
    
    UITableView *tab_;
    NSDictionary *dic;//推荐新闻的字典
    NSArray *array_;//推荐新闻的数组
    NSMutableArray *image_mutar;//图片的url的地址
    NSMutableArray *recommend_array_id;//推荐新闻的ID
    
    NSDictionary *ordinary_dic;
    NSArray *ordinary_array;
    NSMutableArray *orr_array_im;//普通的新闻的图片集合
    NSMutableArray *orr_array_title;//标题
    NSMutableArray *orr_array_date;//发布时间
    NSMutableArray *orr_array_discribe;//内容概要
    NSMutableArray *orr_array_id;//ID;
    NSMutableArray *rec_array_id;//推荐新闻的id
    NSMutableArray *rec_array_link;//推荐新闻的id
    NSMutableArray *rec_array_title;//推荐新闻的id
    NSMutableArray *rec_array_type;//推荐新闻的id
    
    
    
    UILabel *labeltuiguang;//cell中那个推广
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;//第三刷新类的，不知道啥用
    
    BOOL isloadingrecommend;//完成了推荐新闻的下载
    BOOL isloadingoriginal;//完成了普通新闻的下载
    
    BOOL isshanglajiazai;
    int pagecount;
    
    LoadingIndicatorView *loadview;//上拉加载的view
    
    UILabel *nomore;//没有更多数据
    SMPageControl *_pagecontrol;
    UILabel *_titleimagelabel;
    
    UIImageView *_ImgvLeft;
    UIImageView *_ImgvRight;
    
    //获取广告的
    AdvertisingModel *admodel;
    BOOL isadvertisingoadsuccess;
    //用于搜索的
    UIImageView *ImgV_ofsearch;
    UIView *searchheaderview;
    UITextField *_searchbar;
    UIView *blackcolorview;
    CustomSegmentView *mysegment;
    NSString *string_searchurl;
    //用于搜索的tableview
    UITableView *searchresaultview;
    
    
    ASIHTTPRequest * request_search;
    
    
    NSMutableArray * array_search_zixun;
    
    NSMutableArray * array_search_bbs;
    
    NSMutableArray * array_search_user;
    
    int current_select;
    
    //搜索微博数据
    LogInViewController * logIn;
    
    NSMutableArray * weibo_search_data;
    
    BOOL isHyperlinks;
    
    //search的上拉加载
    
    
    int total_count_users;
    
    int search_user_page;
    
    int mysearchPage;
    BOOL issearchloadsuccess;
    LoadingIndicatorView *searchloadingview;//search的tab的footview
    UIButton *cancelButton ;
    
    //
    
    NSMutableArray * array_cache;
    
    
    int mycurrentlanmu;
    
    //
    NewWeiBoCustomCell * test_cell;
    
}
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
-(void)processingPushWithdic:(NSDictionary *)dicofpush;

@property(nonatomic,strong) NSString *category_string;//分类的名称，比如“最新”，“车讯”。。。

@property(nonatomic,strong)UIScrollView * titleView;//上边导航选项
@property(nonatomic,strong)UIScrollView * image_scro;//第一个cell里面的幻灯
@property(nonatomic,assign)int pages;//判断是否是最后一页
@property(nonatomic,strong)NSMutableArray *array_searchresault;

@property(nonatomic,assign)BOOL isMain;

@property(nonatomic,strong)NSString *str_dijige;


//搜索微博数据

@property(nonatomic,strong)NSMutableArray * photos;
@property(nonatomic,strong)NSMutableArray * Replys_photos;
@property (nonatomic,strong) UIView *BaseView;




@end









