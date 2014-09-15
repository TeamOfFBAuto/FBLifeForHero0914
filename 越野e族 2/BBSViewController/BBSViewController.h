//
//  BBSViewController.h
//  FbLife
//
//  Created by szk on 13-2-21.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "testbase.h"
#import "collectdatabase.h"
#import "Search.h"
#import "downloadtool.h"
#import "YHCPickerView.h"
#import "UIDemoBaseController.h"
#import "allbbsModel.h"
#import "AKSegmentedControl.h"
#import "CustomSegmentView.h"
#import "newscellview.h"
#import "bbsdetailViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadingIndicatorView.h"
#import "AdvertisingimageView.h"
#import "AdvertisingModel.h"
#import "SliderSegmentView.h"//选择搜索版块还是帖子
#import "SearchNewsView.h"
#import "newslooked.h"


@interface BBSViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,downloaddelegate,YHCPickerViewDelegate,allbbsModeldelegate,AlertRePlaceViewDelegate,AKSegmentedControlDelegate,CustomSegmentViewDelegate,EGORefreshTableHeaderDelegate,AdvertisingimageViewDelegate,AdvertisingModelDelegate,AsyncImageDelegate,SliderSegmentViewDelegate,UITextFieldDelegate>{
    ASIHTTPRequest *request_;
    UITableView *tab_;
    UITextField *_searchbar;
    NSMutableArray *array_recentlook;
    NSMutableArray *array_collect;
    
//    UIImageView *viewsearch;
//    UIView *bankuaiView;
    
    int select[1000];
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
    
    int pageCount;
    
    LoadingIndicatorView *loadview;//上拉加载的view
    
    
    
    UITableView *xiala_tab;
    
    downloadtool *searchtool;
    NSMutableArray  *searcharrayname;
    NSMutableArray  *searcharrayid;
    
    NSMutableArray *array_allbbsbankuai;//在网上请求一次这个数据，所有的版块名字;
    NSMutableArray *array_allbbsbankuaiID;//在网上请求一次这个数据，所有的版块名字id;
    
    YHCPickerView *objYHCPickerView;
    NSMutableArray *array_haha;
    UIButton *_recognizeButton;    
    
    UIButton *CancelButton;//searchbar的取消按钮
    
    //获取allbbs的数据
    NSMutableArray *array_section;//这个是公益，e族大队等，section的信息
    NSMutableArray *array_row;//2维数组，存放每一个section里面的row的内容，比如山东、北京等
    NSMutableArray *array_detail;
    
    NSMutableArray *array_IDrow;
    NSMutableArray *array_IDdetail;
    int isloadsuccess[5];
    AKSegmentedControl  *segmentedControl3;
    
    int selectindex;
    
    BOOL atuoRefresh;
    
    BOOL isadvertisingImghiden;//判断广告位是否是隐藏的，刚开始是显示的
    BOOL issearchon;//判断search的状态
    
    UIView * customSegment_view;
    
    float selectContentOffSet[255];
    //顶部的广告位
//    UIImageView *Advertising_imageV;
//    UIImage *Advertising_img;
    AdvertisingimageView *advImgV;
    AdvertisingModel *model___;
    NSString *str_guanggaourl;
    NSString *str_guanggaolink;

    downloadtool *tool_guanggao;
    //选择搜索版块还是帖子
    
    SliderSegmentView *_slsV;
    NSMutableArray *array_searchresault;//搜索结果的

    UIImageView *viewsearch;
    UIView *view_xialaherader;
    
    //search的上拉加载
    
    int mysearchPage;
    BOOL issearchloadsuccess;
    LoadingIndicatorView *searchloadingview;//search的tab的footview

    UIButton *scancelButton;
    
    UIView *blackcolorview;

//
}
@property(nonatomic,strong)NSMutableArray * data_array;//论坛精选数据

@end
