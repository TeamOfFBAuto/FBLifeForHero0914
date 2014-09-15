//
//  NewWeiBoDetailViewController.h
//  FbLife
//
//  Created by soulnear on 13-12-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbFeed.h"
#import "NewWeiBoCustomCell.h"
#import "loadingview.h"
#import "ReplysFeed.h"
#import "RTLabel.h"
#import "WeiBoSpecialView.h"
#import "DetailBottomView.h"
#import "MWPhotoBrowser.h"
#import "ForwardingViewController.h"
#import "NewWeiBoCommentViewController.h"
#import "LoadingIndicatorView.h"


@interface NewWeiBoDetailViewController : MyViewController<UITableViewDelegate,UITableViewDataSource,NewWeiBoCustomCellDelegate,WeiBoSpecialViewDelegate,MWPhotoBrowserDelegate,DetailBottomViewDelegate,ForwardingViewControllerDelegate,NewWeiBoCommentViewControllerDelegate,RTLabelDelegate>
{
    ASIHTTPRequest * detail_request;
    
    int pageCount;
    
    FbFeed * _feed;
    
    loadingview * Load_view;
    
    UIView * weibo_content_view;
    
    AsyncImageView * _Head_ImageView;
    
    UILabel *  _UserName_Label;
    
    UILabel * _DateLine_Label;
    
    RTLabel * content_label;
    
    RTLabel * test_label;
    
    LoadingIndicatorView * tabelFootView;
    
    UIView * tishi_view;
    
}

@property(nonatomic,strong)FbFeed * info;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSMutableArray * photos;

@property(nonatomic,strong)UITableView * myTableView;



@end
