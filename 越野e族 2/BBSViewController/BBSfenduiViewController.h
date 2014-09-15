//
//  BBSfenduiViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadtool.h"
#import "ASIHTTPRequest.h"
#import "ATMHud.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadingIndicatorView.h"
#import "SelectsalestateView.h"
#import "loadingimview.h"
#import "AdvertisingimageView.h"

@interface BBSfenduiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,downloaddelegate,ASIHTTPRequestDelegate,EGORefreshTableHeaderDelegate,SelectsalestateViewDelegate,AlertRePlaceViewDelegate,AdvertisingimageViewDelegate>
{SelectsalestateView *_salestate;
    UITableView *tab_;
    downloadtool *tool_101;
    NSString *str_fid;
    ATMHud *hud;
    UIView *ShortView;
    
	EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    int currentpage;
    
    BOOL isLoadsuccess;
    LoadingIndicatorView *loadview;
    
    UILabel *_titleLabel;
    
    NSArray *array_chose;
    BOOL isHidden;//控制下拉view的
    int selecttionofxialaview;
    
    NSArray *array_salestate;
    NSArray *array_location;
    
    //出售或者购买的ID
    int saleID;
    int buyID;
    int numberoftypeid;
    int numberofareaid;
    loadingimview *_isloadingIv;
    
    //广告
    AdvertisingimageView *advImgV;
    NSString *str_guanggaourl;
    NSString *str_guanggaolink;
    BOOL isadvertisingImghiden;//判断广告位是否是隐藏的，刚开始是显示的

    downloadtool *tool_guanggao;

    
}
@property(nonatomic,strong)NSString *string_id;
@property(nonatomic,strong)NSString *string_name;
@property(nonatomic,strong)NSMutableArray *array_info;
@property(nonatomic,strong)NSMutableArray * collection_array;//保存收藏数据

@end
