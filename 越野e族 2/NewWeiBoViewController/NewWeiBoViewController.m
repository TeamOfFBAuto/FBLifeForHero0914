//
//  NewWeiBoViewController.m
//  FbLife
//
//  Created by soulnear on 13-11-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NewWeiBoViewController.h"
#import "NewWeiBoDetailViewController.h"
#import "NewMineViewController.h"
#import "newsdetailViewController.h"
#import "bbsdetailViewController.h"
#import "ImagesViewController.h"
#import "WenJiViewController.h"
#import "LogInViewController.h"
#import "SDImageCache.h"
#import "FullyLoaded.h"
#import "UIViewController+MMDrawerController.h"
#import "ShowImagesViewController.h"


@interface NewWeiBoViewController ()
{
    UIImageView * tipView;
    UIImageView * xialaView;
    
    int currentPage;
}

@end

@implementation NewWeiBoViewController
@synthesize myTableView = _myTableView;
@synthesize myTableView1 = _myTableView1;
@synthesize myTableView2 = _myTableView2;
@synthesize refreshHeaderView1 = _refreshHeaderView1;
@synthesize refreshHeaderView2 = _refreshHeaderView2;
@synthesize refreshHeaderView3 = _refreshHeaderView3;
@synthesize data_array = _data_array;
@synthesize array1 = _array1;
@synthesize array2 = _array2;
@synthesize array3 = _array3;

@synthesize photos = _photos;

@synthesize choose_array = _choose_array;

@synthesize weibo_seg = _weibo_seg;

@synthesize selected_index = _selected_index;

@synthesize isGoBack = _isGoBack;



+ (NewWeiBoViewController *)sharedManager
{
    static NewWeiBoViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


#pragma mark-显示框
-(void)hidefromview
{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
}
-(void)hidealert
{
    _replaceAlertView.hidden=YES;
}


-(void)WeiBoViewLogIn
{
    [self LogIn];
}


-(void)ClickWeiBoCustomSegmentWithIndex:(int)index
{
    //    [UIView animateWithDuration:0.4 animations:^{
    _rootScrollView.contentOffset = CGPointMake(DEVICE_WIDTH*index,0);
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    selectedView = index;
    
    if (isCacheData[index])
    {
        [self refreshState];
        [self initHttpRequest:1 Url:index];
    }
    
    pageCount[index] = 1;
}


-(void)refreshData
{
    [self refreshState];
    
    pageCount[selectedView] = 1;
    [self initHttpRequest:1 Url:selectedView];
}


//请求数据
-(void)initHttpRequest:(int)page Url:(int)index
{
    if (weiBo_request)
    {
        [weiBo_request cancel];
        weiBo_request.delegate = nil;
        weiBo_request = nil;
    }
    
    if (page == 1)
    {
        isLoadMore = NO;
    }else
    {
        isLoadMore = YES;
    }
    
    NSString* fullURL;
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    
    
    if (index == 0)
    {
        fullURL= [NSString stringWithFormat:FB_WEIBOMYSELF_URL,authkey,page];
        
    }else if (index == 1)
    {
        fullURL= [NSString stringWithFormat:FB_WEIBOALL_URL,page];
        
    }else
    {
        fullURL= [NSString stringWithFormat:FB_WEIBOMYLIST_URL,authkey,page,@"0"];
    }
    
    NSLog(@"请求微博url---%@",fullURL);
    
    
    weiBo_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullURL]];
    
    //    weiBo_request.shouldAttemptPersistentConnection = NO;
    
    [weiBo_request setPersistentConnectionTimeoutSeconds:120];
    
    [weiBo_request setDelegate:self];
    
    weiBo_request.tag = 9999999;
    
    
    [weiBo_request startAsynchronous];
}


-(void)requestFailed:(ASIHTTPRequest *)request1111
{
    if (request1111.tag == 9999999)
    {
        NSLog(@"error == %@",request1111.error);
        
        if (pageCount[selectedView] == 1)
        {
            switch (selectedView)
            {
                case 0:
                    [_array1 removeAllObjects];
                    
                    _array1 = [FbFeed findAllByType:selectedView];
                    
                    if (_array1.count >0)
                    {
                        place_imageView1.hidden = YES;
                        [_myTableView1 reloadData];
                    }
                    
                    [loadview1 stopLoading:1];
                    
                    break;
                case 1:
                    [self.data_array removeAllObjects];
                    
                    self.data_array = [FbFeed findAllByType:selectedView];
                    
                    if (self.data_array.count > 0)
                    {
                        place_imageView2.hidden = YES;
                        [_myTableView reloadData];
                    }
                    [loadview stopLoading:1];
                    
                    break;
                case 2:
                    [_array3 removeAllObjects];
                    
                    _array3 = [FbFeed findAllByType:selectedView];
                    
                    if (_array3.count > 0)
                    {
                        place_imageView3.hidden = YES;
                        [_myTableView2 reloadData];
                    }
                    
                    [loadview3 stopLoading:1];
                    break;
                    
                default:
                    break;
            }
        }
        
        _replaceAlertView.hidden=NO;
        [_replaceAlertView hide];
    }
}


