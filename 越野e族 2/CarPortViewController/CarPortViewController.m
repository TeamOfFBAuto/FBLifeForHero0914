//
//  CarPortViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "CarPortViewController.h"
#import "CarPortDetailViewController.h"
#import "CarInfo.h"
#import "CarType.h"
#import "FullyLoaded.h"
#import "Reachability.h"
#import "AlertRePlaceView.h"


#import "UIViewController+MMDrawerController.h"


@interface CarPortViewController ()
{
    AlertRePlaceView *_replaceAlertView;
    AlertRePlaceView *_replaceAlertView1;
    
    UIScrollView * myScrollView;
}

@end

@implementation CarPortViewController
@synthesize section_array = _section_array;
@synthesize car_tableview = _car_tableview;
@synthesize choose_tableview = _choose_tableview;
@synthesize choose_array = _choose_array;
@synthesize myTableView = _myTableView;
@synthesize data_array = _data_array;
@synthesize number_array = _number_array;
@synthesize silder_view = _silder_view;
@synthesize product_array = _product_array;
@synthesize the_info = _the_info;
@synthesize the_type = _the_type;
@synthesize Screening_tableView = _Screening_tableView;
@synthesize Screening_array = _Screening_array;





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)initHttpRecommendedCar
{
    if (_product_array.count > 0)
    {
        [_product_array removeAllObjects];
        [_car_tableview reloadData];
    }
    
    NSString * fullUrl = [NSString stringWithFormat:@"http://carport.fblife.com/carapi/getrecommendseries.php?page=%d&pagesize=20&datatype=json",1];
    
    ASIHTTPRequest * RecommendedCar_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    
    RecommendedCar_request.tag = 10003;
    
    RecommendedCar_request.delegate = self;
    
    RecommendedCar_request.shouldAttemptPersistentConnection = NO;
    
    [RecommendedCar_request startAsynchronous];
}




-(void)initHttpRequestWithType:(NSString *)theType
{
    //    NSString * full_url = [NSString stringWithFormat:Search_car_type,theType];//所有数据包括品牌下车系信息
    
    
    NSString * full_url = Search_all_brand;//搜索所有品牌
    
    NSLog(@"请求的url -----  %@",full_url);
    
    request_ = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:full_url]];
    
    request_.delegate = self;
    
    
    request_.tag = 10000;
    
    request_.shouldAttemptPersistentConnection = NO;
    
    [request_ startAsynchronous];
}



-(void)requestFindingCarWithPage:(int)thePage
{
    NSString * fullurl = [NSString stringWithFormat:Screening_cars,choose_type,choose_size,choose_area,choose_price,thePage];
    
    NSLog(@"筛选url:%@",fullurl);
    
    request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullurl]];
    
    request1.delegate = self;
    
    request1.tag = 10002;
    
    [request1 startAsynchronous];
}

//查找车系

