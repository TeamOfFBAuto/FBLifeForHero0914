//
//  newsTableview.h
//  越野e族
//
//  Created by 史忠坤 on 13-12-25.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadingIndicatorView.h"
#import "newslooked.h"


#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
@class newsTableview;
@protocol newsTableviewDelegate <NSObject>

-(void)refreshmydatawithtag:(int)tag;
-(void)loadmorewithtage:(int)_tag page:(int)_page;

@end
@interface newsTableview : UIView<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIScrollViewDelegate,SGFocusImageFrameDelegate>{
    
    UITableView *tab_;
    NSMutableArray *arrayofdata;
    SMPageControl *_pagecontrol;
    UILabel *labeltuiguang;//cell中那个推广
    UILabel *_titleimagelabel;
    int numberofpage;

    EGORefreshTableHeaderView *_refreshHeaderView;

    BOOL _reloading;//第三刷新类的，不知道啥用
    BOOL isloadsuccess;//是否加载成功
    UILabel *nomore;//没有更多数据
    LoadingIndicatorView *loadview;//上拉加载的view
    
    //幻灯新闻的id,type,link
    
    NSMutableArray *com_id_array;
    NSMutableArray *com_type_array;
    NSMutableArray *com_link_array;
    NSMutableArray *com_title_array;
    int select[1000];
    
   
}
-(void)newstabreceivecommentdic:(NSDictionary *)_newsCommentDic normaldic:(NSDictionary *)_newsNormalDic;
-(void)newstabreceivemorenormaldic:(NSDictionary *)_newsNormalDic;

-(void)refreshwithrag:(int)tag;
//-(void)receivemorewithcommentdic:(NSDictionary *)_morecomdic morenormaldic:(NSInteger *)_morenormaldic;
@property(nonatomic,strong)NSMutableArray * commentarray;
@property(nonatomic,strong)NSMutableArray * normalarray;
@property(assign,nonatomic)id<newsTableviewDelegate>delegate;
@property(strong,nonatomic) UIActivityIndicatorView *    activityIndicator;
@property(strong,nonatomic) UITableView *    tab;


@end
