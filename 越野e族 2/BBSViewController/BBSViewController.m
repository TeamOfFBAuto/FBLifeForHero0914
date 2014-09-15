//
//  BBSViewController.m
//  FbLife
//
//  Created by szk on 13-2-21.
//  Copyright (c) 2013年 szk. All rights reserved.
//999发送搜索请求

#import "BBSViewController.h"
#import "allbbsViewController.h"
#import "BBSfenduiViewController.h"
#import "AlertRePlaceView.h"
#import "fbWebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BBSViewController (){
    allbbsViewController *_allbbs;
    BBSfenduiViewController *_fendui;
    AlertRePlaceView *_replaceAlertView;
    
    UIView * sectionView;
    UIView *aview;
}

@end

@implementation BBSViewController
@synthesize data_array = _data_array;
#pragma allbbsmodel的代理方法
//-(void)loadsuccess{
//    NSLog(@"成功获取到数据");
//}
//-(void)loadsuccesserror{
//    NSLog(@"没有获取到数据");
//
//}
#define contentSet 135


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated
{
    
       

    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"date"])
    {
        NSTimeInterval secondsPerDay = 30 * 60;
        
        NSDate * date = [user objectForKey:@"date"];
        
        if (fabs([date timeIntervalSinceNow])>=secondsPerDay)
        {
            atuoRefresh = YES;
            if (!isHaveNetWork) {
              //  [self bbsSelectFind:1];
                

            }
        }
        
        NSLog(@"shijian ----  %f",[date timeIntervalSinceNow]);
        
    }else
    {
        NSDate * date = [NSDate date];
        
        [user setObject:date forKey:@"date"];
        
        [user synchronize];
    }
    [_searchbar resignFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [_replaceAlertView removeFromSuperview];
    _replaceAlertView=nil;
    
    [MobClick endEvent:@"BBSViewController"];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    [MobClick beginEvent:@"BBSViewController"];
    
    NSLog(@"isearchon====%d",issearchon);
    if (issearchon) {
        
        
        
        self.navigationController.navigationBarHidden=YES;

    }else{
        
        
        
        self.navigationController.navigationBarHidden=NO;

    }

    
    for (id aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([aviewp isEqual:[AlertRePlaceView class]])
        {
            [aviewp removeFromSuperview];
        }
    }

    
    // [self.leveyTabBarController hidesTabBar:NO animated:YES];
    
    [_searchbar resignFirstResponder];
    array_recentlook=[testbase findall];
    // array_collect=[collectdatabase findall];
    //  xiala_tab.hidden=YES;
    //[tab_ reloadData];
    if (!isHaveNetWork) {
        [self collectfind];
        
       // [self bbsSelectFind:1];
        

    }
    
    
    
    //每次进来判断时间
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *stringoldtime=[NSString stringWithFormat:@"%@",[user objectForKey:[NSString stringWithFormat:@"dismisstimechange"]]];
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    
    
    
    if (![stringoldtime isEqualToString:@"(null)"]) {
        
        float timecha=-[stringoldtime floatValue]+[timeString floatValue];
        
        NSLog(@"时间差为==%f",timecha);
        if (timecha<4*60*60) {
            NSLog(@"4个小时分钟之内");
        }else{
            NSLog(@"超过4个小时了");
            if (!isHaveNetWork) {
                [self testguanggao];

            }
        
        }
        
    }else{
        NSLog(@"第一次程序启动");
        
    }
    
    
    
    
}

#pragma mark-广告view的delegate
-(void)TurntoFbWebview{
    fbWebViewController *fbweb=[[fbWebViewController alloc]init];
    fbweb.urlstring=str_guanggaolink;
    [self.navigationController pushViewController:fbweb animated:YES];
    NSLog(@"zounifb");
    
}
-(void)advimgdismiss{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    [[NSUserDefaults standardUserDefaults] setObject:timeString forKey:[NSString stringWithFormat:@"dismisstimechange"]];
    
    isadvertisingImghiden=YES;
    [tab_ reloadData];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"missadv" object:nil];
    
    NSLog(@"在这完成广告位消失以及改变tabv的frame的动画");
    // [self performSelector:@selector(advreback) withObject:nil afterDelay:3.0f];
    
}



#pragma mark-过一段时间，让广告回来
-(void)advreback{
    isadvertisingImghiden=NO;
    [tab_ reloadData];
    
}
-(void)startloadadvertisingimg{
    
}
#pragma mark-读取广告数据的方法
-(void)finishload{
    
}
-(void)failedload{
    
}

