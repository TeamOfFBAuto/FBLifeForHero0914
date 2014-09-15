//
//  NewMineViewController.h
//  FbLife
//
//  Created by soulnear on 13-12-11.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfo.h"
#import "NewUserMessageTop.h"
#import "ShangJiaNewsInfo.h"
#import "RTLabel.h"
#import "NewWeiBoCustomCell.h"
#import "MWPhotoBrowser.h"
#import "bbsdetailViewController.h"
#import "newsdetailViewController.h"
#import "WenJiViewController.h"
#import "NewWeiBoDetailViewController.h"
#import "fbWebViewController.h"
#import "ImagesViewController.h"
#import "mydetailViewController.h"
#import "ATMHud.h"
#import "MyChatViewController.h"
#import "MessageInfo.h"
#import "guanzhuViewController.h"
#import "BBSfenduiViewController.h"
#import "MerchantsInfoViewController.h"
#import "AlertRePlaceView.h"
#import "LoadingIndicatorView.h"
#import "QrcodeViewController.h"
#import "ForwardingViewController.h"
#import "NewWeiBoCommentViewController.h"



@interface NewMineViewController : MyViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate,NewWeiBoCustomCellDelegate,NewUserMessageTopDelegate,AlertRePlaceViewDelegate,ForwardingViewControllerDelegate,NewWeiBoCommentViewControllerDelegate>
{
    ASIHTTPRequest * request_mine;
    
    ASIHTTPRequest * request_weibo;
    
    ASIHTTPRequest * shangjia_new_request;
    
    BOOL attention_flg;
    
    UILabel * title_label;
    
    UIView * shangjia_detail_view;
    
    BOOL show_shangjia_jianjie;
    
    int pageCount;
    
    NewWeiBoCustomCell * test_cell;
    
    ATMHud * hud;
    
    AlertRePlaceView *  _replaceAlertView;
    
    LoadingIndicatorView * loadview;
}



@property(nonatomic,strong)NSString * uid;

@property(nonatomic,strong)PersonInfo * per_info;

@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)NewUserMessageTop * top_view;

@property(nonatomic,strong)NSMutableArray * data_array;

@property(nonatomic,strong)NSMutableArray * zixin_array;

@property(nonatomic,strong)NSMutableArray * photos;




@end
