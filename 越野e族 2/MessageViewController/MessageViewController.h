//
//  MessageViewController.h
//  FbLife
//
//  Created by soulnear on 13-8-2.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMessageViewController.h"
#import "downloadtool.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadingIndicatorView.h"


@interface MessageViewController : MyViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,NewMessageViewControllerDelegate,downloaddelegate,EGORefreshTableHeaderDelegate>
{
    NSString * authcode;
    int NewsMessageNumber;
    downloadtool *allnotificationtool;
    NSMutableArray *array_whichperson;
    LoadingIndicatorView *label_havenoshuju;
    //提醒fb通知的提醒label
    BOOL isnewfbnotification;
    UIImageView *    _tixing_label ;
    int numberoftixing;
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    NSTimer * theTimer;
    
    BOOL isShowFb;
    
}

@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)ASIHTTPRequest * request_;
@property(nonatomic,strong)NSMutableArray * data_array;
@property(nonatomic,strong)ASIHTTPRequest * newsMessage_request;
@property(nonatomic,strong)NSString *string_messageorfbno;

+(MessageViewController *)shareManager;

@end