-(void)requestCartype:(NSString *)brand
{
    if (request2)
    {
        [request2 cancel];
        
        request2.delegate = nil;
        
        request2 = nil;
        
        if (_product_array.count > 0)
        {
            [_product_array removeAllObjects];
            [_car_tableview reloadData];
        }
    }
    
    NSString * fullUrl = [NSString stringWithFormat:Search_cars,[brand stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"fullurl ---------  %@",fullUrl);
    
    request2 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    request2.delegate = self;
    
    request2.tag = 10001;
    
    [request2 startAsynchronous];
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    @try
    {
        NSDictionary * all_dic = [request.responseData objectFromJSONData];
        
        NSLog(@"all_dic ------  %@",all_dic);
        
        if (request.tag == 10000)
        {
            //所有品牌
            
            
            [CarInfo deleteAll];
            if (_data_array.count > 0)
            {
                [_data_array removeAllObjects];
            }
            
            if (_section_array.count > 0)
            {
                [_section_array removeAllObjects];
            }
            
            if (_number_array.count > 0)
            {
                [_number_array removeAllObjects];
            }
            
            NSMutableArray * temp_array = [all_dic objectForKey:@"carlist"];
            
            
            NSMutableArray * temp = [[NSMutableArray alloc] init];
            
            for (NSDictionary * dictionary in temp_array)
            {
                CarInfo * info = [[CarInfo alloc] init];
                
                info.brandname = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"name"]];
                
                info.brandphoto = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"photo"]];
                
                info.brandword = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"words"]];
                
                info.brandfwords = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"fwords"]];
                
                
                int result = [CarInfo addWeiBoContentWithCarInfo:info];
                
                NSLog(@"result -------  %d",result);
                
                [temp addObject:info];
            }
            
            
            
            [self exChangeData:temp];
            
            
        }else if (request.tag == 10001)
        {
            NSMutableArray * temp_array = [all_dic objectForKey:@"series"];
            
            
            if (_product_array.count > 0)
            {
                [_product_array removeAllObjects];
            }
            
            for (NSDictionary * dic1 in temp_array)
            {
                CarType * type = [[CarType alloc] initWithDictionary:dic1];
                
                [_product_array addObject:type];
            }
            
            [_car_tableview reloadData];
        }else if (request.tag == 10002)
        {
            [loadingView stopLoading:1];
            
            NSMutableArray * temp_array = [all_dic objectForKey:@"listinfo"];
            
            
            shaixuan_string = [NSString stringWithFormat:@"%@",[all_dic objectForKey:@"count"]];
            
            
            if ([shaixuan_string isEqual:[NSNull null]] || [shaixuan_string isEqualToString:@""])
            {
                shaixuan_string = @"0";
            }
            
            
            if (pageCount == 1)
            {
                if (temp_array.count == 0)
                {
                    loadingView.normalLabel.text = @"没有满足您条件的数据";
                }
                
                if (_Screening_array.count > 0)
                {
                    [_Screening_array removeAllObjects];
                }
            }else
            {
                if (temp_array.count == 0)
                {
                    loadingView.normalLabel.text = @"没有更多了";
                }
            }
            
            
            for (NSDictionary * dic1 in temp_array)
            {
                CarType * type = [[CarType alloc] initWithDictionary:dic1];
                
                [_Screening_array addObject:type];
            }
            
            [_Screening_tableView reloadData];
        }else if (request.tag == 10003)
        {
            NSString * errcode = [all_dic objectForKey:@"errno"];
            
            if ([errcode intValue] != 0)
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据加载失败,请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                
                [alert show];
                
                return;
            }
            
            NSMutableArray * temp_array = [all_dic objectForKey:@"listinfo"];
            
            if (_product_array.count > 0)
            {
                [_product_array removeAllObjects];
            }
            
            for (NSDictionary * dic1 in temp_array)
            {
                CarType * type = [[CarType alloc] initWithDictionary:dic1];
                
                [_product_array addObject:type];
            }
            
            [_car_tableview reloadData];
        }
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
}



-(void)requestFailed:(ASIHTTPRequest *)request
{
    [loadingView stopLoading:1];
    NSString *stringnetwork=[Reachability checkNetWork];
    
    if ([stringnetwork isEqualToString:@"NONetWork"])
    {
        [_replaceAlertView removeFromSuperview];
        _replaceAlertView=nil;
        _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"当前没有连接到网络，请检测wifi或蜂窝数据是否开启"];
        _replaceAlertView.delegate=self;
        _replaceAlertView.hidden=NO;
        [[UIApplication sharedApplication].keyWindow
         addSubview:_replaceAlertView];
        [_replaceAlertView hide];
        
        return;
    }
    
    
    _replaceAlertView1.hidden = NO;
    [_replaceAlertView1 hide];
    
}



-(void)exChangeData:(NSMutableArray *)temp_array
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    
    for (CarInfo * info in temp_array)
    {
        
        if (![_section_array containsObject:info.brandfwords])
        {
            [_section_array addObject:info.brandfwords];
        }
        [temp addObject:info];
    }
    
    
    for (int i = 0;i < _section_array.count;i++)
    {
        NSMutableArray * array = [[NSMutableArray alloc] init];
        
        [_data_array addObject:array];
    }
    
    
    
    for (CarInfo * info in temp)
    {
        for (int i = 0;i < _section_array.count;i++)
        {
            NSString * string = [_section_array objectAtIndex:i];
            
            if ([string isEqualToString:info.brandfwords])
            {
                [[_data_array objectAtIndex:i] addObject:info];
                break;
            }
        }
    }
    
    
    [self.myTableView reloadData];
}

-(void)hidefromview
{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
}


