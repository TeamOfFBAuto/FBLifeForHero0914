//
//  guanzhuViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-1.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadingIndicatorView.h"
#import "loadingview.h"
#import "ATMHud.h"


@interface guanzhuViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,EGORefreshTableHeaderDelegate,AlertRePlaceViewDelegate>
{
    UITableView *_guanzhu_tab;
    int pageCount;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
    LoadingIndicatorView *loadview;//上拉加载的view
    loadingview * Load_view;
    
    NSString * myUid;
    
    ATMHud * hud;
}


@property(nonatomic,strong)NSString * theUid;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSString * theTitle;



@end