-(void)requestFinished:(ASIHTTPRequest *)request11111
{
    @try
    {
        if (request11111.tag == 9999999)
        {
            
            NSDictionary * rootObject = [[NSDictionary alloc] initWithDictionary:[request11111.responseData objectFromJSONData]];
            
            NSString *errcode =[NSString stringWithFormat:@"%@",[rootObject objectForKey:ERRCODE]];
            
            
            if ([@"0" isEqualToString:errcode])
            {
                NSDictionary* userinfo = [rootObject objectForKey:@"weiboinfo"];
                
                if (isLoadMore)
                {
                    if (selectedView == 0)
                    {
                        [loadview1 stopLoading:1];
                    }else if (selectedView == 1)
                    {
                        [loadview stopLoading:1];
                    }else
                    {
                        [loadview3 stopLoading:1];
                    }
                    
                    if ([userinfo isEqual:[NSNull null]])
                    {
                        if (selectedView == 0)
                        {
                            loadview1.normalLabel.text = @"没有更多数据了";
                        }else if (selectedView == 1)
                        {
                            loadview.normalLabel.text = @"没有更多数据了";
                        }else
                        {
                            loadview3.normalLabel.text = @"没有更多数据了";
                        }
                        
                        return;
                    }
                }else
                {
                    [FbFeed deleteAllByType:selectedView];
                    
                    if (selectedView == 1)
                    {
                        [_array2 removeAllObjects];
                        
                        [_data_array removeAllObjects];
                        
                        place_imageView2.hidden = YES;
                        
                    }else if (selectedView == 2)
                    {
                        [_array3 removeAllObjects];
                        
                        place_imageView3.hidden = YES;
                        
                    }else if (selectedView == 0)
                    {
                        [_array1 removeAllObjects];
                        
                        place_imageView1.hidden = YES;
                    }
                }
                
                
                if ([userinfo isEqual:[NSNull null]])
                {
                    //如果没有微博的话
                    NSLog(@"------------没有微博信息---------------");
                    
                    if (selectedView == 0)
                    {
                        loadview1.normalLabel.text = @"没有微博信息";
                    }else if (selectedView == 1)
                    {
                        loadview.normalLabel.text = @"没有微博信息";
                    }else
                    {
                        loadview3.normalLabel.text = @"没有微博信息";
                    }
                    
                    return;
                }else
                {
                    NSMutableArray * temp_array = [zsnApi conversionFBContent:userinfo isSave:pageCount[selectedView]>1?NO:YES WithType:selectedView];
                    
                    
                    
                    if (selectedView == 1)
                    {
                        [_array2 addObjectsFromArray:temp_array];
                        
                        [_data_array addObjectsFromArray:temp_array];
                        
                        [self.myTableView reloadData];
                        
                    }else if (selectedView == 2)
                    {
                        [_array3 addObjectsFromArray:temp_array];
                        [self.myTableView2 reloadData];
                        
                    }else if (selectedView == 0)
                    {
                        [_array1 addObjectsFromArray:temp_array];
                        [self.myTableView1 reloadData];
                    }
                }
                
                isCacheData[selectedView] = 0;
            }
            
            if (pageCount[selectedView] == 1)
            {
                switch (selectedView)
                {
                    case 0:
                        self.myTableView1.contentOffset = CGPointMake(0,0);
                        break;
                    case 1:
                        self.myTableView.contentOffset = CGPointMake(0,0);
                        break;
                    case 2:
                        self.myTableView2.contentOffset = CGPointMake(0,0);
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    if (!xiala_tab.hidden)
    {
        self.navigationController.navigationBarHidden=YES;
    }
    [XTSideMenuManager resetSideMenuRecognizerEnable:YES];

    [self.leveyTabBarController hidesTabBar:NO animated:YES];
    
    [MobClick beginEvent:@"NewWeiBoViewController"];
    
    [super viewWillAppear:YES];
}


-(void)refreshState
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    
    switch (selectedView) {
        case 0:
            _myTableView1.contentOffset=CGPointMake(0, -80);
            [_refreshHeaderView1 szksetstate];
            break;
        case 1:
            _myTableView.contentOffset=CGPointMake(0, -80);
            [_refreshHeaderView2 szksetstate];
            break;
        case 2:
            _myTableView2.contentOffset=CGPointMake(0, -80);
            [_refreshHeaderView3 szksetstate];
            break;
            
        default:
            break;
    }
    
    [UIView commitAnimations];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"NewWeiBoViewController"];
}

-(void)showLeftAndRightData
{
    if (selectedView==0)
    {
        isCacheData[1] = 1;
        
        isCacheData[2] = 1;
        
        _data_array = [FbFeed findAllByType:1];
        _array3 = [FbFeed findAllByType:2];
        
        [_myTableView reloadData];
        [_myTableView2 reloadData];
    }else if (selectedView == 1)
    {
        isCacheData[0] = 1;
        isCacheData[2] = 1;
        
        _array1 = [FbFeed findAllByType:0];
        _array3 = [FbFeed findAllByType:2];
        
        [_myTableView1 reloadData];
        
        [_myTableView2 reloadData];
        
    }else if (selectedView==2)
    {
        isCacheData[1] = 1;
        isCacheData[0] = 1;
        
        _data_array = [FbFeed findAllByType:1];
        
        _array1 = [FbFeed findAllByType:0];
        
        [_myTableView1 reloadData];
        [_myTableView reloadData];
    }
    
    
    if (_data_array.count >0)
    {
        place_imageView2.hidden = YES;
    }
    
    if (_array1.count >0)
    {
        place_imageView1.hidden = YES;
    }
    
    if (_array3.count >0)
    {
        place_imageView3.hidden = YES;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pageCount[0] = 1;
    
    pageCount[1] = 1;
    
    pageCount[2] = 1;
    
    search_user_page = 1;
    
    
    _data_array = [[NSMutableArray alloc] init];
    
    _array1 =[[NSMutableArray alloc] init];
    
    _array2 =[[NSMutableArray alloc] init];
    
    _array3 =[[NSMutableArray alloc] init];
    
    _photos = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        //iOS 5 new UINavigationBar custom background
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    BOOL authkey=[[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    
    if ([_selected_index isEqualToString:@"我的微博"])
    {
        selectedView = 2;
    }else
    {
        selectedView = authkey?0:1;
    }
    
    
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = MY_MACRO_NAME?-5:5;
//    
//    
//    UIButton * leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftbutton setImage:[UIImage imageNamed:@"slider_bbs_home"] forState:UIControlStateNormal];
//    [leftbutton addTarget:self action:@selector(leftButtonTap:) forControlEvents:UIControlEventTouchUpInside];
//    
//    leftbutton.frame = CGRectMake(MY_MACRO_NAME?0:8,0,38/2,38/2);
//    
//    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
//    
//    self.navigationItem.leftBarButtonItems = @[negativeSpacer,left];
//    
//    
//    UIButton *rightview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 37,44)];
//    rightview.backgroundColor=[UIColor clearColor];
//    [rightview addTarget:self action:@selector(rightButtonTap:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [rightview setImage:[UIImage imageNamed:@"slider_bbs_me"] forState:UIControlStateNormal];
//    
////    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    [searchButton setImage:[UIImage imageNamed:@"slider_bbs_me"] forState:UIControlStateNormal];
////    searchButton.userInteractionEnabled = NO;
////    searchButton.frame = CGRectMake(MY_MACRO_NAME?25:10,0,37,44);
////    [rightview addSubview:searchButton];
//    
//    UIBarButtonItem * right_item = [[UIBarButtonItem alloc]initWithCustomView:rightview];
//    
//    self.navigationItem.rightBarButtonItems=@[negativeSpacer,right_item];
    
    
    if (_isGoBack) {
        self.rightImageName = @"slider_bbs_me";
        [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeOther];
    }else
    {
        self.leftImageName = @"slider_bbs_home";
        self.rightImageName = @"slider_bbs_me";
        [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeOther WithRightButtonType:MyViewControllerRightbuttonTypeOther];
    }
    
    
    _weibo_seg = [[WeiBoCustomSegmentView alloc] initWithFrame:CGRectMake(15,0,200,44)];
    
    _weibo_seg.delegate = self;
    
    _weibo_seg.backgroundColor = [UIColor clearColor];
    
    [_weibo_seg setAllViewsWith:[NSArray arrayWithObjects:@"关注",@"广场",@"我的",nil] index:selectedView];
    
    self.navigationItem.titleView = _weibo_seg;
    
    
    
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-64)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.backgroundColor = [UIColor whiteColor];
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = YES;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.contentSize = CGSizeMake(960,0);
    [self.view addSubview:_rootScrollView];
    
    _rootScrollView.contentOffset = CGPointMake(selectedView*DEVICE_WIDTH,0);
    
    _userContentOffsetX = 0;
    
    
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900,DEVICE_WIDTH, 40)];
    loadview1=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900,DEVICE_WIDTH, 40)];
    loadview3=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
    //微博广场
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH,0,DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    
    if (IOS_VERSION>=7.0)
    {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    //    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = 50;
    _myTableView.tableFooterView = loadview;
    
    
    //我关注的
    _myTableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    
    if (IOS_VERSION>=7.0)
    {
        _myTableView1.separatorInset = UIEdgeInsetsZero;
    }
    
    _myTableView1.delegate = self;
    _myTableView1.dataSource = self;
    _myTableView1.sectionFooterHeight = 50;
    _myTableView1.tableFooterView = loadview1;
    
    
    _myTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH*2,0,DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    
    if (IOS_VERSION>=7.0)
    {
        _myTableView2.separatorInset = UIEdgeInsetsZero;
    }
    
    _myTableView2.delegate = self;
    _myTableView2.dataSource = self;
    _myTableView2.sectionFooterHeight = 50;
    _myTableView2.tableFooterView = loadview3;
    
    [_rootScrollView addSubview:_myTableView];
    [_rootScrollView addSubview:_myTableView1];
    [_rootScrollView addSubview:_myTableView2];
    
    
    if (_refreshHeaderView1 == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-_myTableView.bounds.size.height, self.view.frame.size.width, _myTableView.bounds.size.height)];
        
		view.delegate = self;
        
		_refreshHeaderView1 = view;
	}
	[_refreshHeaderView1 refreshLastUpdatedDate];
    
    [_myTableView1 addSubview:_refreshHeaderView1];
    
    
    if (_refreshHeaderView2 == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-_myTableView.bounds.size.height, self.view.frame.size.width, _myTableView.bounds.size.height)];
        
		view.delegate = self;
        
		_refreshHeaderView2 = view;
	}
	[_refreshHeaderView2 refreshLastUpdatedDate];
    
    [_myTableView addSubview:_refreshHeaderView2];
    
    if (_refreshHeaderView3 == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-_myTableView.bounds.size.height, self.view.frame.size.width, _myTableView.bounds.size.height)];
        
		view.delegate = self;
        
		_refreshHeaderView3 = view;
	}
	[_refreshHeaderView3 refreshLastUpdatedDate];
    
    [_myTableView2 addSubview:_refreshHeaderView3];
    
    
    
    if (!place_imageView1)
    {
        place_imageView1 = [[UIImageView alloc] initWithFrame:_myTableView.bounds];
        
        place_imageView1.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgcenterlogo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_newsbeijing.png"]];
        
        imgcenterlogo.center=place_imageView1.center;
        
        [place_imageView1 addSubview:imgcenterlogo];
        
        [_myTableView1 addSubview:place_imageView1];
    }
    
    
    
    if (!place_imageView2)
    {
        place_imageView2 = [[UIImageView alloc] initWithFrame:_myTableView.bounds];
        
        place_imageView2.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgcenterlogo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_newsbeijing.png"]];
        
        imgcenterlogo.center=place_imageView2.center;
        
        [place_imageView2 addSubview:imgcenterlogo];
        
        [_myTableView addSubview:place_imageView2];
    }
    
    if (!place_imageView3)
    {
        place_imageView3 = [[UIImageView alloc] initWithFrame:_myTableView.bounds];
        
        place_imageView3.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgcenterlogo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_newsbeijing.png"]];
        
        imgcenterlogo.center=place_imageView3.center;
        
        [place_imageView3 addSubview:imgcenterlogo];
        
        [_myTableView2 addSubview:place_imageView3];
    }
    
    
    [self refreshState];
    
    [self initHttpRequest:1 Url:selectedView];
    
    
    [self showLeftAndRightData];
    
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(85, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.center = CGPointMake(DEVICE_WIDTH/2,DEVICE_HEIGHT/2);
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    
    
    
    
    if (!searchloadingview)
    {
        searchloadingview =[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900,DEVICE_WIDTH, 40)];
        searchloadingview.backgroundColor=[UIColor clearColor];
        searchloadingview.normalLabel.text=@"上拉加载更多";
    }
    
 //搜索
    

    if (!xiala_tab)
    {
        xiala_tab=[[UITableView alloc]initWithFrame:CGRectMake(0,MY_MACRO_NAME?108:88,DEVICE_WIDTH,DEVICE_HEIGHT-19-44-36) style:UITableViewStylePlain];
        xiala_tab.backgroundColor=[UIColor whiteColor];
        xiala_tab.hidden=YES;
        
        if (IOS_VERSION>=7.0)
        {
            xiala_tab.separatorInset = UIEdgeInsetsZero;
        }
        
        xiala_tab.delegate=self;
        xiala_tab.dataSource=self;
        
        [self.view addSubview:xiala_tab];
    }
 

    
    
    //发送微博按钮
    
    UIButton * Write_blog_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Write_blog_button.frame = CGRectMake(0,0,60,60);
    
    Write_blog_button.center = CGPointMake(35,DEVICE_HEIGHT-42-64);
    
    [Write_blog_button setImage:[UIImage imageNamed:@"newWriteBlogButtonImage"] forState:UIControlStateNormal];
    
    [Write_blog_button addTarget:self action:@selector(WriteBolg:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Write_blog_button];
    
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(celeardatafirst) name:@"clean" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refreshmydata" object:nil];
    
    
    _rootScrollView.scrollsToTop = NO;
    
    xiala_tab.scrollsToTop = NO;
    
    _myTableView.scrollsToTop = NO;
    
    _myTableView1.scrollsToTop = YES;
    
    _myTableView2.scrollsToTop = NO;
    
}