-(void)hidealert
{
    _replaceAlertView.hidden = YES;
    _replaceAlertView1.hidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"CarPortViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:NO];

    
    [MobClick beginEvent:@"CarPortViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    shaixuan_string = @"0";
    
    _section_array = [[NSMutableArray alloc] init];
    _data_array = [[NSMutableArray alloc] init];
    _number_array = [[NSMutableArray alloc] init];
    _product_array = [[NSMutableArray alloc] init];
    
    pageCount = 1;
    
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    
    self.view.backgroundColor=[UIColor whiteColor];
//
//    //    self.title = @"车库";
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
    
    
    
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    
//    UIBarButtonItem * space_button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space_button.width = MY_MACRO_NAME?-4:5;
//    
//    
//    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ios7logo"]];
//    leftImageView.center = CGPointMake(MY_MACRO_NAME? 18:30,22);
//    UIView *lefttttview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
//    [lefttttview addSubview:leftImageView];
//    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:lefttttview];
//    
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
//    
//    
//    UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [refreshButton setImage:[UIImage imageNamed:@"ios7_refresh4139.png"] forState:UIControlStateNormal];
//    refreshButton.frame = CGRectMake(0,0,41/2,39/2);
//    refreshButton.center = CGPointMake(300,20);
//    [refreshButton addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItems= @[space_button,[[UIBarButtonItem alloc] initWithCustomView:refreshButton]];
    
    
  
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.navigationItem.title = @"车库";

    
    self.leftImageName = @"slider_bbs_home";
    
    self.rightImageName = @"slider_bbs_me";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeOther WithRightButtonType:MyViewControllerRightbuttonTypeOther];
    
    
    
  
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    myScrollView.contentSize = CGSizeMake(320.5,0);
    
    myScrollView.delegate = self;
    
    myScrollView.bounces = YES;
    
    [self.view addSubview:myScrollView];
    
    
    seg = [[CarPortSeg alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,33)];
    
    seg.NameArray = [NSArray arrayWithObjects:@"车型",@"价格",@"国别",@"尺寸",nil];
    
    seg.type = 1;
    
    seg.delegate = self;
    
    [myScrollView addSubview:seg];
    
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, - self.myTableView.bounds.size.height, self.view.frame.size.width, self.myTableView.bounds.size.height)];
		view.delegate = self;
        //  view.backgroundColor=[UIColor redColor];
		//[tab_pinglunliebiao addSubview:view];
		_refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    
    
    
    
    CGRect rect = CGRectMake(0,33,DEVICE_WIDTH,DEVICE_HEIGHT - 33-20-44);
    
    self.myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    
    self.myTableView.bounces = YES;
    
    self.myTableView.dataSource = self;
    
    self.myTableView.tableHeaderView = _refreshHeaderView;
    
    [myScrollView addSubview:self.myTableView];
    
    
    
    NSMutableArray * cache_array = [CarInfo findAll];
    
    if (cache_array.count > 0)
    {
        [self exChangeData:cache_array];
    }else
    {
        [self refreshState];
        
        [self initHttpRequestWithType:@"brand"];
        
        [self initHttpRecommendedCar];
    }
    
    
    
    
    [self showSliderView];
    
    _Screening_tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    
    _Screening_tableView.delegate = self;
    
    _Screening_tableView.dataSource = self;
    
    _Screening_tableView.hidden = YES;
    
    [myScrollView addSubview:_Screening_tableView];
    
    
    if (IOS_VERSION >=6.0)
    {
        self.myTableView.sectionIndexColor = RGBCOLOR(139,147,150);
        
        self.myTableView.sectionIndexTrackingBackgroundColor = [UIColor lightGrayColor];
        
        if (IOS_VERSION >=7.0)
        {
            self.myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
            
            self.myTableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
            
            self.Screening_tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
            
            self.car_tableview.separatorInset = UIEdgeInsetsMake(0,0,0,0);
            
            self.choose_tableview.separatorInset = UIEdgeInsetsMake(0,0,0,0);
        }
    }
    
    
    
    
    loadingView = [[LoadingIndicatorView alloc] initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
    _Screening_tableView.tableFooterView = loadingView;
    
    
    
    _replaceAlertView1=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView1.delegate=self;
    _replaceAlertView1.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView1];
}


-(void)rightButtonTap:(UIButton *)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

