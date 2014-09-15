//
//  FBNotificationViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-8-20.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationInfo.h"
#import "loadingimview.h"
#import "LoadingIndicatorView.h"
#import "downloadtool.h"
#import "SliderBBSTitleView.h"

#import "SliderSegmentView.h"//选择微博还是贴子

@interface FBNotificationViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,NotificationInfoDelegate,downloaddelegate,SliderSegmentViewDelegate>{
    
    UITableView *fbnoti_tab;
    UITableView *bbs_tab;
    NotificationInfo *infoofnotification;
    UILabel*timestampLabel;
    AsyncImageView *   _headImageView;
    
    UILabel *labelcontent;
    UIImageView *  _background_imageView;
    loadingimview *_isloadingIv;
    downloadtool *loadmoretool;
    NSMutableArray *morearray;
    
    UILabel *label_nonedata;
    
    BOOL isLoadReadData;
    
    BOOL uReadOver;
    
    SliderSegmentView *_slsV;
    
    SliderBBSTitleView * seg_view;//标题选择
    
    BOOL isbbs;

    NSArray *bbs_array;
    int bbs_page;
    
}


@property(nonatomic,strong)NSMutableArray * read_array;
@property(nonatomic,strong)NSMutableArray * uread_array;
@property(nonatomic,assign)int read_page;
@property(nonatomic,assign)int uRead_page;
@property(nonatomic,strong)LoadingIndicatorView * loadingView;

@property(nonatomic,strong)UIScrollView * myScrollView;

@end