-(void)rightButtonTap:(UIButton *)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

-(void)leftButtonTap:(UIButton *)sender
{
    if (_isGoBack)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}



-(void)WriteBolg:(UIButton *)sender
{//发微博
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    if (authkey.length == 0)
    {
        [self LogIn];
        
    }else
    {
        WriteBlogViewController * writeVC = [[WriteBlogViewController alloc] init];
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        [self presentViewController:writeVC animated:YES completion:NULL];
    }
    
}

/*
 
 // move view to left side
 - (void)moveToLeftSide
 {
 [self animateHomeViewToSide:CGRectMake(-320+42.5,
 self.navigationController.view.frame.origin.y,
 self.navigationController.view.frame.size.width,
 self.navigationController.view.frame.size.height)];
 }
 
 // animate home view to side rect
 - (void)animateHomeViewToSide:(CGRect)newViewRect
 {
 //    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setLeftViewHidden:NO];
 
 [UIView animateWithDuration:0.2
 animations:^{
 
 [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] moreVC]view]setFrame:CGRectMake(0,0,320,568)];
 
 self.leveyTabBarController.view.frame = newViewRect;
 }
 completion:^(BOOL finished){
 UIControl *overView = [[UIControl alloc] init];
 overView.tag = 10086;
 overView.backgroundColor = [UIColor clearColor];
 overView.frame = self.navigationController.view.frame;
 [overView addTarget:self action:@selector(restoreViewLocation) forControlEvents:UIControlEventTouchDown];
 [self.leveyTabBarController.view addSubview:overView];
 }];
 }
 
 
 - (void)restoreViewLocation
 {
 //    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setLeftViewHidden:NO];
 
 [UIView animateWithDuration:0.3
 animations:^{
 
 [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] moreVC]view]setFrame:CGRectMake(320,0,320,568)];
 
 self.leveyTabBarController.view.frame = CGRectMake(0,
 self.leveyTabBarController.view.frame.origin.y,
 self.leveyTabBarController.view.frame.size.width,
 self.leveyTabBarController.view.frame.size.height);
 }
 completion:^(BOOL finished){
 UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:10086];
 [overView removeFromSuperview];
 
 }];
 }
 
 */

