//
//  ComprehensiveViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-6-30.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZkingNavigationView.h"



#import "EGORefreshTableHeaderView.h"

#import "LoadingIndicatorView.h"

#import "NewHuandengView.h"


#import "SGFocusImageItem.h"
#import "AwesomeMenu.h"


@interface ComprehensiveViewController : UIViewController<ZkingNavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EGORefreshTableHeaderDelegate,NewHuandengViewDelegate,AwesomeMenuDelegate>{

    ZkingNavigationView *navibar;
    
    UITableView * mainTabView;
    
    NSDictionary *huandengDic;//幻灯的整体数据；
    
    
    NSMutableArray *normalinfoAllArray;//所有的普通数据的array
    
    
    /**
下拉刷新及上拉加载相关
     */

    UILabel *nomore;//没有更多数据
    LoadingIndicatorView *loadview;//上拉加载的view
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;//第三刷新类的，不知道啥用
    
    int numberofpage;//当前页
    
    BOOL isloadsuccess;//是否加载成功
    

  NewHuandengView *bannerView ;//幻灯的view;
    
    

}

@property(nonatomic,strong)NSMutableArray *commentarray;



@end
