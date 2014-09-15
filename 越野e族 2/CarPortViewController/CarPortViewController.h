//
//  CarPortViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarPortSeg.h"
#import "CarInfo.h"
#import "CarType.h"
#import "LoadingIndicatorView.h"
#import "AlertRePlaceView.h"
#import "EGORefreshTableHeaderView.h"


@interface CarPortViewController : MyViewController<CarPortSegDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,AsyncImageDelegate,EGORefreshTableHeaderDelegate,AlertRePlaceViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
    
    CarPortSeg * seg;
    
    UILabel * name_label;
    
    NSString * shaixuan_string;
    
    CGPoint start_point;
    
    int CurrentPage;
    
    int choose_type;
    
    int choose_price;
    
    int choose_area;
    
    int choose_size;
    
    LoadingIndicatorView * loadingView;
    
    int pageCount;
    
    ASIHTTPRequest * request_;
    
    ASIHTTPRequest * request1;
    
    ASIHTTPRequest * request2;
    
    UIImageView * selectedBack_view;
    
    int selected_number[10];
}

@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)UITableView * car_tableview;

@property(nonatomic,strong)UITableView * choose_tableview;

@property(nonatomic,strong)UITableView * Screening_tableView;

@property(nonatomic,strong)NSMutableArray * Screening_array;

@property(nonatomic,strong)NSMutableArray * choose_array;

@property(nonatomic,strong)NSMutableArray * section_array;

@property(nonatomic,strong)NSMutableArray * data_array;

@property(nonatomic,strong)NSMutableArray * number_array;

@property(nonatomic,strong)UIView * silder_view;

@property(nonatomic,strong)NSMutableArray * product_array;

@property(nonatomic,strong)CarInfo * the_info;

@property(nonatomic,strong)CarType * the_type;



@end