-(void)refresh:(UIButton *)sender
{//搜索
    
    if (!array_weibo_search)
    {
        array_weibo_search = [[NSMutableArray alloc] init];
    }
    
    if (!array_user_search)
    {
        array_user_search = [[NSMutableArray alloc] init];
    }
    
    if (!array_searchresault)
    {
        array_searchresault = [[NSMutableArray alloc] init];
    }
    
    if (!array_cache)
    {
        array_cache = [[NSMutableArray alloc] initWithObjects:@"",@"",nil];
    }
    
    if (!temp_view)
    {
        temp_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT)];
        
        temp_view.backgroundColor = [UIColor blackColor];
        
        temp_view.alpha = 0.7;
        
        [self.view addSubview:temp_view];
    }else
    {
        temp_view.hidden = NO;
    }
    
    
    
    _slsV.hidden=NO;
    view_xialaherader.hidden=NO;
    [self hidenavbar];
    
    if (!view_xialaherader)
    {
        view_xialaherader=[[UIView alloc]initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,IOS_VERSION>=7.0?108:88)];
        
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
        
        
        cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(263,MY_MACRO_NAME?26:6,DEVICE_WIDTH-517/2,61/2)];
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.userInteractionEnabled=YES;
        [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];//文字
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(searchcancell) forControlEvents:UIControlEventTouchUpInside];
        //        [ImgV_ofsearch addSubview:cancelButton];
        
        
        viewsearch=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,IOS_VERSION>=7.0?64:44)];
        viewsearch.image=[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING];
        [viewsearch addSubview:imgbc];
        [viewsearch addSubview:_searchbar];
        [viewsearch addSubview:cancelButton];
        viewsearch.userInteractionEnabled=YES;
        [view_xialaherader addSubview:viewsearch];
        
        view_xialaherader.backgroundColor = RGBACOLOR(247,247,247,1);
        _slsV=[[SliderSegmentView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7.0?64:44,DEVICE_WIDTH,36)];
        _slsV.delegate=self;
        [_slsV loadContent:[NSArray arrayWithObjects:@"搜索微博",@"搜索用户",nil]];
        [view_xialaherader addSubview:_slsV];
        [self.view addSubview:view_xialaherader];
    }
    
    [_searchbar becomeFirstResponder];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    mysearchPage =1;
    [self WhetherOrNotRequest];
    return YES;
}

#pragma mark-选择框的delegate
//点击键盘上的search按钮时调用
-(void)hidenavbar
{
    CGRect rect;
    
    switch (selectedView) {
        case 0:
        {
            rect = _myTableView1.frame;
            
            rect.size.height += 64;
            
            _myTableView1.frame = rect;
        }
            break;
        case 1:
        {
            rect = _myTableView.frame;
            
            rect.size.height += 64;
            
            _myTableView.frame = rect;
        }
            break;
        case 2:
        {
            rect = _myTableView2.frame;
            
            rect.size.height += 64;
            
            _myTableView2.frame = rect;
        }
            break;
            
        default:
            break;
    }
    
    CGRect rect1 = _rootScrollView.frame;
    
    rect1.size.height += 64;
    
    _rootScrollView.frame = rect1;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)shownavbar
{
    
    CGRect rect;
    
    switch (selectedView) {
        case 0:
        {
            rect = _myTableView1.frame;
            
            rect.size.height -= 64;
            
            _myTableView1.frame = rect;
        }
            break;
        case 1:
        {
            rect = _myTableView.frame;
            
            rect.size.height -= 64;
            
            _myTableView.frame = rect;
        }
            break;
        case 2:
        {
            rect = _myTableView2.frame;
            
            rect.size.height -= 64;
            
            _myTableView2.frame = rect;
        }
            break;
            
        default:
            break;
    }
    
    CGRect rect1 = _rootScrollView.frame;
    
    rect1.size.height -= 64;
    
    _rootScrollView.frame = rect1;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    xiala_tab.hidden = YES;
    temp_view.hidden = YES;
    view_xialaherader.hidden=YES;
    [_searchbar resignFirstResponder];
    [search_request cancel];
    search_request.delegate = nil;
    search_request = nil;
    
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView commitAnimations];
}


-(void)WhetherOrNotRequest
{
    if (_searchbar.text.length > 0)
    {
        [_searchbar resignFirstResponder];
        
        [search_request cancel];
        search_request.delegate = nil;
        search_request = nil;
        
        if ([[array_cache objectAtIndex:_slsV.currentpage] isEqualToString:_searchbar.text])
        {
            if (_slsV.currentpage == 0 && array_weibo_search.count !=0)
            {
                [array_searchresault removeAllObjects];
                
                [array_searchresault addObjectsFromArray:array_weibo_search];
                
                [xiala_tab reloadData];
                
            }else if (_slsV.currentpage == 1 && array_user_search.count !=0)
            {
                [array_searchresault removeAllObjects];
                
                [array_searchresault addObjectsFromArray:array_user_search];
                
                [xiala_tab reloadData];
                
            }else
            {
                mysearchPage =1;
                search_user_page = 1;
                [self sendsearch:_searchbar.text];
            }
        }else
        {
            mysearchPage =1;
            search_user_page = 1;
            [array_searchresault removeAllObjects];
            [self sendsearch:_searchbar.text];
        }
        
        [array_cache replaceObjectAtIndex:_slsV.currentpage withObject:_searchbar.text];
    }
}



-(void)searchreaultbythetype:(NSString *)type
{
    if (_slsV.currentpage != current_select)
    {
        [array_searchresault removeAllObjects];
        [xiala_tab reloadData];
    }
    
    current_select = _slsV.currentpage;
    
    //    if (_slsV.currentpage == 0)
    //    {
    //        xiala_tab.tableFooterView = searchloadingview;
    //    }else
    //    {
    //        xiala_tab.tableFooterView = nil;
    //    }
    
    searchloadingview.normalLabel.text = @"上拉加载更多";
    
    xiala_tab.tableFooterView = searchloadingview;
    
    [self WhetherOrNotRequest];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"这个怎么能不走呢");
    [self WhetherOrNotRequest];
}
//输入文本实时更新时调用
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    xiala_tab.hidden=NO;
}

//cancel按钮点击时调用
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self shownavbar];
    
    [array_cache removeAllObjects];
    
    [array_user_search removeAllObjects];
    
    [array_weibo_search removeAllObjects];
}
-(void)searchcancell
{
    [self shownavbar];
}

//点击搜索框时调用
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self hidenavbar];
}



#pragma mark-开始搜索