-(void)bbsSelectFind:(int)thePage
{
    
    
    
    ASIHTTPRequest * request;
    
    if (request)
    {
        request.delegate = nil;
        [request cancel];
        request = nil;
    }
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=bbspicked&classname=luntanjingxuan&type=json&page=%d",thePage]];
    NSLog(@"查找论坛精选接口 ---  %@",[NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=bbspicked&classname=luntanjingxuan&type=json&page=%d",thePage]);
    request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:120];
    request.delegate = self;
    
    if (thePage==1) {
        
        
        
        
        [UIView animateWithDuration:0.3 animations:^{
            [tab_ setContentOffset:CGPointMake(0, -80)];
            
            
            
            
            
            //动画内容
            
        }completion:^(BOOL finished)
         
         {
             
             
             
         }];
    }


    
    __block ASIHTTPRequest * request1 = request;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [request1 setCompletionBlock:^{
        
        @try {
            [loadview stopLoading:1];
            
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            NSLog(@"dicccc ---  %@",dic);
            
            if ([[dic objectForKey:@"errno"] intValue] ==0)
            {
                
                
                if (thePage==1) {
                    [UIView animateWithDuration:0.5 animations:^{
                        [tab_ setContentOffset:CGPointMake(0, 0)];
                        
                        //动画内容
                        
                    }completion:^(BOOL finished)
                     
                     {
                         
                         
                         
                     }];
                }
                
                NSArray * array;
                
                @try {
                    array = [dic objectForKey:@"news"];
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
                if (atuoRefresh && self.data_array.count != 0)
                {
                    [user setObject:array forKey:@"bbsSelect"];
                    
                    atuoRefresh = NO;
                }else
                {
                    if (array.count == 0)
                    {
                        loadview.normalLabel.text = @"没有更多了";
                        return;
                    }
                    
                    if (pageCount ==1)
                    {
                        [self.data_array removeAllObjects];
                        [self.data_array addObjectsFromArray:[dic objectForKey:@"news"]];
                    }else
                    {
                        [self.data_array addObjectsFromArray:array];
                    }
                    
                    [user setObject:self.data_array forKey:@"bbsSelect"];
                    
                    [user synchronize];
                    
                    [tab_ reloadData];
                }
            }else
            {
                loadview.normalLabel.text = @"没有更多了";
                return;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    
    [request1 setFailedBlock:^{
        
        if (!atuoRefresh)
        {
                
            
                
//                _replaceAlertView.hidden=NO;
//                [_replaceAlertView hide];
            }

    }];
    
    [request startAsynchronous];
}



-(void)collectfind{
    [array_collect removeAllObjects];
    array_collect=[[NSMutableArray alloc]init];
    downloadtool *tool_collect=[[downloadtool alloc]init];
    [tool_collect setUrl_string:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/favoritesforums.php?authcode=%@&action=query&formattype=json" ,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]];
    tool_collect.tag=101;
    tool_collect.delegate=self;
    [tool_collect start];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testguanggao];
    
    self.data_array = [[NSMutableArray alloc] init];
    
    
    selectindex=0;
    pageCount = 1;
    atuoRefresh = NO;
    isadvertisingImghiden=YES;
    issearchon=NO;
//    for (int i=0; i<1000; i++) {
//        select[i]=0;
//    }
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSArray * array = [user objectForKey:@"bbsSelect"];
    if (array.count !=0)
    {
//        [self.data_array addObjectsFromArray:array];
//        [tab_ reloadData];
        
 //       [self bbsSelectFind:1];

    }else
    {
    //    [self bbsSelectFind:1];
    }
    
    
    if (![[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"youshuju"]]isEqualToString:@"yijingyoushujule"] )
    {
        [self sendrequest];
        
    }else{
        NSLog(@"已经有数据了");
        [self sendrequest];
    }
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.navigationController.navigationBarHidden=NO;
    
    
    
    [self.navigationController.parentViewController.view.window makeKeyAndVisible];
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        //iOS 5 new UINavigationBar custom background
        
         [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];        
        
    }
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ios7logo"]];
    leftImageView.center = CGPointMake(MY_MACRO_NAME? 18:30,22);
    UIView *lefttttview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [lefttttview addSubview:leftImageView];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:lefttttview];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.navigationItem.title = @"论坛";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
//    UIButton *  refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [refreshButton setImage:[UIImage imageNamed:@"blacksearch.png"] forState:UIControlStateNormal];
//    refreshButton.frame = CGRectMake(64, 0, 40, 40);
//    [refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
//    UIView *rightview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
//    [rightview addSubview:refreshButton];
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightview];
    
    UIButton *rightview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 37, 37/2)];
    rightview.backgroundColor=[UIColor clearColor];
    [rightview addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    

 UIButton *    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setImage:[UIImage imageNamed:@"ios7_newssearch.png"] forState:UIControlStateNormal];
    refreshButton.frame = CGRectMake(MY_MACRO_NAME? 25:10, 0, 37/2, 37/2);
    //    refreshButton.center = CGPointMake(300,20);
    [rightview addSubview:refreshButton];
    [refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem=_rightitem;
    

    
    //
    aview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?iphone5fram:iphone4fram)];
    self.view=aview;
    //广告
    
    
    
    tab_=[[UITableView alloc]initWithFrame:CGRectMake(0,0, 320, iPhone5?568-20-44-49:480-20-44-49) style:UITableViewStylePlain];
    tab_.delegate=self;
    tab_.dataSource=self;
    tab_.userInteractionEnabled=YES;
    aview.userInteractionEnabled=YES;
    self.view.userInteractionEnabled=YES;
    //    tab_.tableHeaderView = [self setSectionView];
    tab_.backgroundColor=[UIColor whiteColor];
    [aview addSubview:tab_];
    
    
    
    //下拉刷新view
    if (_refreshHeaderView == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-tab_.bounds.size.height, self.view.frame.size.width, tab_.bounds.size.height)];
		view.delegate = self;
		//[tab_pinglunliebiao addSubview:view];
		_refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    [tab_ addSubview:_refreshHeaderView];
    
    
    
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, 320, 40)];
    loadview.backgroundColor=[UIColor whiteColor];
    
    tab_.tableFooterView = loadview;
    
    
    xiala_tab=[[UITableView alloc]initWithFrame:CGRectMake(0,MY_MACRO_NAME? 44+32+20+8:44+32+8, 320,iPhone5?568-49-19-44-36-8:480-49-19-44-36-8) style:UITableViewStylePlain];
    
    xiala_tab.backgroundColor=[UIColor whiteColor];
    xiala_tab.hidden=YES;
    xiala_tab.delegate=self;
    xiala_tab.dataSource=self;
    
    
    
    
    scancelButton=[[UIButton alloc]initWithFrame:CGRectMake(270, 5, 40, 67/2)];
    // scancelButton.backgroundColor=[UIColor redColor];
    scancelButton.hidden=YES;
    //  [aview addSubview:scancelButton];
    [aview addSubview:xiala_tab];
    
    searcharrayname=[[NSMutableArray alloc]init];
    searcharrayid=[[NSMutableArray alloc]init];
    array_haha=[[NSMutableArray alloc]init];
    // 初始化语音识别控件
    NSString *initParam = [[NSString alloc] initWithFormat:
						   @"server_url=%@,appid=%@",ENGINE_URL,APPID];

    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    self.view.userInteractionEnabled=YES;
    
    if (isHaveNetWork) {
        _replaceAlertView.hidden=NO;
        [_replaceAlertView hide];
    }
    //显示广告
    
    if (!advImgV) {
        advImgV=[[AdvertisingimageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50) ];
        
    }
    advImgV.delegate=self;
    
    [self bbsSelectFind:1];
}

