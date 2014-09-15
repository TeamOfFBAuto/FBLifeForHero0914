//
//  MerchantsInfoViewController.h
//  越野e族
//
//  Created by soulnear on 13-12-23.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangJiaNewsInfo.h"
#import "MerchantsInfoCell.h"
#import "fbWebViewController.h"

@interface MerchantsInfoViewController : MyViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,MerchantsInfoCellDelegate>
{
    ASIHTTPRequest * request_;
    int pageCount;
}

@property(nonatomic,strong)NSString * uid;

@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)NSMutableArray * data_array;



@end