-(void)sendsearch:(NSString *)searchcontent
{
    NSString * string_searchurl = @"";
    
    if (_searchbar.text.length>0)
    {
        if (_slsV.currentpage == 0)//搜微博
        {
            string_searchurl = [NSString stringWithFormat:Search_weiBo,[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],mysearchPage];
            
        }else//搜用户
        {
            //            string_searchurl=[NSString stringWithFormat:Search_user,[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            string_searchurl = [NSString stringWithFormat:URL_SERCH_USER,[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],search_user_page];
        }
    }
    
    NSLog(@"搜索请求的url ----  %@",string_searchurl);
    
    
    if (mysearchPage==1)
    {
        loadMoreData = NO;
    }else
    {
        loadMoreData = YES;
    }
    
    
    search_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:string_searchurl]];
    
    search_request.delegate = self;
    
    __block ASIHTTPRequest * request_ = search_request;
    
    [request_ setCompletionBlock:^{
        
        @try {
            NSDictionary * dicofsearch = [search_request.responseData objectFromJSONData];
            
            temp_view.hidden = YES;
            xiala_tab.hidden = NO;
            
            if (_slsV.currentpage == 0)
            {
                NSDictionary * rootObject = [[NSDictionary alloc] initWithDictionary:dicofsearch];
                
                NSString *errcode =[NSString stringWithFormat:@"%@",[rootObject objectForKey:ERRCODE]];
                
                
                if ([@"0" isEqualToString:errcode])
                {
                    NSDictionary* userinfo = [rootObject objectForKey:@"weiboinfo"];
                    
                    
                    if (loadMoreData)
                    {
                        [searchloadingview stopLoading:1];
                        
                        if ([userinfo isEqual:[NSNull null]])
                        {
                            searchloadingview.normalLabel.text = @"没有更多了";
                            return;
                        }
                    }
                    
                    if ([userinfo isEqual:[NSNull null]])
                    {
                        //如果没有微博的话
                        NSLog(@"------------没有微博信息---------------");
                        
                        
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到相关的微博信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                        
                        [alert show];
                        
                        xiala_tab.hidden = YES;
                        
                        temp_view.hidden = NO;
                        
                        return;
                        
                    }else
                    {
                        xiala_tab.tableFooterView = searchloadingview;
                        
                        NSMutableArray * tempArray = [zsnApi conversionFBContent:userinfo isSave:NO WithType:0];
                        
                        [array_searchresault addObjectsFromArray:tempArray];
                        
                        [array_weibo_search addObjectsFromArray:tempArray];
                        
                        [xiala_tab reloadData];
                    }
                }
            }else
            {
                _slsV.userInteractionEnabled = YES;
                
                NSString * errcode = [NSString stringWithFormat:@"%@",[dicofsearch objectForKey:@"errcode"]];
                
                [searchloadingview stopLoading:1];
                
                int the_count = [[dicofsearch objectForKey:@"count"] intValue];
                
                if (the_count == 0)
                {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到该用户,请检查用户名是否正确" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    
                    [alert show];
                    
                    xiala_tab.hidden = YES;
                    
                    temp_view.hidden = NO;
                    
                    return;
                }
                
                if ([errcode intValue]==0)
                {
                    NSDictionary * dic111 = [dicofsearch objectForKey:@"data"];
                    
                    total_count_users = [[dicofsearch objectForKey:@"count"] intValue];
                    
                    NSArray * allkeys = [dic111 allKeys];
                    
                    if (search_user_page ==1)
                    {
                        if (total_count_users/20 == 0)
                        {
                            searchloadingview.normalLabel.text = @"没有更多了";
                        }
                        
                        [array_searchresault removeAllObjects];
                        [array_user_search removeAllObjects];
                        
                        xiala_tab.contentOffset = CGPointMake(0,0);
                        
                    }else
                    {
                        
                    }
                    
                    
                    for (int i = 0;i < allkeys.count;i++)
                    {
                        NSDictionary * myDic = [dic111 objectForKey:[allkeys objectAtIndex:i]];
                        
                        PersonInfo * info2 = [[PersonInfo alloc] initWithDictionary:myDic];
                        
                        if (info2.username.length !=0)
                        {
                            [array_searchresault addObject:info2];
                            [array_user_search addObject:info2];
                        }
                    }
                    
                    [xiala_tab reloadData];
                }else
                {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到该用户,请检查用户名是否正确" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    
                    [alert show];
                    
                    xiala_tab.hidden = YES;
                    
                    temp_view.hidden = NO;
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    }];
    
    
    [request_ setFailedBlock:^{
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接超时,请检查您的网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alert show];
        
        _slsV.userInteractionEnabled = YES;
    }];
    
    
    [search_request startAsynchronous];
    
}



-(void)LogIn
{
    
    if (weiBo_request)
    {
        [weiBo_request cancel];
        weiBo_request.delegate = nil;
        weiBo_request = nil;
    }
    
    if (search_request)
    {
        [search_request cancel];
        search_request.delegate = nil;
        search_request = nil;
    }
    
    
    
    logIn = [LogInViewController sharedManager];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [self presentViewController:logIn animated:YES completion:NULL];
}


////////////////////////////////////



-(void)celeardatafirst
{
    [FbFeed deleteAllByType:0];
    [FbFeed deleteAllByType:2];
    
    isCacheData[0] = YES;
    
    isCacheData[2] = YES;
    
    pageCount[0]=1;
    pageCount[2]=1;
    
    selectedView = 1;
    
    [_weibo_seg MyButtonStateWithIndex:1];
    
    [_array1 removeAllObjects];
    [_array3 removeAllObjects];
    
    _rootScrollView.contentOffset = CGPointMake(DEVICE_WIDTH,0);
    
    [_myTableView1 reloadData];
    
    [_myTableView2 reloadData];
}


#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	
    switch (selectedView)
    {
        case 0:
            [_refreshHeaderView1 egoRefreshScrollViewDataSourceDidFinishedLoading:_myTableView1];
            break;
        case 1:
            [_refreshHeaderView2 egoRefreshScrollViewDataSourceDidFinishedLoading:_myTableView];
            break;
        case 2:
            [_refreshHeaderView3 egoRefreshScrollViewDataSourceDidFinishedLoading:_myTableView2];
            break;
            
        default:
            break;
    }
    
}

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    if (xiala_tab.hidden)
    {
        pageCount[selectedView] = 1;
        [self initHttpRequest:pageCount[selectedView] Url:selectedView];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}