-(void)leftButtonTap:(UIButton *)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


-(void)refreshData:(UIButton *)button
{
    [[FullyLoaded sharedFullyLoaded] removeAllCacheDownloads];
    
    [self initHttpRequestWithType:@"brand"];
    
    [self initHttpRecommendedCar];
}


-(void)refreshState
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    _myTableView.contentOffset=CGPointMake(0, -(DEVICE_WIDTH / 4));
    [_refreshHeaderView szksetstate];
    
    [UIView commitAnimations];
}


#pragma mark-scrollview

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _myTableView)
    {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    if (_silder_view.frame.origin.x != DEVICE_WIDTH + 2 && scrollView == _myTableView)
    {
        if (request2)
        {
            [request2 cancel];
            
            request2.delegate = nil;
            
            request2 = nil;
        }
        [UIView animateWithDuration:0.2 animations:^{
            _silder_view.frame = CGRectMake(DEVICE_WIDTH + 2,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
        } completion:^(BOOL finished)
         {
             
         }];
    }
    
    
    if (scrollView == myScrollView)
    {
        [UIView animateWithDuration:0.2 animations:^{
            _silder_view.frame = CGRectMake(DEVICE_WIDTH + 2,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
        } completion:^(BOOL finished)
         {
             
         }];
        
        if (scrollView.contentOffset.x<-40)
        {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
        }else if(scrollView.contentOffset.x>40)
        {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (scrollView == _myTableView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
    
    
    if(_Screening_tableView.contentOffset.y > (_Screening_tableView.contentSize.height - _Screening_tableView.frame.size.height+40) && _Screening_tableView.contentOffset.y > 0 && scrollView == _Screening_tableView)
    {
        if ([loadingView.normalLabel.text isEqualToString:@"加载中..."])
        {
            return;
        }
        
        pageCount ++;
        
        [loadingView startLoading];
        
        [self requestFindingCarWithPage:pageCount];
    }
}


#pragma mark-tableview

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _choose_tableview)
    {
        return 44;
    }else if(tableView == _myTableView)
    {
        return 56;
    }else
    {
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == _myTableView)
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
    }else
    {
        return 0;
    }
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == _myTableView)
    {
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            return nil;
        } else
        {
            return [NSArray arrayWithArray:_section_array];
        }
        
    }else
    {
        return nil;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _myTableView)
    {
        if (section == 0)
        {
            return @"推荐车型";
        }else
        {
            return [_section_array objectAtIndex:section-1];
        }
    }else
    {
        return nil;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _myTableView)
    {
        if (section ==0)
        {
            return 1;
        }else
        {
            return [[_data_array objectAtIndex:section-1] count];
        }
        
    }else if(tableView == _car_tableview)
    {
        return _product_array.count;
    }else if(tableView == _choose_tableview)
    {
        return _choose_array.count;
    }else
    {
        return _Screening_array.count;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _myTableView)
    {
        return _section_array.count + 1;
    }else
    {
        return 1;
    }
}

