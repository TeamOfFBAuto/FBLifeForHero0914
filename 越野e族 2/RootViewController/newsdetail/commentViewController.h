//
//  commentViewController.h
//  ZixunDetail
//
//  Created by szk on 13-1-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceScrollView.h"
#import "FaceView.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadingIndicatorView.h"
#import "AsyncImageView.h"
#import "NewFaceView.h"
#import "WeiBoFaceScrollView.h"
@interface commentViewController : MyViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,UIActionSheetDelegate,UIScrollViewDelegate,downloaddelegate>{
    UITableView *tab_pinglunliebiao;
    
    UILabel *label_bigbiaoti;
    UITextField *text_write;
    UIView *view_pinglun;
    
    NSMutableData * _data;
    UIActivityIndicatorView *activity;
    
    NSMutableArray *array_name;
    NSMutableArray *array_reply;
    NSMutableArray *array_time;
    NSMutableArray *array_tid;
    NSMutableArray *array_content;
    NSMutableArray *array_weiboinfo;
    NSMutableArray *array_image;
    NSMutableArray *array_peopleid;
    // NSMutableArray *array_pinglunzhe;
    UIView *aview;
    WeiBoFaceScrollView *faceScrollView;
    
    BOOL isjianpan;//判断是facebutton是键盘还是face
    BOOL isloadsuccess;//只有刷新加载过程完成了才能进行下一次加载
    BOOL ispaixu;//控制排序view的弹出或者关闭
    BOOL isup;//
    BOOL iszipinglun;//判断是评论新闻还是评论评论
    
    UIView *view_paixu;
    UIImageView *duihaoup;
    UIImageView *duihaodown;
    
    
    
    
    int dijige;//判断
	EGORefreshTableHeaderView *_refreshHeaderView;
    UILabel *label_noneshuju;//没有数据时候的处理
    UILabel *label_meiduoshao;//没有数据时候的处理
    
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
    LoadingIndicatorView *loadview;
    
    int tid;//评论的id
    GrayPageControl * pageControl;
    //评论的评论
    NSMutableArray *muary_commentofcomment;
    
    NSArray *arrayofcommentc;
    
    int whichsectionopend;
    BOOL isopen;
}
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;


@property(nonatomic,strong)ZkingAlert *thezkingAlertV;

@property(nonatomic,strong)NSString *string_content;
@property(nonatomic,assign)int pageN;
@property(nonatomic,assign)int allcount;
@property(nonatomic ,strong)NSString *string_paixu;
@property(nonatomic,strong)NSString *string_ID;//新闻的id
@property(nonatomic,strong)NSString *string_biaoti;
@property(nonatomic,strong)NSString *string_title;
@property(nonatomic,strong)NSString *string_date;
@property(nonatomic,strong)NSString *string_commentnumber;
@property(nonatomic,strong)NSString *string_author;

@property(nonatomic,strong)NSString *sortString;//判断的，是新闻评论还是图集评论



@end