#pragma mark-搜索的方法
-(void)refresh:(UIButton *)sender{
    
    _slsV.hidden=NO;
    view_xialaherader.hidden=NO;
    xiala_tab.hidden=YES;
    [_searchbar becomeFirstResponder];
    scancelButton.hidden=NO;
    [self hidenavbar];
    
    if (!view_xialaherader) {
        
        
        
        
        
        
        view_xialaherader=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,IOS_VERSION>=7.0?108:88)];
        
        UIImageView *imgbc=[[UIImageView alloc]initWithFrame:CGRectMake(12,IOS_VERSION>=7.0?26:6,517/2,28)];
        imgbc.image=[UIImage imageNamed:@"ios7_newssearchbar.png"];
        
        _searchbar=[[UITextField alloc]initWithFrame:CGRectMake(37,IOS_VERSION>=7.0?26.5:12,220,58/2)];
        _searchbar.delegate=self;
        [_searchbar becomeFirstResponder];
        _searchbar.font=[UIFont systemFontOfSize:13.f];
        _searchbar.placeholder=@"输入关键词";
        _searchbar.returnKeyType=UIReturnKeySearch;
        // _searchbar.barStyle = UIBarStyleBlack;
        _searchbar.userInteractionEnabled = TRUE;
        
        
        scancelButton=[[UIButton alloc]initWithFrame:CGRectMake(263,IOS_VERSION>=7.0?26:6,111/2,61/2)];
        scancelButton.backgroundColor = [UIColor clearColor];
        scancelButton.userInteractionEnabled=YES;
//        [ scancelButton setBackgroundImage:[UIImage imageNamed:@"searchcancell.png"] forState:UIControlStateNormal];
        [scancelButton setTitle:@"取消"  forState:UIControlStateNormal];//文字
        
        [scancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [scancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [scancelButton addTarget:self action:@selector(searchcancell) forControlEvents:UIControlEventTouchUpInside];
        scancelButton.hidden=NO;
        
        
        _searchbar.userInteractionEnabled = TRUE;
        
        viewsearch=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,IOS_VERSION>=7.0?64:44)];
        [viewsearch addSubview:imgbc];
        [viewsearch addSubview:_searchbar];
        viewsearch.userInteractionEnabled=YES;
        [view_xialaherader addSubview:viewsearch];
        [viewsearch addSubview:scancelButton];
        

        _slsV=[[SliderSegmentView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7.0?64:44,320,44)];
        _slsV.delegate=self;
        [_slsV loadContent:[NSArray arrayWithObjects:@"搜索论坛",@"搜索帖子",nil]];
//        _slsV.backgroundColor=[UIColor orangeColor];
        [view_xialaherader addSubview:_slsV];
        
        view_xialaherader.backgroundColor=RGBCOLOR(247, 247, 247);
        
        [self.view addSubview:view_xialaherader];
        
        UIImageView *imgvline=[[UIImageView alloc]initWithFrame:CGRectMake(0, MY_MACRO_NAME?64:44, 320, 1)];
        imgvline.image=[UIImage imageNamed:@"line-2.png"];
        [view_xialaherader addSubview:imgvline];
        
        if (!blackcolorview) {
            blackcolorview=[[UIView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7?108: 88, 320,1000)];
            blackcolorview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8f];
            [self.view addSubview:blackcolorview];
        }
        
        
        blackcolorview.hidden=NO;


    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_searchbar resignFirstResponder];
    [self sendsearch:_searchbar.text];
    return YES;
}

#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tab_];
    
}


#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == tab_)
    {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
        NSLog(@"-----  %f",scrollView.contentOffset.y);
        //        float y = 131.5 - scrollView.contentOffset.y;
        
        selectContentOffSet[selectindex] = scrollView.contentOffset.y;
        
        if (tab_.contentOffset.y < contentSet)
        {
            selectContentOffSet[0] = scrollView.contentOffset.y;
            
            selectContentOffSet[1] = scrollView.contentOffset.y;
            
            selectContentOffSet[2] = scrollView.contentOffset.y;
        }
        
        //        if (y <= 0)
        //        {
        //            customSegment_view.frame = CGRectMake(0,0,320,34.5);
        //        }else
        //        {
        //            customSegment_view.frame = CGRectMake(0,y,320,34.5);
        //        }
        
    }
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView==tab_) {
        if (selectindex == 0)
        {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
            if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+40) && scrollView.contentOffset.y > 0)
            {
                if (![loadview.normalLabel.text isEqualToString:@"没有更多了"])
                {
                    [loadview startLoading];
                    pageCount++;
                    [self bbsSelectFind:pageCount];
                }
            }
        }
        
    }
if (scrollView==xiala_tab)
{
    
    if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+40) && scrollView.contentOffset.y > 0)
    {
        if (issearchloadsuccess==NO&&_searchbar.text.length>0) {
            if (array_searchresault.count>0) {
                xiala_tab.tableFooterView=searchloadingview;
            }else{
                xiala_tab.tableFooterView=nil;
            }
            
            issearchloadsuccess=!issearchloadsuccess;
            mysearchPage++;
            
            NSString *   string_searchurl=[NSString stringWithFormat:@"http://so.fblife.com/api/searchapi.php?query=%@&fromtype=%d&pagesize=10&formattype=json&charset=utf8&page=%d",[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],1,mysearchPage];
            [self searchbythenetework:string_searchurl];
            [searchloadingview startLoading];
            
        }
        
    }
    
}
}
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    
    
    
    pageCount = 1;
	[self bbsSelectFind:pageCount];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


//-(UIView *)setSectionView
//{
//
//}