-(void)viewDidLayoutSubviews
{
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
    
    //_myTableView _car_tableview _choose_tableview _Screening_tableView
    
    NSMutableArray *tabls_arr = [NSMutableArray array];
    if (_myTableView) {
        [tabls_arr addObject:_myTableView];
    }
    if (_car_tableview) {
        [tabls_arr addObject:_car_tableview];
    }
    if (_choose_tableview) {
        [tabls_arr addObject:_choose_tableview];
    }
    
    if (_Screening_tableView) {
        [tabls_arr  addObject:_Screening_tableView];
    }
    
    
    for (UITableView *aTable in tabls_arr) {
        if (aTable && [aTable respondsToSelector:@selector(setSeparatorInset:)]) {
            [aTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if (aTable && [aTable respondsToSelector:@selector(setLayoutMargins:)]) {
            [aTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _myTableView)
    {
        NSString * identifier = @"cell";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        
        cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedBackgroundView.png"]];
        
        
        
        AsyncImageView * header_imageview = [[AsyncImageView alloc] initWithFrame:CGRectMake(10,3.5,70,35)];
        
        header_imageview.center = CGPointMake(50,28);
        
        header_imageview.delegate = self;
        
        header_imageview.backgroundColor = [UIColor clearColor];
        
        header_imageview.clipsToBounds = NO;
        
        [cell.contentView addSubview:header_imageview];
        
        
        
        UILabel * brand_label = [[UILabel alloc] initWithFrame:CGRectMake(104,10,200,40)];
        
        brand_label.textAlignment = NSTextAlignmentLeft;
        
        brand_label.textColor = [UIColor blackColor];
        
        brand_label.backgroundColor = [UIColor clearColor];
        
        brand_label.font = [UIFont systemFontOfSize:17];
        
        [cell.contentView addSubview:brand_label];
        
        
        
        if (indexPath.section == 0)
        {
            header_imageview.image = [UIImage imageNamed:@"HotCarType.png"];
            brand_label.text = @"热门车型";
        }else
        {
            CarInfo * info = [[_data_array objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
            
            [header_imageview loadImageFromURL:info.brandphoto withPlaceholdImage:[UIImage imageNamed:@"2013_1030_140x70.png"]];
            
            brand_label.text = info.brandname;
        }
        
        
        
        
        
        return cell;
    }else if(tableView == _car_tableview)
    {
        static NSString * identifier = @"cell1";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        
        CarType * type = [_product_array objectAtIndex:indexPath.row];
        
        AsyncImageView * pic_imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,5,75,50)];
        
        
        [pic_imageView loadImageFromURL:type.photo withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
        
        [cell.contentView addSubview:pic_imageView];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH / 4,10,120,20)];
        
        name.text = type.name;
        
        name.textAlignment = NSTextAlignmentLeft;
        
        name.textColor = [UIColor blackColor];
        
        name.font = [UIFont systemFontOfSize:14];
        
        name.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:name];
        
        
        
        UILabel * price_label = [[UILabel alloc] initWithFrame:CGRectMake(80,35,120,20)];
        
        price_label.textAlignment = NSTextAlignmentLeft;
        
        price_label.font = [UIFont systemFontOfSize:13];
        
        price_label.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:price_label];
        
        
        
        NSString *string_qujian=[NSString stringWithFormat:@"%.2f-%.2f万",[type.series_price_min floatValue]/10000,[type.series_price_max floatValue]/10000];
        
        price_label.text = string_qujian;
        
        price_label.textColor = RGBCOLOR(230,0,18);
        
        //        if (IOS_VERSION>=6.0)
        //        {
        //            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:string_qujian];
        //            [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(146,29,23) range:NSMakeRange(0,string_qujian.length-1)];
        //            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(string_qujian.length-1, 1)];
        //            price_label.attributedText=str;
        //        }
        
        return cell;
    }else if(tableView == _choose_tableview)
    {
        static NSString * identifier = @"cell2";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:selected_number[CurrentPage] inSection:0];
        
        [tableView selectRowAtIndexPath:firstPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        
        UILabel * text_label = [[UILabel alloc] initWithFrame:CGRectMake(1,0,300,44)];
        
        [cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_cell.png"]]];
        
        text_label.font = [UIFont systemFontOfSize:15];
        
        text_label.textAlignment = NSTextAlignmentLeft;
        
        text_label.backgroundColor = [UIColor clearColor];
        
        text_label.textColor = RGBCOLOR(66,66,66);
        
        text_label.highlightedTextColor = RGBCOLOR(109,109,109);
        
        text_label.text = [NSString stringWithFormat:@"  %@",[_choose_array objectAtIndex:indexPath.row]];
        
        [cell.contentView addSubview:text_label];
        
        return cell;
    }else
    {
        static NSString * identifier = @"cell3";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentView.backgroundColor = [UIColor whiteColor];//RGBCOLOR(242,242,242);
        cell.backgroundColor = [UIColor whiteColor];//RGBCOLOR(242,242,242);
        
        CarType * type = [_Screening_array objectAtIndex:indexPath.row];
        
        //        float cell_height = [tableView rectForRowAtIndexPath:indexPath].size.height;
        
        AsyncImageView * pic_imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(11,4.5,75,50)];
        
        [pic_imageView loadImageFromURL:type.photo withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
        
        [cell.contentView addSubview:pic_imageView];
        
        
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(100,10,150,20)];
        
        name.text = type.name;
        
        name.textAlignment = NSTextAlignmentLeft;
        
        name.textColor = [UIColor blackColor];
        
        name.font = [UIFont systemFontOfSize:14];
        
        name.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:name];
        
        
        UILabel * type_label = [[UILabel alloc] initWithFrame:CGRectMake(100,35,80,20)];
        
        type_label.text = type.size;
        
        type_label.textAlignment = NSTextAlignmentLeft;
        
        type_label.font = [UIFont systemFontOfSize:13];
        
        type_label.backgroundColor = [UIColor clearColor];
        
        type_label.textColor = RGBCOLOR(89,89,89);
        
        [cell.contentView addSubview:type_label];
        
        
        UILabel * price_label = [[UILabel alloc] initWithFrame:CGRectMake(150,35,120,20)];
        
        price_label.text = [NSString stringWithFormat:@"%.2f-%.2f万元",[type.series_price_min floatValue]/10000,[type.series_price_max floatValue]/10000];
        
        price_label.textAlignment = NSTextAlignmentLeft;
        
        price_label.textColor = [UIColor redColor];
        
        price_label.font = [UIFont systemFontOfSize:13];
        
        price_label.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:price_label];
        
        return cell;
    }
}


