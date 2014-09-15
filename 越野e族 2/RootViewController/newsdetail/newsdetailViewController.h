//
//  newsdetailViewController.h
//  ZixunDetail
//
//  Created by szk on 13-1-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceScrollView.h"
#import "FaceView.h"
#import "downloadtool.h"
#import "GrayPageControl.h"
#import "MWPhotoBrowser.h"
#import "bottombarview.h"
#import "bbsdetailViewController.h"
#import "SelectNumberView.h"
#import "AlertRePlaceView.h"
#import "loadingimview.h"
#import "WXApi.h"
#import <MessageUI/MessageUI.h>
#import "WeiboSDK.h"
#import "ZkingAlert.h"
#import <MessageUI/MFMailComposeViewController.h>

//新版分享

#import "ShareView.h"

@interface newsdetailViewController : UIViewController<NSURLConnectionDataDelegate,UITextFieldDelegate,UIWebViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,downloaddelegate,MWPhotoBrowserDelegate,AlertRePlaceViewDelegate,BottombarviewDelegate,SelectNumberViewDelegate,WXApiDelegate,MFMailComposeViewControllerDelegate,WeiboSDKDelegate>{
    NSMutableData * _data;
    UILabel *label_bigbiaoti;
    UILabel *label_time;
    UILabel *label_yuanchuang;
    
    UILabel *label_resource;
    
    UILabel *labelcontent;
    
    UIScrollView *scro_content;
    
    UIWebView *_webView;
    UIWebView *secondWebView;
    int dangqianwebview;
    NSString *string_upordown;
    
    UILabel *label_left;
    UILabel *label_right;
    UIView *view_pinglun;
    UIButton *button_face;
    UIView *aview;
    
    FaceScrollView *faceScrollView;
    GrayPageControl * pageControl;
    
    BOOL isjianpan;//判断是facebutton是键盘还是face
    
    UIScrollView * scro_web;
    
    downloadtool *newstool;
    ASIHTTPRequest *_request;
    //点小图看大图
    NSMutableArray * _photos;
    NSArray *array_photo;
    int Selectatindexofphotonumber;
    int jiushizhegele;
    
    NSMutableArray *array_peopleid;//个人的uid
    
    bottombarview *barview;
    int currentpage;//当前是第几页
    int allpages;//取出一共多少页
    BOOL issuccessload;
    
    SelectNumberView *_SelectPick;
    //上拉刷新的
    UILabel *didulabel;
    UIImageView *diimgv;
    UILabel *gaolabel;
    UIImageView *gaoimgv;
    UIScrollView *webScroller;
    BOOL iswebloadsuccess;
    //分享的标题和链接
    NSMutableArray *my_array;
    //提示正在加载的
    
    loadingimview *_isloadingIv;
    
    //用于带到下一级页面的标题，时间，评论
    
    NSString *str_titleofnews;
    NSString *str_dateofnews;
    NSString *str_commentnumberofnews;
    NSString *str_author;
    
    NSMutableString *string_email;
    
    UIButton *rightView;
    
    int zanNumber;
    BOOL isPraise;//是否赞过
    
    ShareView *_shareView;

    
}

@property(nonatomic,strong)ZkingAlert *thezkingAlertV;

@property(nonatomic,assign)int _pages;
@property(nonatomic,strong)NSString * string_Id;
@property(nonatomic,strong)NSString * title_Str;
@property(nonatomic,strong)NSString * weburl_Str;
@property(nonatomic,strong)UIImage * imgforshare;




- (id)initWithID:(NSString*)id;

@end