#pragma mark-UIScrollViewDelegate

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return NO;
}

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_array1.count == 0)
    {
        place_imageView1.hidden = NO;
    }
    
    if (_array3.count == 0)
    {
        place_imageView3.hidden = NO;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    switch (selectedView)
    {
        case 0:
            [_refreshHeaderView1 egoRefreshScrollViewDidScroll:scrollView];
            break;
        case 1:
            [_refreshHeaderView2 egoRefreshScrollViewDidScroll:scrollView];
            break;
        case 2:
            [_refreshHeaderView3 egoRefreshScrollViewDidScroll:scrollView];
            break;
            
        default:
            break;
    }
    
    
    if (scrollView == _rootScrollView)
    {
        if (scrollView.contentOffset.x<-40)
        {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
        }else if(scrollView.contentOffset.x>680)
        {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView)
    {
        int current_page = scrollView.contentOffset.x/DEVICE_WIDTH;
        
        if (current_page == selectedView)
        {
            return;
        }else
        {
            if (current_page != 1)
            {
                BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
                
                if (!isLogIn)
                {
                    [self LogIn];
                    _rootScrollView.contentOffset = CGPointMake(DEVICE_WIDTH*selectedView,0);
                    
                    return;
                }
            }
            
            selectedView = current_page;
            
            [_weibo_seg MyButtonStateWithIndex:selectedView];
            
            if (isCacheData[selectedView])
            {
                [self initHttpRequest:pageCount[selectedView] Url:selectedView];
                
                [self refreshState];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.myTableView)
    {
        [_refreshHeaderView2 egoRefreshScrollViewDidEndDragging:scrollView];
    }else if (scrollView == _myTableView1)
    {
        [_refreshHeaderView1 egoRefreshScrollViewDidEndDragging:scrollView];
    }else if (scrollView == _myTableView2)
    {
        [_refreshHeaderView3 egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
	
    
    if(_myTableView.contentOffset.y > (_myTableView.contentSize.height - _myTableView.frame.size.height+40) && _myTableView.contentOffset.y > 0 && scrollView == _myTableView)
    {
        if (loadview.normalLabel.hidden || _data_array.count ==0)
        {
            return;
        }
        
        [loadview startLoading];
        
        pageCount[selectedView] ++;
        
        [self initHttpRequest:pageCount[selectedView] Url:selectedView];
        
    }else if(xiala_tab.contentOffset.y > (xiala_tab.contentSize.height - xiala_tab.frame.size.height+40) && xiala_tab.contentOffset.y > 0 && scrollView == xiala_tab)
    {
        if (searchloadingview.normalLabel.hidden || [_searchbar.text isEqualToString:@""] || _searchbar.text.length == 0)
        {
            return;
        }
        
        if (_slsV.currentpage == 0)
        {
            mysearchPage ++;
        }else
        {
            if (search_user_page*20>=total_count_users)
            {
                searchloadingview.normalLabel.text = @"没有更多了";
                return;
            }
            
            search_user_page++;
        }
        
        [searchloadingview startLoading];
        [self sendsearch:_searchbar.text];
        
        
    }else if(_myTableView1.contentOffset.y > (_myTableView1.contentSize.height - _myTableView1.frame.size.height+40) && _myTableView1.contentOffset.y > 0 && scrollView == _myTableView1)
    {
        if (loadview1.normalLabel.hidden || _array1.count==0)
        {
            return;
        }
        
        [loadview1 startLoading];
        
        pageCount[selectedView] ++;
        
        [self initHttpRequest:pageCount[selectedView] Url:selectedView];
    }if(_myTableView2.contentOffset.y > (_myTableView2.contentSize.height - _myTableView2.frame.size.height+40) && _myTableView2.contentOffset.y > 0 && scrollView == _myTableView2)
    {
        if (loadview3.normalLabel.hidden || _array3.count == 0)
        {
            return;
        }
        
        [loadview3 startLoading];
        
        pageCount[selectedView] ++;
        
        [self initHttpRequest:pageCount[selectedView] Url:selectedView];
    }
}


#pragma mark-UITableViewDelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num = 0;
    if (tableView == xiala_tab)
    {
        num = array_searchresault.count;
    }else if(tableView == _myTableView)
    {
        num = _data_array.count;
    }else if(tableView == _myTableView1)
    {
        num = _array1.count;
    }else if(tableView == _myTableView2)
    {
        num = _array3.count;
    }
    
    return num;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!test_cell)
    {
        test_cell = [[NewWeiBoCustomCell alloc] init];
    }
    
    float cellHeight = 0;
    
    if (tableView == xiala_tab)
    {
        if (_slsV.currentpage == 0)
        {
            FbFeed * info = [array_searchresault objectAtIndex:indexPath.row];
            
            cellHeight = [test_cell returnCellHeightWith:info WithType:0] + 20;
        }else
        {
            cellHeight = 70;
        }
    }else if(tableView == _myTableView)
    {
        FbFeed * info = [self.data_array objectAtIndex:indexPath.row];
        
        cellHeight = [test_cell returnCellHeightWith:info WithType:0] + 20;
    }else if(tableView == _myTableView1)
    {
        FbFeed * info = [_array1 objectAtIndex:indexPath.row];
        
        cellHeight = [test_cell returnCellHeightWith:info WithType:0] + 20;
    }else if(tableView == _myTableView2)
    {
        FbFeed * info = [_array3 objectAtIndex:indexPath.row];
        
        cellHeight = [test_cell returnCellHeightWith:info WithType:0] + 20;
    }
    
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == xiala_tab)
    {
        if (_slsV.currentpage == 0)
        {
            static NSString * identifier = @"cell";
            
            NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
            
            if (cell == nil)
            {
                cell = [[NewWeiBoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.delegate = self;
            }
            
            [cell setAllViewWithType:0];
            
            [cell setInfo:[array_searchresault objectAtIndex:indexPath.row] withReplysHeight:[tableView rectForRowAtIndexPath:indexPath].size.height WithType:0];
            
            return cell;
        }else
        {
            static NSString * identifier = @"identifier";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell)
            {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            for (UIView *view in cell.contentView.subviews)
            {
                [view removeFromSuperview];
            }
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //                    cell.contentView.backgroundColor = RGBCOLOR(248,248,248);
            cell.backgroundColor = [UIColor clearColor];
            
            PersonInfo * info = [array_searchresault objectAtIndex:indexPath.row];
            
            
            AsyncImageView * imagetouxiang=[[AsyncImageView alloc]initWithFrame:CGRectMake(10,10,50,50)];
            
            imagetouxiang.layer.cornerRadius = 5;
            imagetouxiang.layer.borderColor = (__bridge  CGColorRef)([UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]);
            imagetouxiang.layer.borderWidth =1.0;
            imagetouxiang.layer.masksToBounds = YES;
            
            [imagetouxiang loadImageFromURL:info.face_original withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
            
            [cell.contentView addSubview:imagetouxiang];
            
            UILabel * label_username=[[UILabel alloc]initWithFrame:CGRectMake(75,10,200, 20)];
            label_username.text = info.username;
            label_username.backgroundColor = [UIColor clearColor];
            label_username.font = [UIFont systemFontOfSize:18];
            [cell.contentView addSubview:label_username];
            
            
            
            
            NSString * location = info.city;
            if (info.city.length == 0||[info.city isEqualToString:@"(null)"])
            {
                location = @"未知";
            }
            
            UILabel * label_location=[[UILabel alloc]initWithFrame:CGRectMake(75, 40, 200, 20)];
            label_location.text = [NSString stringWithFormat:@"所在地:%@",location];
            label_location.font = [UIFont systemFontOfSize:13];
            label_location.backgroundColor = [UIColor clearColor];
            label_location.textColor = RGBCOLOR(137,137,137);
            [cell.contentView addSubview:label_location];
            
            return cell;
        }
    }else
    {
        static NSString * identifier = @"cell";
        
        NewWeiBoCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[NewWeiBoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            cell.delegate = self;
        }
        
        
        FbFeed * info;
        
        if (tableView == _myTableView)
        {
            info = [self.data_array objectAtIndex:indexPath.row];
        }else if (tableView == _myTableView1)
        {
            info = [self.array1 objectAtIndex:indexPath.row];
        }else if (tableView == _myTableView2)
        {
            info = [self.array3 objectAtIndex:indexPath.row];
        }
        
        
        [cell setAllViewWithType:0];
        
        [cell setInfo:info withReplysHeight:[tableView rectForRowAtIndexPath:indexPath].size.height WithType:0];
        
        return cell;
        
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!isLogIn)
    {
        [self LogIn];
    }else
    {
        if (_slsV.currentpage == 0)
        {
            FbFeed * info;
            
            if (tableView==xiala_tab)
            {
                info = [array_searchresault objectAtIndex:indexPath.row];
            }else if(tableView == _myTableView)
            {
                info = [self.data_array objectAtIndex:indexPath.row];
            }else if(tableView == _myTableView1)
            {
                info = [self.array1 objectAtIndex:indexPath.row];
            }else if(tableView == _myTableView2)
            {
                info = [self.array3 objectAtIndex:indexPath.row];
            }
            
            NewWeiBoDetailViewController *  detail = [[NewWeiBoDetailViewController alloc] init];
            
            detail.info = info;
            
            self.navigationController.navigationBarHidden = NO;
            
            [self.navigationController pushViewController:detail animated:YES];
            
        }else
        {
            self.navigationController.navigationBarHidden = NO;
            
            if (tableView == xiala_tab)
            {
                PersonInfo * info = [array_searchresault objectAtIndex:indexPath.row];
                [xiala_tab deselectRowAtIndexPath:[xiala_tab indexPathForSelectedRow] animated:YES];
                NewMineViewController * mine = [[NewMineViewController alloc] init];
                mine.uid = info.uid;
                [self.navigationController pushViewController:mine animated:YES];
            }else
            {
                FbFeed * info;
                
                if(tableView == _myTableView)
                {
                    info = [self.data_array objectAtIndex:indexPath.row];
                }else if(tableView == _myTableView1)
                {
                    info = [self.array1 objectAtIndex:indexPath.row];
                }else if(tableView == _myTableView2)
                {
                    info = [self.array3 objectAtIndex:indexPath.row];
                }
                
                NewWeiBoDetailViewController *  detail = [[NewWeiBoDetailViewController alloc] init];
                
                detail.info = info;
                
                self.navigationController.navigationBarHidden = NO;
                
                [self.navigationController pushViewController:detail animated:YES];
            }
        }
    }
}


#pragma mark-评论转发成功

-(void)ForwardingSuccessWihtTid:(NSString *)theTid IndexPath:(int)theIndexpath SelectView:(int)theselectview WithComment:(BOOL)isComment
{
    FbFeed * _feed;
    
    switch (theselectview)
    {
        case 0:
        {
            _feed = [_array1 objectAtIndex:theIndexpath];
            
            _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
            
            if (isComment)
            {
                _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
                
                [FbFeed updateReplys:_feed.replys WithTid:theTid];
            }
            
            [_array1 replaceObjectAtIndex:theIndexpath withObject:_feed];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
            
            NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView1 cellForRowAtIndexPath:indexPath];
            
            [cell setReplys:_feed.replys ForWards:_feed.forwards];
            
            [FbFeed updateForwards:_feed.forwards WithTid:theTid];
        }
            break;
        case 1:
        {
            _feed = [_array2 objectAtIndex:theIndexpath];
            
            _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
            
            if (isComment)
            {
                _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
                
                [FbFeed updateReplys:_feed.replys WithTid:theTid];
            }
            
            
            [_array2 replaceObjectAtIndex:theIndexpath withObject:_feed];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
            
            NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView cellForRowAtIndexPath:indexPath];
            
            [cell setReplys:_feed.replys ForWards:_feed.forwards];
            
            [FbFeed updateForwards:_feed.forwards WithTid:theTid];
        }
            break;
        case 2:
        {
            _feed = [_array3 objectAtIndex:theIndexpath];
            
            _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
            
            if (isComment)
            {
                _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
                
                [FbFeed updateReplys:_feed.replys WithTid:theTid];
            }
            
            [_array3 replaceObjectAtIndex:theIndexpath withObject:_feed];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
            
            NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView2 cellForRowAtIndexPath:indexPath];
            
            [cell setReplys:_feed.replys ForWards:_feed.forwards];
            
            [FbFeed updateForwards:_feed.forwards WithTid:theTid];
        }
            break;
            
        default:
            break;
    }
}

-(void)commentSuccessWihtTid:(NSString *)theTid IndexPath:(int)theIndexpath SelectView:(int)theselectview withForward:(BOOL)isForward
{
    FbFeed * _feed;
    
    switch (theselectview)
    {
        case 0:
        {
            _feed = [_array1 objectAtIndex:theIndexpath];
            
            _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
            
            if (isForward)
            {
                _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
                
                [FbFeed updateForwards:_feed.forwards WithTid:theTid];
            }
            
            [_array1 replaceObjectAtIndex:theIndexpath withObject:_feed];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
            
            NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView1 cellForRowAtIndexPath:indexPath];
            
            [cell setReplys:_feed.replys ForWards:_feed.forwards];
            
            [FbFeed updateReplys:_feed.replys WithTid:theTid];
            
            
        }
            break;
        case 1:
        {
            _feed = [_array2 objectAtIndex:theIndexpath];
            
            _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
            
            if (isForward)
            {
                _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
                
                [FbFeed updateForwards:_feed.forwards WithTid:theTid];
            }
            
            [_array2 replaceObjectAtIndex:theIndexpath withObject:_feed];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
            
            NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView cellForRowAtIndexPath:indexPath];
            
            [cell setReplys:_feed.replys ForWards:_feed.forwards];
            
            [FbFeed updateReplys:_feed.replys WithTid:theTid];
        }
            break;
        case 2:
        {
            _feed = [_array3 objectAtIndex:theIndexpath];
            
            _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
            
            if (isForward)
            {
                _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
                
                [FbFeed updateForwards:_feed.forwards WithTid:theTid];
            }
            
            [_array3 replaceObjectAtIndex:theIndexpath withObject:_feed];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
            
            NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView2 cellForRowAtIndexPath:indexPath];
            
            [cell setReplys:_feed.replys ForWards:_feed.forwards];
            
            [FbFeed updateReplys:_feed.replys WithTid:theTid];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark-NewWeiBoCustomCellDelegate

-(void)showOriginalWeiBoContent:(NSString *)theTid
{
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!isLogIn)
    {
        [self LogIn];
        return;
    }
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=content&tid=%@&fromtype=b5eeec0b&authkey=%@&page=1&fbtype=json",theTid,authkey];
    
    NSLog(@"1请求的url = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try
        {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            NSLog(@"个人信息 -=-=  %@",dic);
            
            NSString *errcode =[NSString stringWithFormat:@"%@",[dic objectForKey:ERRCODE]];
            
            if ([@"0" isEqualToString:errcode])
            {
                NSDictionary * userInfo = [dic objectForKey:@"weiboinfo"];
                
                if ([userInfo isEqual:[NSNull null]])
                {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该篇微博不存在" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    [alert show];
                    
                    return;
                }else
                {
                    FbFeed * obj = [[FbFeed alloc]init];
                    
                    obj.tid = theTid;
                    
                    obj = [[zsnApi conversionFBContent:userInfo isSave:NO WithType:0] objectAtIndex:0];
                    
                    NewWeiBoDetailViewController * detail = [[NewWeiBoDetailViewController alloc] init];
                    
                    detail.info=obj;
                    
                    [self.navigationController pushViewController:detail animated:YES];
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request cancel];
    }];
    
    [_requset startAsynchronous];
    
}

-(void)presentToFarwardingControllerWithInfo:(FbFeed *)info WithCell:(NewWeiBoCustomCell *)theCell
{
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!isLogIn)
    {
        [self LogIn];
        return;
    }
    
    NSIndexPath * theIndexpath;
    
    switch (selectedView)
    {
        case 0:
            theIndexpath = [_myTableView1 indexPathForCell:theCell];
            break;
        case 1:
            theIndexpath = [_myTableView indexPathForCell:theCell];
            break;
        case 2:
            theIndexpath = [_myTableView2 indexPathForCell:theCell];
            break;
            
        default:
            break;
    }
    
    
    ForwardingViewController * forward = [[ForwardingViewController alloc] init];
    forward.info = info;
    forward.delegate = self;
    forward.theIndexPath = theIndexpath.row;
    forward.theSelectViewIndex = selectedView;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self presentViewController:forward animated:YES completion:NULL];
}

