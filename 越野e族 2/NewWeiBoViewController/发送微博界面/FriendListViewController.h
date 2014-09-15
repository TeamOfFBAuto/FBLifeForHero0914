//
//  FriendListViewController.h
//  FbLife
//
//  Created by szk on 13-3-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//



@protocol FriendListViewControllerDelegate <NSObject>

@optional

-(void)atSomeBodys:(NSString *)string;

-(void)returnUserName:(NSString *)username Uid:(NSString *)uid;


@end

#import <UIKit/UIKit.h>
#import "LoadingIndicatorView.h"
#import "loadingimview.h"


@interface FriendListViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,AlertRePlaceViewDelegate,UITextFieldDelegate>
{
    int pageCount;
    id<FriendListViewControllerDelegate>delegate;
    UIView *search_view;
    UINavigationBar *nav;
    UIButton * button1;
    
    BOOL searchOrCancell;
    
    ATMHud * hud;
    
    LoadingIndicatorView * loadview;
    
    UILabel *_isloadingIv;
    
    NSMutableArray * number_array;
    
    float ios7_height;
    
    
    UITextField * search_tf;
    
    UIImageView *imgbc;
    
    UIButton * cancelButton;
}


@property(nonatomic,strong)NSString * title_name_string;

@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * tempArray;
@property(nonatomic,assign)id<FriendListViewControllerDelegate>delegate;
@property(nonatomic,strong)NSMutableArray * _listContent;
@property(nonatomic,strong)NSMutableArray * RecentContact_array;


@property(nonatomic,strong)ASIHTTPRequest * request_friend;
@property(nonatomic,strong)ASIHTTPRequest * request_recentcontact;


-(void)setDelegate:(id<FriendListViewControllerDelegate>)delegate1;

@end