-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _Screening_tableView)
    {
        return 33;
    }else if (tableView == _myTableView)
    {
        return 20;
    }else
    {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _Screening_tableView)
    {
        UIImageView * back_image = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,33)];
        
        back_image.image = [UIImage imageNamed:@"clean_backimage.png"];
        
        back_image.userInteractionEnabled = YES;
        
        
        UILabel * shaixuan_label = [[UILabel alloc] initWithFrame:CGRectMake(10,0,200,33)];
        
        shaixuan_label.text = [NSString stringWithFormat:@"共%@个筛选结果",shaixuan_string];
        
        shaixuan_label.font = [UIFont systemFontOfSize:14];
        
        shaixuan_label.textAlignment = NSTextAlignmentLeft;
        
        shaixuan_label.textColor = [UIColor blackColor];
        
        shaixuan_label.backgroundColor = [UIColor clearColor];
        
        [back_image addSubview:shaixuan_label];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(DEVICE_WIDTH - 103,0,105,33);//213
        
        button.adjustsImageWhenHighlighted = NO;
        
        button.backgroundColor = [UIColor clearColor];
        
        
        [button addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[UIImage imageNamed:@"clean_selected1.png"] forState:UIControlStateNormal];
        
        [button setTitle:@"清空筛选条件" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0,1,0,0)];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0,10,0,0)];
        
        [back_image addSubview:button];
        
        return back_image;
        
    }else if (tableView == _myTableView)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,20)];
        
        view.backgroundColor = RGBCOLOR(235,235,235);
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,0,DEVICE_WIDTH,20)];
        
        label.backgroundColor = [UIColor clearColor];
        
        label.textAlignment = NSTextAlignmentLeft;
        
        label.font = [UIFont systemFontOfSize:12];
        
        if (section == 0)
        {
            label.text = @"热门车型";
        }else
        {
            label.text = [NSString stringWithFormat:@"%@",[_section_array objectAtIndex:section-1]];
        }
        
        [view addSubview:label];
        
        return view;
        
    }else
    {
        return nil;
    }
}

