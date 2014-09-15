//
//  PicShowViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-16.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

#import "LoadingIndicatorView.h"



@interface PicShowViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EGORefreshTableHeaderDelegate>{
    UITableView * mainTabView;
    
    
    NSMutableArray *normalinfoAllArray;//所有的普通数据的array

    
    UILabel *nomore;//没有更多数据
    LoadingIndicatorView *loadview;//上拉加载的view
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;//第三刷新类的，不知道啥用
    
    int numberofpage;//当前页
    
    BOOL isloadsuccess;//是否加载成功



}

@property(nonatomic,assign)BOOL isMain;

@end