#pragma mark-segment三种切换
- (void)setupSegmentedControl3
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl3 setBackgroundImage:backgroundImage];
    [segmentedControl3 setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl3 setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl3 setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
    
    UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"segmented-bg-pressed-left.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"segmented-bg-pressed-center.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedRight = [[UIImage imageNamed:@"segmented-bg-pressed-right.png"]
                                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];
    
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
    [buttonSocial setTitle:@"论坛精选" forState:UIControlStateNormal];
    [buttonSocial setTitleColor:[UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1]  forState:UIControlStateNormal];
    [buttonSocial setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSocial.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSocial.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    //   UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
    //    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    //    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
    //    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
    //    [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    //
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    //   UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
    
    [buttonStar setTitle:@"最近浏览" forState:UIControlStateNormal];
    [buttonStar setTitleColor:[UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1]  forState:UIControlStateNormal];
    [buttonStar setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonStar.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonStar.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
    //    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
    //    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
    //    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
    //    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 3
    UIButton *buttonSettings = [[UIButton alloc] init];
    
    [buttonSettings setTitle:@"版块收藏" forState:UIControlStateNormal];
    [buttonSettings setTitleColor:[UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1] forState:UIControlStateNormal];
    [buttonSettings setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSettings.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSettings.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonSettings setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    //    UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"settings-icon.png"];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
    //    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
    //    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
    //    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
    //    [buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [segmentedControl3 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];
}


#pragma mark -
#pragma mark AKSegmentedControlDelegate

- (void)segmentedViewController:(AKSegmentedControl *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    NSLog(@"SegmentedControl #3 : Selected Index %d", index);
    selectindex=index;
    NSLog(@"index==%d",selectindex);
    [tab_ reloadData];
    
}


//  set the textView
//  设置textview中的文字，既返回的识别结果
- (void)onUpdateTextView:(NSString *)sentence
{
	
    //	NSString *str = [[NSString alloc] initWithFormat:@"%@%@", _textView.text, sentence];
    //	_textView.text = str;
	
	NSLog(@"woshuode=%@ ",sentence);
    
    _searchbar.text=sentence;
}




#pragma mark-第三方的搜索
-(void)showsearchbar{
    
    array_allbbsbankuai=[[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]];
    array_allbbsbankuaiID=[[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
    
    if (array_allbbsbankuai.count!=0) {
        
        NSLog(@"arry-name==%@",array_haha);
        objYHCPickerView = [[YHCPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 380) withNSArray:array_allbbsbankuai];
        
        objYHCPickerView.delegate = self;
        [self.view addSubview:objYHCPickerView];
        
        [objYHCPickerView showPicker];
    }else{
    }
}
//#pragma mark-隐藏或者显示bar
//-(void)showcancel{
//
//}
//-(void)hidecancel{
//}
-(void)selectedRow:(int)row withString:(NSString *)text{
    
    NSLog(@"%d",row);
    NSLog(@"array_allbbsbankuaiID===%@",array_allbbsbankuaiID);
    if (_fendui) {
        _fendui=nil;
    }
    _fendui=[[BBSfenduiViewController alloc]init];
    
    _fendui.string_id=[array_allbbsbankuaiID objectAtIndex:row];
    
    _fendui.string_name=text;
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:_fendui animated:YES];//跳入下一个View
    
    
}

#pragma mark-选择框的delegate
//点击键盘上的search按钮时调用
-(void)hidenavbar{
    NSLog(@"%s",__FUNCTION__);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    xiala_tab.hidden=YES;
    blackcolorview.hidden=NO;
    issearchon=YES;//显示

    if (isadvertisingImghiden==YES) {
        
    }else{
        // isadvertisingImghiden=YES;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [tab_ reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView commitAnimations];
}
-(void)shownavbar{
    NSLog(@"%s",__FUNCTION__);
    issearchon=NO;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scancelButton.hidden=YES;
    xiala_tab.hidden=YES;
    blackcolorview.hidden=YES;
    view_xialaherader.hidden=YES;
    if (isadvertisingImghiden==YES) {
        
    }else{
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [tab_ reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    [_searchbar resignFirstResponder];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView commitAnimations];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{    NSLog(@"%s",__FUNCTION__);
    
    [searchBar resignFirstResponder];
    [self sendsearch:searchBar.text];
    
    
}
//输入文本实时更新时调用
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{    NSLog(@"%s",__FUNCTION__);
    
    
    xiala_tab.hidden=NO;
}

//cancel按钮点击时调用
- (void) searchBarscancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s",__FUNCTION__);
    [self shownavbar];
}
-(void)searchcancell{
    [self shownavbar];

}

//点击搜索框时调用
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{    NSLog(@"%s",__FUNCTION__);
    
    [self hidenavbar];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__FUNCTION__);
    
    // [self shownavbar];
}
-(void)appneixuanze{
    
}

#pragma mark-slideseg的代理方法
-(void)searchreaultbythetype:(NSString *)type{
    
    if (!searchloadingview) {
        searchloadingview =[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, 320, 40)];
        searchloadingview.backgroundColor=[UIColor clearColor];
        searchloadingview.normalLabel.text=@"上拉加载更多";
    }
    if ([_slsV.type isEqualToString:@"bk"]) {
        xiala_tab.tableFooterView=nil;
        
    }else{
        if (array_searchresault.count>0) {
            xiala_tab.tableFooterView=searchloadingview;
        }else{
            xiala_tab.tableFooterView=nil;
        }
    }
    [_searchbar resignFirstResponder];
    [self sendsearch:_searchbar.text];
}
#pragma mark-search方法
-(void)sendsearch:(NSString *)searchcontent
{
    
    NSLog(@"");
    //    issearchloadsuccess=NO;
    mysearchPage=1;
    [array_searchresault removeAllObjects];
    array_searchresault =[[NSMutableArray alloc]init];
    [searcharrayname removeAllObjects];
    [searcharrayid removeAllObjects];
    [xiala_tab reloadData];
    
    if (_searchbar.text.length>0) {
        if ([_slsV.type isEqualToString:@"bk"]) {
            
            
            [searcharrayname removeAllObjects];
            [searcharrayid removeAllObjects];
            if (!searchtool)
            {
                searchtool=[[downloadtool alloc]init];
            }
            [searchtool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/searchforums.php?sk=%@&formattype=json",[searchcontent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ];
            searchtool.delegate=self;
            searchtool.tag=999;
            [searchtool start];
            
        }else{
            NSString *   string_searchurl=[NSString stringWithFormat:@"http://so.fblife.com/api/searchapi.php?query=%@&fromtype=%d&pagesize=10&formattype=json&charset=utf8&page=1",[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],1];
            [self searchbythenetework:string_searchurl];
            
        }
    }
    
}

#pragma mark-搜索帖子走你
-(void)searchbythenetework:(NSString *)strurl{
    
    NSLog(@"1请求的url = %@",strurl);
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strurl]];
    __block ASIHTTPRequest * _requset = request;
    [_requset setTimeOutSeconds:120];
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dicofsearch = [request.responseData objectFromJSONData];
            NSLog(@"搜索的信息 -=-=  %@",dicofsearch);
            if ([[dicofsearch objectForKey:@"allnumbers"] integerValue]>0) {
                xiala_tab.hidden=NO;
                blackcolorview.hidden=YES;
                NSLog(@"是有数据的");
                [searchloadingview stopLoading:1];
                issearchloadsuccess=NO;
                
                NSArray *array_zanshi=[dicofsearch objectForKey:@"searchinfo"];
                for (int i=0; i<array_zanshi.count; i++) {
                    [array_searchresault addObject:[array_zanshi objectAtIndex:i]];
                    
                }
                
                NSLog(@"array_searchresault===%@",array_searchresault);
                [xiala_tab reloadData];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
}


#pragma mark-downtooldelegate
-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data
{
    @try {
        NSDictionary *_dic=[data objectFromJSONData];
        
        
        if (tool==tool_guanggao) {
            NSLog(@"再不行就晕了");
            NSDictionary *dic;
            NSArray *array=[data objectFromJSONData];
            if (array.count>0) {
                dic=[array objectAtIndex:0];
                
                
                str_guanggaourl=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
                str_guanggaolink=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
                NSLog(@"str_guanggaourl==%@",str_guanggaourl);
                [advImgV setString_urlimg:str_guanggaourl];
            }
        }
        
        
        
        
        if (tool.tag==101)
        {
            NSLog(@"dic=%@",_dic);
            [array_collect removeAllObjects];
            int issuccess=[[_dic objectForKey:@"errcode"]integerValue];
            NSArray *array_test=[_dic objectForKey:@"bbsinfo"];
            NSLog(@"array_test=%@",array_test);
            if (issuccess==0) {
                for (int i=0; i<array_test.count; i++) {
                    NSDictionary *dicinfo=[array_test objectAtIndex:i];
                    NSLog(@"===%@",[dicinfo objectForKey:@"name"]);
                    [array_collect addObject:dicinfo];
                }
            }
            
            if (selectindex ==2)
            {
                [tab_ reloadData];
            }
        }
        
        else if (tool.tag==999)
        {
            

            NSLog(@"999dic=%@",_dic);
            int errcode=[[_dic objectForKey:@"errcode"]integerValue];
            if (errcode==0) {
                xiala_tab.hidden=NO;
                blackcolorview.hidden=YES;
                NSArray *array_=[_dic objectForKey:@"bbsinfo"];
                for (NSDictionary *dicinfo in array_)
                {
                    NSString *stringname=[dicinfo objectForKey:@"name"];
                    [searcharrayname addObject:stringname];
                    
                    NSString *stringid=[dicinfo objectForKey:@"fid"];
                    [searcharrayid addObject:stringid];
                }
            }
            if (searcharrayname.count==0) {
                xiala_tab.hidden=YES;
                blackcolorview.hidden=NO;
                
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有找到相关版块" delegate:nil scancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有找到相关版块" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
                _searchbar.text=@"";
                
            }
            NSLog(@"%@,%@",searcharrayid,searcharrayname);
            
            [xiala_tab reloadData];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
   
}

-(void)downloadtoolError{
    //    UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接超时，请检查您的网络" delegate:nil scancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert_ show];
    if (!isHaveNetWork) {
        for (id aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([aviewp isEqual:[AlertRePlaceView class]])
            {
                [aviewp removeFromSuperview];
            }
        }
        [_replaceAlertView removeFromSuperview];
        _replaceAlertView=nil;
        _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
        _replaceAlertView.delegate=self;
        [[UIApplication sharedApplication].keyWindow
         addSubview:_replaceAlertView];
        _replaceAlertView.hidden=NO;
        [_replaceAlertView hide];
    }else{
        
        for (id aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([aviewp isEqual:[AlertRePlaceView class]])
            {
                [aviewp removeFromSuperview];
            }
        }

        
        [_replaceAlertView removeFromSuperview];
        _replaceAlertView=nil;
        _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"当前没有连接到网络，请检测wifi或蜂窝数据是否开启"];
        _replaceAlertView.delegate=self;
        _replaceAlertView.hidden=NO;
        [[UIApplication sharedApplication].keyWindow
         addSubview:_replaceAlertView];
        [_replaceAlertView hide];

    }

}
#pragma mark-显示框
-(void)hidefromview{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
    NSLog(@"?????");
}
-(void)hidealert{
    _replaceAlertView.hidden=YES;
    
}


#pragma mark-customSegmentDelegate

-(void)buttonClick:(int)buttonSelected
{
    if (buttonSelected==0)
    {
        loadview.hidden = NO;
        loadview.normalLabel.text = @"上拉加载更多";
        _refreshHeaderView.alpha = 1;
    }else
    {
        loadview.hidden = YES;
        _refreshHeaderView.alpha = 0;
        
        if (buttonSelected == 2 && array_collect.count ==0 )
        {
            loadview.hidden = NO;
            
            loadview.normalLabel.text = @"暂无版块收藏";
        }
        
        if (buttonSelected == 1 && array_recentlook.count == 0)
        {
            loadview.hidden = NO;
            
            loadview.normalLabel.text = @"暂无最近浏览";
        }
    }
    
    
    selectindex = buttonSelected;
    
    float contentOffset = tab_.contentOffset.y;
    
    
    //    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    //    [tab_ reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
    
    [tab_ reloadData];
    
    
    if (selectContentOffSet[buttonSelected]  == 0.000000)
    {
        if (contentOffset >=contentSet)
        {
            tab_.contentOffset = CGPointMake(0,contentSet);
        }else
        {
            tab_.contentOffset  = CGPointMake(0,contentOffset<contentSet?contentOffset:contentSet);
        }
    }else
    {
        tab_.contentOffset = CGPointMake(0,tab_.contentOffset.y>0?selectContentOffSet[buttonSelected]:0);
    }
}




#pragma mark-tableview的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==xiala_tab)
    {
        return [_slsV.type isEqualToString:@"bk"]? [searcharrayname count]:array_searchresault.count;
    }else
    {
        if (section == 0||section==1)
        {
            return 0;
        }else
        {
            int  nu = 0;
            switch (selectindex) {
                case 0:
                    nu=self.data_array.count;
                    break;
                case 2:
                    nu=[array_collect count];
                    if (array_collect.count==0)
                    {
                        //                    nu=1;
                        
                    }
                    break;
                case 1:
                    NSLog(@"最近浏览");
                    
                    nu=[array_recentlook count];
                    
                    if (array_recentlook.count==0) {
                        //                    nu=1;
                        
                    }
                    break;
                default:
                    break;
            }
            
            return nu;
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    
    
    if (tableView==xiala_tab)
    {
        return 1;
    }else
    {
        return 3;
    }
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == tab_)
    {
        if (section==0)
        {
            //return isadvertisingImghiden?nil:advImgV;
            //如果是不是搜索状态，即issearchon=no,并且isad==no，表示不隐藏广告
            if (issearchon==NO&&isadvertisingImghiden==NO) {
                return advImgV;
            }else{
                NSLog(@"我擦。。。。");
                return nil;
            }
            
        }
        
        else if(section==1){
            if (!sectionView)
            {
                sectionView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,165-88)];
                
                sectionView.backgroundColor = [UIColor whiteColor];
                
                //搜索帖子的
                
                //                _searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(5, 5, 310, 67/2)];
                //
                //                [[_searchbar.subviews objectAtIndex:0]removeFromSuperview];
                //                _searchbar.delegate=self;
                //                _searchbar.placeholder=@"搜索版块";
                //
                //                _searchbar.barStyle = UIBarStyleBlack;
                //                _searchbar.backgroundColor = [UIColor clearColor];
                //                _searchbar.delegate = self;
                //                [_searchbar setShowsscancelButton:NO animated:NO];
                //
                //                _searchbar.showsscancelButton = YES;
                //
                //                _searchbar.userInteractionEnabled = TRUE;
                //
                //                UIImageView *viewsearch=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
                //                viewsearch.image=[UIImage imageNamed:@"heardersearch@2x"];
                //                [viewsearch addSubview:_searchbar];
                //                viewsearch.userInteractionEnabled=YES;
                //                [sectionView addSubview:viewsearch];
                //
                //
                //
                //                _slsV=[[SliderSegmentView alloc]initWithFrame:CGRectMake(0, 44, 320, 44)];
                //                _slsV.delegate=self;
                //                [sectionView addSubview:_slsV];
                
                
                
                
                //版块的view
                UIView *bankuaiView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 135/2+11+11)];
                bankuaiView.backgroundColor=[UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
                [sectionView addSubview:bankuaiView];
                
                NSArray *arrayofallbbsimagesicon=[[NSArray alloc]initWithObjects:@"ios7_allbbs.png",@"ios7_diqu.png",@"ios_7chexing.png",@"ios7_zhuti.png",@"ios7_jiaoyi.png", nil];
                for (int i=0; i<5; i++)
                {
                    UIButton *button_=[[UIButton alloc]initWithFrame:CGRectMake(12+(111/2+5)*i, 11, 111/2, 135/2)];
                    [button_ setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[arrayofallbbsimagesicon objectAtIndex:i]]] forState:UIControlStateNormal];
                    [bankuaiView addSubview:button_];
                    button_.tag=100+i;
                    [button_ addTarget:self action:@selector(TurnallBBSviewcontrolloer:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
            
            
            return sectionView;
        }
        
        else
        {
            //切换精选、最近浏览、版块收藏
            
            
            if (!customSegment_view)
            {
                NSArray * exchange_array = [NSArray arrayWithObjects:@"ios7_luntanjingxuanunselect.png",@"ios7_zuijinliulanunselect.png",@"ios7_bankuaisoucangunselect.png",@"ios7_luntanjingxuanselected.png",@"ios7_zuijinliulanselected.png",@"ios7_bankuaisoucangselected.png",nil];
                
                customSegment_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,36)];
                
                customSegment_view.backgroundColor = RGBCOLOR(252, 252, 252);
                
                CustomSegmentView * customSegment = [[CustomSegmentView alloc] initWithFrame:CGRectMake((320-295)/2,(36-57/2)/2,295,57/2)];
                [customSegment setAllViewWithArray:exchange_array];

                [customSegment settitleWitharray:[NSArray arrayWithObjects:@"论坛精选",@"最近浏览",@"版块收藏", nil]];
                customSegment.delegate = self;
                
                
                [customSegment_view addSubview:customSegment];
            }
            return customSegment_view;
        }
    }else
    {
        return nil;
    }
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (tableView==xiala_tab)
    {
        if ([_slsV.type isEqualToString:@"bk"]) {
            //            cell.textLabel.text=[NSString stringWithFormat:@"%@",[searcharrayname objectAtIndex:indexPath.row]];
            //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel *label_=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 5.3, 260, 30)];
            label_.text=[NSString stringWithFormat:@"%@",[searcharrayname objectAtIndex:indexPath.row]];
            label_.font=[UIFont boldSystemFontOfSize:17];
            label_.textAlignment=UITextAlignmentLeft;
            [cell.contentView addSubview:label_];
            
        }else{
            NSLog(@"???????");
            NSDictionary *dic_ssinfo =[array_searchresault objectAtIndex:indexPath.row];
            
            SearchNewsView *_search_news=[[SearchNewsView alloc]init];
            [_search_news layoutSubviewsWithDicNewsinfo:dic_ssinfo];
            [cell.contentView addSubview:_search_news];
            
        }
    }else
    {//另外一个tableview
        if (indexPath.section==2)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            if (selectindex==0)//选择的是论坛精选
            {
                tab_.separatorColor=[UIColor clearColor];
                newscellview * orcell=[[newscellview alloc]initWithFrame:CGRectMake(0, 0, 320, 77)];
                [orcell setImv_string:[[self.data_array objectAtIndex:indexPath.row] objectForKey:@"photo"]];
                [orcell setTitle_string:[[self.data_array objectAtIndex:indexPath.row] objectForKey:@"stitle"]];
                [orcell setDate_string:[[self.data_array objectAtIndex:indexPath.row] objectForKey:@"publishtime"]];
                [orcell setDiscribe_string:[[self.data_array objectAtIndex:indexPath.row] objectForKey:@"summary"]];
                
                
                NSMutableArray *array_select=[NSMutableArray array];
                array_select=  [newslooked findbytheid:(NSString *)[[self.data_array objectAtIndex:indexPath.row] objectForKey:@"id"]];
                [orcell setGrayorblack:array_select.count];
                
                
                [cell.contentView addSubview:orcell];
            }
            if (selectindex==1)//选择的是最近浏览
            {
                NSLog(@"最近浏览");
                UILabel *label_recent=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 0, 310, 40)];
                
                if ([array_recentlook count]==0)
                {
                    //                label_recent.text=@"暂无最近浏览";
                    
                }else
                {
                    testbase *base_=[array_recentlook objectAtIndex:[array_recentlook count]-indexPath.row-1];
                    label_recent.text=base_.name;
                }
                
                label_recent.font=[UIFont systemFontOfSize:14];
                label_recent.backgroundColor=[UIColor whiteColor];
                
                UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 40, 320-24, 1)];
                viewline.backgroundColor=RGBCOLOR(240, 240, 240);
                [cell.contentView addSubview:viewline];
                
                [cell.contentView addSubview:label_recent];
                
            }
            
            if (selectindex==2)//选择的是版块收藏
            {
                UILabel *label_collection=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 0, 310, 40)];
                if (array_collect.count==0) {
                    label_collection.text=@"暂无收藏论坛";
                    label_collection.textAlignment=UITextAlignmentCenter;
                    
                }else
                {
   
                    NSDictionary *dic_info=[array_collect objectAtIndex:[array_collect count]-indexPath.row-1];
                    NSString *nameString=[NSString stringWithFormat:@"%@",[dic_info objectForKey:@"name"]];
                    label_collection.text=nameString;
                }
                
                label_collection.backgroundColor=[UIColor clearColor];
                label_collection.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:label_collection];
                
                UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 40, 320-24, 1)];
                viewline.backgroundColor=RGBCOLOR(240, 240, 240);
                [cell.contentView addSubview:viewline];

                
            }
            
        }
    }
    
    cell.contentView.backgroundColor=[UIColor whiteColor];//[UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    return cell;
}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView == tab_)
    {
        if (section == 0)
        {
            //return isadvertisingImghiden?0: 50;
            if (issearchon==NO&&isadvertisingImghiden==NO) {
                return 50;
            }else{
                return 0;
            }
            
            
        }
        else if (section==1){
            
            
            
            return 132+44-88;
        }
        else
        {
            return 36;
        }
        
    }else
    {
        return 0;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (tableView==xiala_tab) {
        
        
        
        
//
        if ([_slsV.type isEqualToString:@"bk"]) {
            height=40;
            
        }else{
        NSDictionary *dic_ssinfo =[array_searchresault objectAtIndex:indexPath.row];

        NSString *string__tcon=[NSString stringWithFormat:@"%@",[dic_ssinfo objectForKey:@"content"]];
        CGSize constraintSize = CGSizeMake(310, MAXFLOAT);
        CGSize labelSize = [string__tcon sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
            height= 30+labelSize.height+5+23;
        }
      

        

    }else{
        if (selectindex==0) {
  
            height=77;
        }else{
            height=41;
        }
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==xiala_tab) {
        if ([_slsV.type isEqualToString:@"bk"]) {
            if (_fendui) {
                _fendui=nil;
            }
            _fendui=[[BBSfenduiViewController alloc]init];
            _fendui.string_id=[searcharrayid objectAtIndex:indexPath.row];//去掉100
            _fendui.string_name=[searcharrayname objectAtIndex:indexPath.row];
//            [self shownavbar];
            
            
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            [self.navigationController pushViewController:_fendui animated:YES];//跳入下一个View
        }else{
            if (array_searchresault.count>0) {
                
                NSDictionary *dicinfoofsearchresault=[array_searchresault objectAtIndex:indexPath.row];
                bbsdetailViewController *_bbsdetail_=[[bbsdetailViewController alloc]init];
//                NSLog(@"bbstid====%@",[dicinfoofsearchresault objectForKey:@"tid"]);
                _bbsdetail_.bbsdetail_tid=[NSString stringWithFormat:@"%@",[dicinfoofsearchresault objectForKey:@"tid"]];
                [self.navigationController pushViewController:_bbsdetail_ animated:YES];
                
                
                
            }
        }
        
    }else{
        if (selectindex==0)
        {
            NSLog(@"点击的是论坛精选");
            
            
            bbsdetailViewController * bbsdetail = [[bbsdetailViewController alloc] init];
            
            bbsdetail.bbsdetail_tid = [[self.data_array objectAtIndex:indexPath.row] objectForKey:@"id"];
            
            [self.navigationController pushViewController:bbsdetail animated:YES];
            
            
            NSMutableArray *array_select=[NSMutableArray array];
            array_select= [newslooked findbytheid:(NSString *)[[self.data_array objectAtIndex:indexPath.row] objectForKey:@"id"]];
            
            
            
            NSLog(@"===sassssss==%@",array_select);
            if (array_select.count==0) {
                
                
                
                int resault=     [newslooked addid:(NSString *)[[self.data_array objectAtIndex:indexPath.row] objectForKey:@"id"]];
                
                NSLog(@"resault===%d",resault);
                
                
                
            }
            
            NSIndexPath  *indexPath_1=[NSIndexPath indexPathForRow:indexPath.row inSection:2];
            NSArray      *indexArray=[NSArray  arrayWithObject:indexPath_1];
            [tab_  reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];

            

        }
        if (selectindex==2)//收藏
        {
            if ([array_collect count]>0) {
                if (_fendui) {
                    _fendui=nil;
                }
                _fendui=[[BBSfenduiViewController alloc]init];
                NSDictionary *dic_info=[array_collect objectAtIndex:[array_collect count]-indexPath.row-1];
                NSString *string_name=[NSString stringWithFormat:@"%@",[dic_info objectForKey:@"name"]];
                NSString *string_id=[NSString stringWithFormat:@"%@",[dic_info objectForKey:@"fid"]];
                
                //                _fendui.string_id=base_.id_ofbbs;
                //                _fendui.string_name=base_.name;
                _fendui.string_name=string_name;
                _fendui.string_id=string_id;
                NSLog(@"name===%@",_fendui.string_name);
                [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
                
                
                
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                [self.navigationController pushViewController:_fendui animated:YES];//跳入下一个View
                
            }
        }
        if (selectindex==1)//最近浏览
        {
            NSLog(@"最近浏览");
            
            if (array_recentlook.count>0) {
                if (_fendui) {
                    _fendui=nil;
                }
                _fendui=[[BBSfenduiViewController alloc]init];
                
                testbase *base_=[array_recentlook objectAtIndex:[array_recentlook count]-indexPath.row-1];
                
                _fendui.string_id=base_.id_ofbbs;
                _fendui.string_name=base_.name;
                NSLog(@"name===%@",_fendui.string_name);
                
                [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
                
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                [self.navigationController pushViewController:_fendui animated:YES];//跳入下一个View
                
            }
        }
        
    }
    
}
#pragma mark-跳转到论坛总页面
-(void)TurnallBBSviewcontrolloer:(UIButton *)sender{
    NSString *string_zhuti;
    switch (sender.tag) {
        case 100:
            NSLog(@"全部");
            string_zhuti=[NSString stringWithFormat:@"quanbu"];
            break;
            
        case 101:
            NSLog(@"地区");
            string_zhuti=[NSString stringWithFormat:@"diqu"];
            
            break;
        case 102:
            NSLog(@"车型");
            string_zhuti=[NSString stringWithFormat:@"chexing"];
            
            break;
        case 103:
            NSLog(@"主题");
            string_zhuti=[NSString stringWithFormat:@"zhuti"];
            
            break;
        case 104:
            NSLog(@"商业");
            string_zhuti=[NSString stringWithFormat:@"jiaoyi"];
            
            break;
            
            
        default:
            break;
    }
    [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
    if (_allbbs) {
        _allbbs=nil;
    }
    _allbbs=[[allbbsViewController alloc]init];
    _allbbs.string_zhuti=string_zhuti;
    _allbbs.zhutitag=sender.tag;//控制进入之后的显示的
    
    _allbbs.navigationItem.title = @"论坛";
    
    //    UILabel * label_title = [[UILabel alloc] initWithFrame:CGRectMake(100,0,100,44)];
    //
    //    label_title.backgroundColor = [UIColor clearColor];
    //
    //    label_title.textColor = [UIColor whiteColor];
    //
    //    label_title.text = @"论坛";
    //
    //    label_title.textAlignment = NSTextAlignmentCenter;
    //
    //    label_title.font = [UIFont boldSystemFontOfSize:20];
    //
    //    self.navigationItem.titleView = label_title;
    
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:_allbbs animated:YES];//跳入下一个View
    
}

-(void)sendrequest{
    ASIHTTPRequest *    _request;
    [_request setTimeOutSeconds:120];
    NSString *string_authcode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    if ([string_authcode isEqualToString:@"(null)"]) {
        string_authcode=@"";
    }
    _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforums.php?type=all&formattype=json&authcode=%@",string_authcode]]];
    
    
    _request.tag=1024;
    _request.delegate=self;
    [_request startAsynchronous];
    
    
    
    
    ASIHTTPRequest *   _request1=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"diqu",string_authcode]]];
    
    _request1.tag=1025;
    [_request1 setTimeOutSeconds:120];
    _request1.delegate=self;
    [_request1 startAsynchronous];
    
    ASIHTTPRequest *   _request2=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"chexing",string_authcode]]];
    [_request2 setTimeOutSeconds:120];
    _request2.tag=1026;
    _request2.delegate=self;
    [_request2 startAsynchronous];
    
    ASIHTTPRequest *   _request3=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"zhuti",string_authcode]]];
    [_request3 setTimeOutSeconds:120];
    _request3.tag=1027;
    _request3.delegate=self;
    [_request3 startAsynchronous];
    
    ASIHTTPRequest *   _request4=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"jiaoyi",string_authcode]]];
    [_request4 setTimeOutSeconds:120];
    _request4.tag=1028;
    _request4.delegate=self;
    [_request4 startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    @try {
        NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
        array_section=[[NSMutableArray alloc]init];
        array_row=[[NSMutableArray alloc]init];
        array_detail=[[NSMutableArray alloc]init];
        array_IDrow=[[NSMutableArray alloc]init];
        array_IDdetail=[[NSMutableArray alloc]init];
        
        
        
        NSData *data=[request responseData];
        NSDictionary *dic_test=[[NSDictionary alloc]init];
        dic_test = [data objectFromJSONData];
        NSLog(@"alldic==%@",dic_test);
        [array_section removeAllObjects];
        NSArray *bbsinfo_array=[dic_test objectForKey:@"bbsinfo"];
        switch (request.tag) {
            case 1024:
            {
                
                [standarduser setObject:bbsinfo_array forKey:@"quanbuinfo"];
                
                [standarduser synchronize];
                isloadsuccess[0]=1;
                break;
            case 1025:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"diquinfo"];
                    [standarduser synchronize];
                    isloadsuccess[1]=1;
                    
                }
                break;
            case 1026:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"chexinginfo"];
                    [standarduser synchronize];
                    isloadsuccess[2]=1;
                }
                break;
            case 1027:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"zhutiinfo"];
                    [standarduser synchronize];
                    isloadsuccess[3]=1;
                }
                break;
            case 1028:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"jiaoyiinfo"];
                    [standarduser synchronize];
                    isloadsuccess[4]=1;
                }
                break;
                
                
            default:
                break;
            }
                
        }
        if (isloadsuccess[0]==1&isloadsuccess[1]==1&isloadsuccess[2]==1&isloadsuccess[3]==1&isloadsuccess[4]==1)
        {
            [standarduser setObject:@"yijingyoushujule" forKey:@"youshuju"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
}
#pragma mark-guanggao
-(void)handleImageLayout:(AsyncImageView *)tag{
    
}
-(void)testguanggao{
    tool_guanggao=[[downloadtool alloc]init];
    [tool_guanggao setUrl_string:[NSString stringWithFormat:@"http://cast.aim.yoyi.com.cn/afp/door/;ap=h20af541d85e6f6a0001;ct=js;pu=n1428243fc09e7230001;/?"]];
    [tool_guanggao start];
    tool_guanggao.delegate=self;
    
    
}
-(void )showmyadvertising{
    NSLog(@"这一次应该成了");
    isadvertisingImghiden=NO;
    [tab_ reloadData];
}
-(void)comonmyadvertising:(NSNotification*)model{
    model___=(AdvertisingModel *)model.object ;
    [advImgV setString_urlimg:[NSString stringWithFormat:@"%@",model___.str_bbshomepage]];
    NSLog(@"model___.str_bbshomepage==%@",model___.str_bbshomepage);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//对应ios6下的横竖屏问题
- (BOOL)shouldAutorotate{
    return  NO;
}
@end