-(void)presentToCommentControllerWithInfo:(FbFeed *)info WithCell:(NewWeiBoCustomCell *)theCell
{
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!isLogIn)
    {
        [self LogIn];
        return;
    }
    
    NSIndexPath * theIndexpath;
    
    switch (selectedView)
    {
        case 0:
            theIndexpath = [_myTableView1 indexPathForCell:theCell];
            break;
        case 1:
            theIndexpath = [_myTableView indexPathForCell:theCell];
            break;
        case 2:
            theIndexpath = [_myTableView2 indexPathForCell:theCell];
            break;
            
        default:
            break;
    }
    
    NewWeiBoCommentViewController * forward = [[NewWeiBoCommentViewController alloc] init];
    forward.info = info;
    forward.delegate = self;
    forward.tid = info.tid;
    forward.theIndexPath = theIndexpath.row;
    forward.theSelectViewIndex = selectedView;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [self presentViewController:forward animated:YES completion:NULL];
}


-(void)showVideoWithUrl:(NSString *)theUrl
{
    fbWebViewController * web = [[fbWebViewController alloc] init];
    
    web.urlstring = theUrl;
    
    [self.navigationController pushViewController:web animated:YES];
}


-(void)clickHeadImage:(NSString *)uid
{
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!isLogIn)
    {
        [self LogIn];
    }else
    {
        NewMineViewController * mine = [[NewMineViewController alloc] init];
        
        mine.uid = uid;
        
        [self.navigationController pushViewController:mine animated:YES];
    }
}