-(void)clean:(UITapGestureRecognizer *)sender
{
    if (request1)
    {
        [request1 cancel];
        
        request1.delegate = nil;
        
        request1 = nil;
    }
    
    for (int i = 0;i < 9;i++)
    {
        selected_number[i] = 0;
    }
    
    
    _Screening_tableView.hidden = YES;
    _choose_tableview.hidden = YES;
    choose_price = 0;
    choose_area = 0;
    choose_size = 0;
    choose_type = 0;
    pageCount = 1;
    
    shaixuan_string = @"0";
    
    
    [seg cancelButtonState];
    [seg setCountryName:@"国家"];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _myTableView)
    {
        if (indexPath.section == 0)
        {
            [self initHttpRecommendedCar];
            
            name_label.text = @"热门车型";
        }else
        {
            CarInfo * info = [[_data_array objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
            
            name_label.text = info.brandname;
            
            [self requestCartype:info.brandword];
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            _silder_view.frame = CGRectMake(DEVICE_WIDTH / 4,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
        } completion:^(BOOL finished)
         {
             
         }];
    }else if(tableView == _car_tableview)
    {
        CarType * type = [_product_array objectAtIndex:indexPath.row];
        CarPortDetailViewController *detail=[[CarPortDetailViewController alloc]init];
        detail.the_type=type;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (tableView == _choose_tableview)
    {
        if (!_Screening_array)
        {
            _Screening_array = [[NSMutableArray alloc] init];
        }
        
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        selected_number[CurrentPage] = indexPath.row;
        
        switch (CurrentPage)
        {
            case 0:
                choose_type = indexPath.row;
                
                break;
            case 1:
                choose_price = indexPath.row;
                break;
            case 2:
                choose_area = indexPath.row;
                
                [seg setCountryName:[_choose_array objectAtIndex:indexPath.row]];
                
                break;
            case 3:
                choose_size = indexPath.row;
                break;
                
            default:
                break;
        }
        
        pageCount = 1;
        
        
        [self requestFindingCarWithPage:pageCount];
        
        [loadingView startLoading];
        
        _Screening_tableView.hidden = NO;
        _choose_tableview.hidden = YES;
        
    }else
    {
        CarType * type = [_Screening_array objectAtIndex:indexPath.row];
        
        CarPortDetailViewController *detail=[[CarPortDetailViewController alloc]init];
        detail.the_type=type;
        [self.navigationController pushViewController:detail animated:YES];
    }
}




-(void)showSliderView
{
    if (!_silder_view)
    {
        _silder_view = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH + 2,self.myTableView.frame.origin.y,DEVICE_WIDTH - DEVICE_WIDTH / 4,self.myTableView.frame.size.height)];
        
        _silder_view.layer.shadowColor = [UIColor blackColor].CGColor;
        
        _silder_view.layer.shadowOffset = CGSizeMake(-1,1);
        
        _silder_view.layer.shadowRadius = 1.5;
        
        _silder_view.layer.shadowOpacity = 0.3;
        
        _silder_view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:_silder_view];
        
        
        _car_tableview = [[UITableView alloc] initWithFrame:CGRectMake(45/2,53/2+2,DEVICE_WIDTH - 80 -45/2-23/2,_silder_view.frame.size.height-53/2)];
        
        _car_tableview.backgroundColor = [UIColor whiteColor];
        
        _car_tableview.delegate = self;
        
        _car_tableview.showsHorizontalScrollIndicator = NO;
        
        _car_tableview.showsVerticalScrollIndicator = NO;
        
        _car_tableview.separatorColor = RGBCOLOR(227,227,227);
        
        _car_tableview.dataSource = self;
        
        _car_tableview.showsHorizontalScrollIndicator = NO;
        
        [_silder_view addSubview:_car_tableview];
        
        UIView * vvv = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
        
        vvv.backgroundColor = [UIColor clearColor];
        
        _car_tableview.tableFooterView = vvv;
        _car_tableview.tableHeaderView = vvv;
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(0,0,11,54);
        
        [button setBackgroundImage:[UIImage imageNamed:@"leftSliderbutton@2x.png"] forState:UIControlStateNormal];
        
        button.userInteractionEnabled = NO;
        
        [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button.center = CGPointMake(11/2,_silder_view.center.y-30);
        
        [_silder_view addSubview:button];
        
        
        name_label = [[UILabel alloc] initWithFrame:CGRectMake(45/2,0,_silder_view.frame.size.width-45/2,53/2)];
        name_label.backgroundColor = [UIColor clearColor];
        name_label.textAlignment = NSTextAlignmentLeft;
        name_label.textColor = [UIColor blackColor];
        name_label.backgroundColor = [UIColor clearColor];
        name_label.font = [UIFont systemFontOfSize:14];
        [_silder_view addSubview:name_label];
        
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(45/2,53/2,_silder_view.frame.size.width-45/2-23/2,2)];
        line_view.backgroundColor = RGBCOLOR(227,227,227);
        [_silder_view addSubview:line_view];
    }
}

-(void)handleImageLayout:(AsyncImageView *)tag
{
    
}

-(void)seccesDownLoad:(UIImage *)image
{
    
}

-(void)succesDownLoadWithImageView:(UIImageView *)imageView Image:(UIImage *)image
{
    if (image.size.width == 0 || image.size.height == 0 || image == nil)
    {
        return;
    }
    
    CGRect rect = imageView.frame;
    
    rect.size.width = 35*image.size.width/image.size.height;
    
    imageView.frame = rect;
    
    imageView.center = CGPointMake(50,28);
}


