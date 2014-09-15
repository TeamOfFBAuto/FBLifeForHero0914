//
//  bbsdetailViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadtool.h"
#import "JSONKit.h"
#import "bottombarview.h"
#import "ATMHud.h"
#import "SelectNumberView.h"
#import "MWPhotoBrowser.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "loadingimview.h"
#import <MessageUI/MessageUI.h>
#import "WeiboSDK.h"
#import "ZkingAlert.h"
#import "PraiseAndCollectedModel.h"

#import <MessageUI/MFMailComposeViewController.h>

//新版分享

#import "ShareView.h"


@interface bbsdetailViewController : UIViewController<downloaddelegate,BottombarviewDelegate,SelectNumberViewDelegate,AlertRePlaceViewDelegate,UIWebViewDelegate,MWPhotoBrowserDelegate,UIScrollViewDelegate,UIActionSheetDelegate,WXApiDelegate,MFMailComposeViewControllerDelegate,WeiboSDKDelegate>{
    
    BOOL isauthor;
    UIWebView *_webView;
    //达到下拉上拉得效果
    
    UIWebView *secondWebView;
    int dangqianwebview;
    NSString *string_upordown;
    
    //上下拉加载的
    UILabel *didulabel;
    UIImageView *diimgv;
    UILabel *gaolabel;
    UIImageView *gaoimgv;
    UIScrollView *webScroller;

    
    bottombarview *barview;
    downloadtool *all_tool;
    downloadtool *authortool;
    
    int selecttionofxialaview;
    int currentpage;
    
    UILabel *titleLabel;
    NSArray *array_chose;
    BOOL isHidden;//控制下拉view的
    int allpages;//取出一共多少页
    BOOL issuccessload;
    NSString *str_fid;
    NSString *str_tid;
    
    ATMHud *hud;
    BOOL isloading;
    
    
    NSMutableArray * _photos;
    
    //用于搜索第几页的帖子
    SelectNumberView *_SelectPick;
    
    loadingimview   * _isloadingIv;
    //用于分享的
    NSMutableArray *my_array;
    NSString *string_title;//论坛的标题
    NSString *string_url;//论坛在网页的链接
    
    int jiushizhegele;//多连几次
    
    int zanNumber;
    


    BOOL isPraise;//是否赞过
    
    ShareView *_shareView;


    
}
@property(nonatomic,strong)ZkingAlert *thezkingAlertV;


@property(nonatomic,strong)NSString *bbsdetail_tid;
@property(nonatomic,strong)UIImage * imgforshare;

@property(nonatomic,strong)NSMutableArray * collection_array;//由上个界面传过来，所有收藏的帖子数据

@end
