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




typedef enum {
    //以下是枚举成员 TestA = 0,
    FinalshoucangViewTypeNews=0,
    FinalshoucangViewTypeTiezi=1,
    FinalshoucangViewTypebankuai=2,
    FinalshoucangViewTypetuji=3,
    FinalshoucangViewTypeMyWrite=4,
    FinalshoucangViewTypeMyComment=5,
    
}FinalshoucangViewType;//枚举名称


@class FinalshoucangView;
@protocol FinalshoucangViewDelegate <NSObject>

//-(void)refreshmydatawithtag:(int)tag;
//-(void)loadmorewithtage:(int)_tag page:(int)_page;

@end

@interface FinalshoucangView : UIView<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIScrollViewDelegate>{
    
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
    

    
    
}

- (id)initWithFrame:(CGRect)frame Type:(FinalshoucangViewType)thetype;


-(void)newstabreceivenormaldic:(NSDictionary *)_newsNormalDic;
-(void)newstabreceivemorenormaldic:(NSDictionary *)_newsNormalDic;
-(void)refreshwithrag:(int)tag;

//-(void)receivemorewithcommentdic:(NSDictionary *)_morecomdic morenormaldic:(NSInteger *)_morenormaldic;
@property(nonatomic,strong)NSMutableArray * commentarray;
@property(nonatomic,strong)NSMutableArray * normalarray;
@property(assign,nonatomic)id<FinalshoucangViewDelegate>delegate;
@property(strong,nonatomic) UIActivityIndicatorView *    activityIndicator;
@property(strong,nonatomic) UITableView *    tab;
@property(assign,nonatomic)FinalshoucangViewType mytype;


@end
