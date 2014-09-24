//
//  GongGaoViewController.h
//  越野e族
//
//  Created by soulnear on 14-9-20.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GongGaoViewController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
}


@property(nonatomic,strong)UIWebView * myWebView;

@property(nonatomic,strong)NSString * html_name;

@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)NSMutableArray * data_array;

@end