-(void)doButton:(UIButton *)button
{
    [UIView animateWithDuration:0.4 animations:^{
        _silder_view.frame = CGRectMake(DEVICE_WIDTH + 2,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


-(void)setDataViewHidden:(int)buttonindex
{
    if (request1)
    {
        [request1 cancel];
        
        request1.delegate = nil;
        
        request1 = nil;
    }
    
    shaixuan_string = @"0";
    
    for (int i = 0;i < 9;i++)
    {
        selected_number[i] = 0;
    }
    
    _Screening_tableView.hidden = YES;
    _choose_tableview.hidden = YES;
    choose_price = 0;
    choose_area = 0;
    choose_size = 0;
    choose_type = 0;
    pageCount = 1;
}

-(void)TapbuttonWithindex:(int)buttonondex type:(int)__segtype whichseg:(CarPortSeg *)_seg
{
    _choose_tableview.hidden = NO;
    
    
    _choose_tableview.contentOffset = CGPointMake(0,0);
    _Screening_tableView.contentOffset = CGPointMake(0,0);
    
    [UIView animateWithDuration:0.2 animations:^{
        _silder_view.frame = CGRectMake(DEVICE_WIDTH + 2,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
    } completion:^(BOOL finished)
     {
         
     }];
    
    CurrentPage = buttonondex;
    
    if (!_choose_array)
    {
        _choose_array = [[NSMutableArray alloc] init];
    }
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"CartypeList" ofType:@"plist"];
    
    NSDictionary * dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    _choose_array = [NSMutableArray arrayWithArray:[dictionary objectForKey:[NSString stringWithFormat:@"%d",buttonondex]]];
    
    if (!_choose_tableview)
    {
        _choose_tableview = [[UITableView alloc] initWithFrame:self.myTableView.frame style:UITableViewStylePlain];
        _choose_tableview.delegate = self;
        _choose_tableview.dataSource = self;
        _choose_tableview.separatorColor = RGBCOLOR(223,223,223);
        if (MY_MACRO_NAME)
        {
            _choose_tableview.separatorInset = UIEdgeInsetsZero;
        }
        [self.view addSubview:_choose_tableview];
        
        UIView * vvvvv = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,0)];
        self.choose_tableview.tableFooterView = vvvvv;
        
        
    }else
    {
        _choose_tableview.hidden = NO;
        
        [_choose_tableview reloadData];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    start_point = [[touches anyObject] locationInView:self.view];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint now_point = [[touches anyObject] locationInView:self.view];
    CGRect rect = _silder_view.frame;
    
    if (now_point.x > start_point.x)
    {
        rect.origin.x = DEVICE_WIDTH / 4 + (now_point.x-start_point.x);
        
        _silder_view.frame = rect;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint now_point = [[touches anyObject] locationInView:self.view];
    
    UITouch * touch = [touches anyObject];
    
    if ([touch tapCount] == 1)
    {
        if (now_point.x >100 && now_point.x < 130)
        {
            if (request2)
            {
                [request2 cancel];
                
                request2.delegate = nil;
                
                request2 = nil;
            }
            
            [UIView animateWithDuration:0.4 animations:^{
                _silder_view.frame = CGRectMake(DEVICE_WIDTH + 2,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
            } completion:^(BOOL finished)
             {
                 
             }];
            
            return;
        }
    }
    
    
    if (now_point.x >= 210)
    {
        if (request2)
        {
            [request2 cancel];
            
            request2.delegate = nil;
            
            request2 = nil;
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            _silder_view.frame = CGRectMake(DEVICE_WIDTH + 2,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
        } completion:^(BOOL finished)
         {
             
         }];
    }else if (now_point.x>100 && now_point.x<210)
    {
        [UIView animateWithDuration:0.4 animations:^{
            _silder_view.frame = CGRectMake(DEVICE_WIDTH / 4,self.myTableView.frame.origin.y,_silder_view.frame.size.width,self.myTableView.frame.size.height);
        } completion:^(BOOL finished)
         {
             
         }];
    }
}

#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
    
    
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
}



#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self initHttpRequestWithType:@"brand"];
    
    [self initHttpRecommendedCar];
    
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