-(void)clickUrlToShowWeiBoDetailWithInfo:(FbFeed *)info WithUrl:(NSString *)theUrl isRe:(BOOL)isRe
{
    NSString * string = isRe?info.rsort:info.sort;
    
    NSString * sortId = isRe?info.rsortId:info.sortId;
    
    NSLog(@"我艹 ------  %@ ---  %d",sortId,isRe);
    
    
    if ([string intValue] == 7 || [string intValue] == 6 || [string intValue] == 8)//新闻
    {
        newsdetailViewController * news = [[newsdetailViewController alloc] initWithID:sortId];
        [self setHidesBottomBarWhenPushed:YES];
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        [self.navigationController pushViewController:news animated:YES];
        [self setHidesBottomBarWhenPushed: NO];
        
    }else if ([string intValue] == 4 || [string intValue] == 5)//帖子
    {
        bbsdetailViewController * bbs = [[bbsdetailViewController alloc] init];
        bbs.bbsdetail_tid = sortId;
        if ([string intValue] == 5)
        {
            bbs.bbsdetail_tid = info.sortId;
        }
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bbs animated:YES];
        [self setHidesBottomBarWhenPushed: NO];
        
    }else if ([string intValue] == 3)
    {
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        if (isLogIn)
        {
            ImagesViewController * images = [[ImagesViewController alloc] init];
            images.tid = isRe?info.rphoto.aid:info.photo.aid;
            
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:images animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }else{
            
            [self LogIn];
        }
        
        
    }else if ([string intValue] == 2)
    {
        
        WenJiViewController * wenji = [[WenJiViewController alloc] init];
        
        wenji.bId = sortId;
        
        [self setHidesBottomBarWhenPushed:YES];
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        
        [self.navigationController pushViewController:wenji animated:YES];
        
        [self setHidesBottomBarWhenPushed:NO];
    }else if ([string intValue] ==15)
    {//跳到新版图集界面
        ShowImagesViewController * imageV = [[ShowImagesViewController alloc] init];
        
        imageV.id_atlas = sortId;
        
        [self.navigationController pushViewController:imageV animated:YES];
        
    }else
    {
        NewWeiBoDetailViewController * detail = [[NewWeiBoDetailViewController alloc] init];
        
        detail.info = info;
        
        [self setHidesBottomBarWhenPushed:YES];
        
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        
        [self.navigationController pushViewController:detail animated:YES];
        
        [self setHidesBottomBarWhenPushed:NO];
    }
}

-(void)showClickUrl:(NSString *)theUrl WithFBFeed:(FbFeed *)info;
{
    fbWebViewController *fbweb=[[fbWebViewController alloc]init];
    
    fbweb.urlstring = theUrl;
    
    [self.navigationController pushViewController:fbweb animated:YES];
}

-(void)showAtSomeBody:(NSString *)theUrl WithFBFeed:(FbFeed *)info
{
    NSLog(@"theUrl ------   %@",theUrl);
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!isLogIn)
    {
        [self LogIn];
    }else
    {
        NewMineViewController * people = [[NewMineViewController alloc] init];
        
        if ([theUrl rangeOfString:@"fb://PhotoDetail/id="].length)
        {
            people.uid = [theUrl stringByReplacingOccurrencesOfString:@"fb://PhotoDetail/id=" withString:@""];
        }else if([theUrl rangeOfString:@"fb://atSomeone@/"].length)
        {
            people.uid = [theUrl stringByReplacingOccurrencesOfString:@"fb://atSomeone@/" withString:@""];
        }else
        {
            people.uid = info.ruid;
        }
        
        [self.navigationController pushViewController:people animated:YES];
    }
}

-(void)showImage:(FbFeed *)info isReply:(BOOL)isRe WithIndex:(int)index
{
    NSString * sort = isRe?info.rsort:info.sort;
    [_photos removeAllObjects];
    
    if ([sort isEqualToString:@"3"])
    {
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        if (!isLogIn)
        {
            [self LogIn];
            return;
        }
    }
    
    
    NSString * image_string = isRe?info.rimage_original_url_m:info.image_original_url_m;
    
    NSArray * array = [image_string componentsSeparatedByString:@"|"];
    
    for (NSString * string in array)
    {
        NSString * url_string = [string stringByReplacingOccurrencesOfString:@"_s." withString:@"_b."];
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:url_string]]];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    browser.displayActionButton = YES;
    
    NSString * titleString = info.photo_title;
    
    browser.title_string = titleString;
    
    [browser setInitialPageIndex:index];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [self presentViewController:browser animated:YES completion:NULL];
}



#pragma mark - MWPhotoBrowserDelegate



- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}


-(void)dealloc
{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    NSLog(@"didReceiveMemoryWarning");
    
    
    [[SDImageCache sharedImageCache] clearMemory];
    
    [[FullyLoaded sharedFullyLoaded] emptyCache];
    
    
}

@end





























