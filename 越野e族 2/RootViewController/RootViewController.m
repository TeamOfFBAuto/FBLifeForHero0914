//
//  RootViewController.m
//  FbLife
//
//  Created by szk on 13-2-21.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "RootViewController.h"
#import "recommend.h"
#import "JSONKit.h"
#import "personal.h"
#import "newscellview.h"
#import "loadingview.h"
#import "ASIHTTPRequest.h"
#import "newsdetailViewController.h"
#import "testbase.h"
#import "LeveyTabBarController.h"
#import "NewWeiBoDetailViewController.h"
#import "ImagesViewController.h"
#import "WenJiViewController.h"
#import "bbsdetailViewController.h"
#import "UIViewController+MMDrawerController.h"


//101 推荐新闻的请求
//102 普通新闻的请求
//104 加载更多数据
@interface RootViewController ()
{
    recommend *_recell;
    loadingview *_loadingview;
    UIView *freshview;
    newscellview *orcell;
    newsimage_scro *imagesc;
    //    newsdetailViewController *comment_;
    UIButton * refreshButton;
    AlertRePlaceView *_replaceAlertView;
    
    WenJiViewController * wenji;
    UIView *halfblackView;
}

@end

@implementation RootViewController
@synthesize titleView = _titleView;
@synthesize image_scro=_image_scro;
@synthesize category_string=_category_string;
@synthesize pages;
@synthesize photos = _photos;
@synthesize Replys_photos = _Replys_photos;
@synthesize array_searchresault = _array_searchresault;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


-(void)dealloc{



}


-(void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number{
    NSString *numberKey = @"__ct__";
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    [mutableDictionary setObject:[number stringValue] forKey:numberKey];
    [MobClick event:eventId attributes:mutableDictionary];
    
    [MobClick event:@"首页" acc:10];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    //
   
    //  [self testmymodelofadvertising];
    
    //self.tabBarController.tabBar.hidden=NO;
}



-(void)viewWillDisappear:(BOOL)animated{
    
    
    
    
    
    
    [MobClick endEvent:@"RootViewController"];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    [[NSUserDefaults standardUserDefaults] setObject:timeString forKey:[NSString stringWithFormat:@"%@timechange",[personal place: self.category_string ]]];
    
    
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:YES];
    
    //    for (UIView *_viewhalf in [UIApplication sharedApplication].keyWindow.subviews) {
    //        [_viewhalf removeFromSuperview];
    //    }
    
    //
    //    UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"dismiss" message:nil delegate:nil cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
    //    [alert_ show];
    //
    //    if (!halfblackView) {
    //        halfblackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, iPhone5?568:480)];
    //
    //        halfblackView.backgroundColor=[UIColor blackColor];
    //        halfblackView.userInteractionEnabled=NO;
    //        halfblackView.alpha=0.8;
    //        halfblackView.window.windowLevel=UIWindowLevelAlert-1;
    //        [[UIApplication sharedApplication].keyWindow
    //         addSubview:halfblackView];
    //
    //    }
    
    
    if (searchheaderview) {
        self.navigationController.navigationBarHidden=!searchheaderview.hidden;
        
    }
    
    
    [MobClick beginEvent:@"RootViewController"];
    
    [self umengEvent:@"首页" attributes:@{@"name" : @"iPad",@"color" : @"black"} number:@(10)];
    
    
    NSDictionary *dict = @{@"book" : @"type", @"quantity" : @"3"};
    [MobClick event:@"首页" attributes:dict];
    for (id aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([aviewp isEqual:[AlertRePlaceView class]])
        {
            [aviewp removeFromSuperview];
        }
    }
    
    
    
    [self.leveyTabBarController hidesTabBar:NO animated:YES];
    self.view.backgroundColor=RGBCOLOR(243, 243, 243);
    
    NSString *stringnewsid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"newsid"]];
    NSLog(@"newsid%@",stringnewsid);
    if (![stringnewsid isEqualToString:@"(null)"]&&stringnewsid.length!=0)
    {
        NSLog(@"newsid1%@",stringnewsid);
        
        newsdetailViewController *    _comment_=[[newsdetailViewController alloc]init];
        
        NSLog(@"222");
        _comment_.string_Id=stringnewsid;
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        [self.navigationController pushViewController:_comment_ animated:NO];//跳入下一个View
    }
    NSString *stringversion=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"version"]];
    NSLog(@"stringversion========%@",stringversion);
    if (stringversion.length!=0&&![stringversion isEqualToString:NOW_VERSION]&&![stringversion isEqualToString:@"(null)"])
    {
        
        NSLog(@"stringversion1========%@",stringversion);
        
        NSString *stringversion=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"content"]];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:stringversion delegate:self cancelButtonTitle:@"立即升级" otherButtonTitles:@"稍后提示",nil];
        
        alert.delegate = self;
        
        alert.tag = 10000;
        
        [alert show];
        
        
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newsid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"version"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"content"];
    
    
    //每次进来判断时间
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *stringoldtime=[NSString stringWithFormat:@"%@",[user objectForKey:[NSString stringWithFormat:@"%@timechange",[personal place: self.category_string ]]]];
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    
    if ([self.category_string isEqualToString:@"(null)"]||self.category_string.length==0) {
        self.category_string=[[NSString alloc]initWithFormat:@"zuixin"];
    }
    
    
//    if (![stringoldtime isEqualToString:@"(null)"]) {
//        
//        float timecha=-[stringoldtime floatValue]+[timeString floatValue];
//        
//        NSLog(@"时间差为==%f",timecha);
//        if (timecha<600) {
//            NSLog(@"10分钟之内");
//            // [self getdatafromcache];
//        }else{
//            NSLog(@"超过10分钟了");
//            
//            NSString *stringnetwork=[Reachability checkNetWork ];
//            
//            // NSLog(@"当前的网络为%@",stringnetwork);
//            if ([stringnetwork isEqualToString:@"NONetWork"]) {
//                [self HaveNoNetWork];
//                
//            }else{
//                
//                
//               // [self showguanggao];
//               // [self refreshnormal];
//                [self sendrecommedrequest];
//            }
//            
//        }
//        
//    }else{
//        NSLog(@"第一次程序启动");
//        
//    }
    if (isadvertisingoadsuccess==NO) {
        
        
        NSString *stringnetwork=[Reachability checkNetWork ];
        
        // NSLog(@"当前的网络为%@",stringnetwork);
        if ([stringnetwork isEqualToString:@"NONetWork"]) {
            
        }else{
            
            
           // [self testmymodelofadvertising];
        }
        
        
        
    }
    
}
#pragma mark-通知

-(void)processingPushWithdic:(NSDictionary *)dicofpush{
    NSDictionary *dic_pushinfo=dicofpush;
    
    
    
    
    int type=[[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"type"] integerValue];
    NSLog(@"dic===%@=======type====%d",dic_pushinfo,type);
    switch (type) {
        case 2:
        {
            [self pushtoxitongmessage];
        }
            break;
        case 3:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 4:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 5:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 6:
        {
            [self pushtopersonalmessage];
        }
            break;
        case 7:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 9:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 20:
        {
            NSString *string_tid=[NSString stringWithFormat:@"%@",[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"tid"]];
            [self pushtobbsdetailwithid:string_tid];
        }
            break;
        case 21:
        {
            NSString *string_tid=[NSString stringWithFormat:@"%@",[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"tid"]];
            [self pushtobbsdetailwithid:string_tid];
            
        }
            break;
            
            
        default:
            break;
    }
    NSLog(@"==note==%@",dic_pushinfo);
}
-(void) showOutput:(NSNotification *)note
{
    NSLog(@"%@",note);
    
    //    pushinfo===={
    //        aps =     {
    //            alert = "\U60a8\U6709[1]\U6761\U5f15\U7528\U56de\U590d\U901a\U77e5";
    //            badge = 2;
    //            sound = default;
    //            tid = 3004018;
    //            type = 21;
    //        };
    //    }
    /*
     有关消息推送的相关说明：
     2 ：文集评论
     3 ：画廊评论
     4 ：微博评论
     5 ：微博@
     6 ：私信
     7 ：文集@
     9 ：关注
     20 ：主贴回复
     21 ：引用回复
     */
    NSDictionary *dic_pushinfo=(NSDictionary *)note.object;
    
    
    int type=[[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"type"] integerValue];
    NSLog(@"dic===%@=======type====%d",dic_pushinfo,type);
    switch (type) {
        case 2:
        {
            [self pushtoxitongmessage];
        }
            break;
        case 3:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 4:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 5:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 6:
        {
            [self pushtopersonalmessage];
        }
            break;
        case 7:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 9:
        {
            [self pushtoxitongmessage];
            
        }
            break;
        case 20:
        {
            NSString *string_tid=[NSString stringWithFormat:@"%@",[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"tid"]];
            [self pushtobbsdetailwithid:string_tid];
        }
            break;
        case 21:
        {
            NSString *string_tid=[NSString stringWithFormat:@"%@",[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"tid"]];
            [self pushtobbsdetailwithid:string_tid];
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    NSLog(@"==note==%@",dic_pushinfo);
    
}
-(void)pushtobbsdetailwithid:(NSString *)string_id{
    
    
    bbsdetailViewController *detaibbsvc=[[bbsdetailViewController alloc]init];
    detaibbsvc.bbsdetail_tid=string_id;
    [self.navigationController pushViewController:detaibbsvc animated:YES];
    
}

-(void)pushtopersonalmessage{
    
    NSLog(@"跳到私信");
    MessageViewController *_messageVc=[[MessageViewController alloc]init];
    [self.navigationController pushViewController:_messageVc animated:YES];
    
    
}

-(void)pushtoxitongmessage{
    NSLog(@"跳到fb通知");
    FBNotificationViewController *_fbnotificVc=[[FBNotificationViewController alloc]init];
    [self.navigationController pushViewController:_fbnotificVc animated:YES];
    
}


- (void)viewDidLoad
{
    //    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    [super viewDidLoad];
    
    
    
    mycurrentlanmu = 1;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showOutput:) name:@"testpush" object:nil];
    
    
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0.0,0, DEVICE_WIDTH, self.view.frame.size.height)];
    self.array_searchresault = [[NSMutableArray alloc] init];
    _photos = [[NSMutableArray alloc] init];
    _Replys_photos = [[NSMutableArray alloc] init];
    
    isadvertisingoadsuccess=NO;
    [self showguanggao];
    //   self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
    pagecount=1;//当前的页数
    pages=1;
    isshanglajiazai=NO;//刚开始没有加载
    
    nomore=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 30)];
    nomore.text=@"没有更多数据";
    nomore.textAlignment=NSTextAlignmentCenter;
    nomore.font=[UIFont systemFontOfSize:13];
    nomore.textColor=[UIColor lightGrayColor];
    
    dic=[[NSDictionary alloc]init];
    array_=[[NSArray alloc]init];
    image_mutar=[[NSMutableArray alloc]init];
    orr_array_im=[[NSMutableArray alloc]init];
    orr_array_title=[[NSMutableArray alloc]init];
    orr_array_date=[[NSMutableArray alloc]init];
    orr_array_discribe=[[NSMutableArray alloc]init];
    orr_array_id=[[NSMutableArray alloc]init];
    rec_array_id=[[NSMutableArray alloc]init];
    rec_array_link=[[NSMutableArray alloc]init];
    rec_array_title=[[NSMutableArray alloc]init];
    rec_array_type=[[NSMutableArray alloc]init];
    
    
    
    self.category_string=[[NSString alloc]initWithFormat:@"zuixin"];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    _titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,37)];
    _titleView.backgroundColor = RGBCOLOR(245, 245, 245);
    _titleView.contentSize = CGSizeMake(635,0);
    _titleView.showsHorizontalScrollIndicator = NO;
    _titleView.showsVerticalScrollIndicator = NO;
    _titleView.delegate = self;
    _titleView.pagingEnabled=NO;
    
    [self.view addSubview:_titleView];
    
    UIImageView * silderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ios7_huandongtiao.png"]];
    silderImageView.backgroundColor = [UIColor clearColor];
    silderImageView.tag = 99;
    silderImageView.frame = CGRectMake(35/2, 0, 71/2, 1);
    silderImageView.center=CGPointMake(28.5, 0.5);
    
    [_titleView addSubview:silderImageView];
    
    
    
    array_lanmu = [NSArray arrayWithObjects:@"最新",@"新闻",@"品车",@"改装",@"导购",@"摄影",@"赛事",@"房车",@"铁骑",@"旅行",@"活动",@"户外",@"公益",nil];
    
    for (int i = 0;i < [array_lanmu count];i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(4+48*i,0,48,37);
        [button setTitle:[array_lanmu objectAtIndex:i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 1+i;
        [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:button];
    }
    
    
    //    _ImgvLeft=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left1523.png"]];
    //    _ImgvLeft.center=CGPointMake(5, 20);
    //    _ImgvLeft.hidden=YES;
    //    [_titleView addSubview:_ImgvLeft];
    //
    //
    //    _ImgvRight=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right1523.png"]];
    //    _ImgvRight.center=CGPointMake(312, 20);
    //    [_titleView addSubview:_ImgvRight];
    
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 37)];
    loadview.backgroundColor=[UIColor clearColor];
    
    
    
    newsScrow=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, DEVICE_WIDTH, iPhone5?568-20-40-40-49+3+49:DEVICE_HEIGHT-19-40-40-49+3+49)];
    newsScrow.contentSize=CGSizeMake(DEVICE_WIDTH*13, 0);
    newsScrow.pagingEnabled=YES;
    newsScrow.delegate=self;
    newsScrow.showsHorizontalScrollIndicator=NO;
    newsScrow.showsVerticalScrollIndicator=NO;
    newsScrow.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:newsScrow];
    
    for (int i=0; i<13; i++) {
        
        
        newsTableview *mytesttab=[[newsTableview alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*i, 0, DEVICE_WIDTH, iPhone5?568-20-40-40:DEVICE_HEIGHT-19-40-40)];
        mytesttab.tag=i+800;
        mytesttab.delegate=self;
        [newsScrow addSubview:mytesttab];
        
        //        if (i==0) {
        //
        //
        //
        //            [UIView animateWithDuration:0.5 animations:^{
        //                [mytesttab.tab setContentOffset:CGPointMake(0, -80)];
        //
        //
        //
        //
        //                //动画内容
        //
        //            }completion:^(BOOL finished)
        //
        //             {
        //
        //
        //
        //             }];
        //
        //
        //        }
    }
    
    
    tab_=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, DEVICE_WIDTH, iPhone5?568-20-40-40-49:480-19-40-40-49) style:UITableViewStylePlain];
    //    [self.view addSubview:tab_];
    
    tab_.delegate=self;
    tab_.dataSource=self;
    tab_.separatorColor=[UIColor clearColor];
    tab_.tableFooterView=loadview;
    
    tab_.userInteractionEnabled=YES;
    UISwipeGestureRecognizer *recognizer_oftab;
    
    
    recognizer_oftab = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer_oftab setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [tab_ addGestureRecognizer:recognizer_oftab];
    recognizer_oftab = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer_oftab setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [tab_ addGestureRecognizer:recognizer_oftab];
    
    
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-tab_.bounds.size.height, self.view.frame.size.width, tab_.bounds.size.height)];
		view.delegate = self;
		//[tab_pinglunliebiao addSubview:view];
		_refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    [tab_ addSubview:_refreshHeaderView];
    
    _loadingview=[[loadingview alloc]initWithFrame:CGRectMake(0, 80, DEVICE_WIDTH, iPhone5?568-20-40-40-49:DEVICE_HEIGHT-20-40-40-49)];
    //[self.view addSubview:_loadingview];
    [self judgeversionandclean];
    
    
    
    searchresaultview=[[UITableView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7?108:88, DEVICE_WIDTH, iPhone5?568-20-40-40-49-5:DEVICE_HEIGHT-19-40-40-49-5)];
    searchresaultview.delegate=self;
    searchresaultview.dataSource=self;
    //searchresaultview.backgroundColor=[UIColor redColor];
    searchresaultview.hidden=YES;
    [self.view addSubview:searchresaultview];
    
    
    if (!searchloadingview)
    {
        searchloadingview =[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
        searchloadingview.backgroundColor=[UIColor clearColor];
        searchloadingview.normalLabel.text=@"上拉加载更多";
    }
    
    searchresaultview.tableFooterView = searchloadingview;
    
    if ([self.str_dijige intValue ]==0) {
        rootnewsModel *model=[[rootnewsModel alloc]init];
        [model startloadcommentsdatawithtag:800 thetype:[personal place:[array_lanmu objectAtIndex:0]]];
        model.delegate=self;
        
    }else{
    
        [self refreshWithZonghe];
    
    
    }
    [self prepairNavigationBar];
  
    
}


#pragma mark-准备uinavigationbar

-(void)prepairNavigationBar{
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7evaDEVICE_WIDTH_44.png"] forBarMetrics: UIBarMetricsDefault];
        
    }
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:self.isMain? CGRectMake(MY_MACRO_NAME? -2:5, (44-33/2)/2, 36/2, 33/2):CGRectMake(MY_MACRO_NAME?-5:5,0,28,44)];
    
    [button_back addTarget:self action:@selector(leftDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [button_back setImage:self.isMain? [UIImage imageNamed:@"homenewz36_33.png"]:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    button_back.backgroundColor = [UIColor clearColor];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(leftDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    self.navigationItem.leftBarButtonItem=back_item;
    
    
    
    //[UIImage imageNamed:@"fblifelogo102_38_.png"];
    
    self.navigationItem.title = @"资讯";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //右边
    
    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?37: 25, (44-34/2)/2, 37/2, 34/2)];
    
    
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    
    if (self.isMain) {
        button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
        [button_comment addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [button_comment setBackgroundImage:[UIImage imageNamed:@"menewz37_36.png"] forState:UIControlStateNormal];
        
        UIButton *  rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        [rightView addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:button_comment];
        rightView.backgroundColor=[UIColor clearColor];
        
        
        
        
        UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
        
        self.navigationItem.rightBarButtonItem=comment_item;

    }
    
    
    
    
    
    
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress{
    
    
        if (self.isMain) {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            
        }

}

-(void)rightDrawerButtonPress{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    
}

-(void)backtoShangVC{

    [self.navigationController popViewControllerAnimated:YES];

}





#pragma mark-判断是否更新版本，以及是否更新缓存里面的数据
-(void)judgeversionandclean{
    
    [MobClick startWithAppkey:@"5153e5e456240b79e20006b9"];
    [MobClick checkUpdate:@"New version" cancelButtonTitle:@"下次提示" otherButtonTitles:@"立即升级"];
    
    
    NSUserDefaults *standuser=[NSUserDefaults standardUserDefaults];
    int i=(int)[standuser integerForKey:@"judgeversionandclean" ];
    NSLog(@"i======%d",i);
    if (i==10)
    {
        [self getdatafromcache];
    }
    if (i==11) {
        [self refreshnormal];
        [self sendrecommedrequest];
    }
    
    if (i==12) {
        [self getdatafromcache];
        
        NSString * new = [NSString stringWithFormat:@"我们的新版本已经上线了,赶快去更新吧!"];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:new delegate:self cancelButtonTitle:@"立即升级" otherButtonTitles:@"下次提示",nil];
        
        alert.delegate = self;
        
        alert.tag = 10000;
        
      //  [alert show];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag == 10000)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/yue-ye-yi-zu/id605673005?mt=8"]];
    }
}

#pragma mark-导航栏的选择类别
-(void)choose:(UIButton *)sender
{
    
    NSLog(@".............");
    sender.titleLabel.textColor=[UIColor blackColor];
    NSString *stringnetwork=[Reachability checkNetWork ];
    
    NSLog(@"当前的网络为%@",stringnetwork);
    
    
    [orr_array_im removeAllObjects];
    [orr_array_title removeAllObjects];
    [orr_array_date removeAllObjects];
    [orr_array_discribe removeAllObjects];
    [orr_array_id removeAllObjects];
    [tab_ reloadData];
    
    
    if (!isHaveNetWork) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        tab_.contentOffset=CGPointMake(0,0);
        [_refreshHeaderView szksetstate];
        [UIView commitAnimations];
    }
    
    
    mycurrentlanmu=sender.tag;
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag:99];
    imageView.hidden=NO;
    
    
    NSLog(@"tag=========%d",sender.tag);
    
    imageView.center = CGPointMake(30+48*(sender.tag-1),1);
    
    newsTableview *mytab=(newsTableview*)[self.view viewWithTag:sender.tag-1+800];
    if (mytab.normalarray.count==0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            [mytab.tab setContentOffset:CGPointMake(0, -80)];
            
            //动画内容
            
        }completion:^(BOOL finished)
         
         {
             
         }];
        
        rootnewsModel *model=[[rootnewsModel alloc]init];
        [model startloadcommentsdatawithtag:sender.tag-1+800 thetype:[personal place:[array_lanmu objectAtIndex:sender.tag-1]]];
        model.delegate=self;
    }else{
        NSLog(@"当前已经有数据，不需要刷新");
    }
    
    newsScrow.contentOffset=CGPointMake(DEVICE_WIDTH*(sender.tag-1), 0);
    
}





#pragma mark-发送请求推荐新闻的数据
-(void)sendrecommedrequest{
    
    NSString *stringnetwork=[Reachability checkNetWork ];
    
    NSLog(@"当前的网络为%@",stringnetwork);
    if ([stringnetwork isEqualToString:@"NONetWork"]) {
        [self HaveNoNetWork];
    }else{
        NSLog(@"在网上获取推荐新闻的图片");
        
        tab_.tableFooterView=loadview;
        isloadingrecommend=NO;
        isloadingoriginal=NO;
        // pagecount=1;在这似乎没有必要
        pages=0;
        NSString *  fullurl = [NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=newsslide&classname=%@&type=json",[personal place:self.category_string]];
        
        NSURL *url101 =[NSURL URLWithString:fullurl];
        ASIHTTPRequest *request101= [ASIHTTPRequest requestWithURL:url101];
        NSLog(@"推荐新闻的fullurl==%@",fullurl);
        [request101 setTimeOutSeconds:120];
        request101.tag=101;
        request101.delegate=self;
        [request101 startAsynchronous];
        
        dic=[[NSDictionary alloc]init];
        array_=[[NSArray alloc]init];
        image_mutar=[[NSMutableArray alloc]init];
        
    }
    
    
    
}
#pragma mark-提示没有网络
-(void)HaveNoNetWork{
    for (id aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([aviewp isEqual:[AlertRePlaceView class]])
        {
            [aviewp removeFromSuperview];
        }
    }
    
    [_replaceAlertView removeFromSuperview];
    _replaceAlertView=nil;
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"检测到您的手机没有网络连接，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=NO;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    [_replaceAlertView hide];
    
}
-(void)hidefromview{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:1];
    NSLog(@"?????");
}
-(void)hidealert{
    _replaceAlertView.hidden=YES;
    
}

#pragma mark-刷新普通新闻

-(void)refreshnormal{
    if (!isHaveNetWork) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        tab_.contentOffset=CGPointMake(0, -80);
        [_refreshHeaderView szksetstate];
        [UIView commitAnimations];
    }
    
    
    NSString *  normalstring = [NSString stringWithFormat:URL_NESTEST,[personal place:self.category_string], @"0",1,@"10"];
    NSLog(@"刷新普通新闻的url=%@",normalstring);
    NSURL *url102=[NSURL URLWithString:normalstring];
    ASIHTTPRequest *request102=[ASIHTTPRequest requestWithURL:url102];
    request102.tag=102;
    [request102 setTimeOutSeconds:120];
    request102.delegate=self;
    [request102 startAsynchronous];
    
}
#pragma mark-在缓存中读取新闻
-(void)getdatafromcache{
    
    
    dic=[[NSDictionary alloc]init];
    image_mutar=[[NSMutableArray alloc]init];
    
    NSString *string_imagename=[NSString stringWithFormat:@"%@img",[personal place:self.category_string]];
    
    dic = [[NSUserDefaults standardUserDefaults]objectForKey:string_imagename];
    
    
    [image_mutar removeAllObjects];
    [rec_array_id removeAllObjects];
    [rec_array_title removeAllObjects];
    [rec_array_link removeAllObjects];
    [rec_array_type removeAllObjects];
    
    array_=[[NSArray alloc]init];
    array_=(NSArray *)[dic objectForKey:@"news"];
    NSLog(@"%@的推荐新闻个数为%d张",self.category_string,array_.count);
    if ([array_ count]!=0) {
        
        for (int i=0; i<[array_ count]; i++) {
            NSDictionary *dic_photo=[array_ objectAtIndex:i];
            NSString *stringphoto=[dic_photo objectForKey:@"photo"];
            [image_mutar addObject:stringphoto];
            NSString *string_id=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"id"]];
            [rec_array_id addObject:string_id];
            NSString *string_title=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"title"]];
            [rec_array_title addObject:string_title];
            NSString *string_link=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"link"]];
            [rec_array_link addObject:string_link];
            NSString *string_type=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"type"]];
            [rec_array_type addObject:string_type];
            
            
        }
        NSLog(@"在缓存中读取图片%d张",image_mutar.count);
        
        
    }else{
        [self sendrecommedrequest];
    }
    
    
    ordinary_dic=[[NSDictionary alloc]init];
    
    
    
    ordinary_dic=[[NSUserDefaults standardUserDefaults]objectForKey:self.category_string];
    ordinary_array=[[NSArray alloc]init];
    
    ordinary_array=[ordinary_dic objectForKey:@"news"];
    pages=[[ordinary_dic objectForKey:@"errno"] integerValue];
    if ([ordinary_array count]!=0) {
        NSLog(@"在缓存中读取到普通新闻的数据");
        
        [orr_array_im removeAllObjects];
        [orr_array_title removeAllObjects];
        [orr_array_date removeAllObjects];
        [orr_array_discribe removeAllObjects];
        [orr_array_id removeAllObjects];
        
        for (int i=0; i<[ordinary_array count]; i++)
        {
            NSDictionary *dic_photo=[ordinary_array objectAtIndex:i];
            NSString *stringphoto=[dic_photo objectForKey:@"photo"];
            [orr_array_im addObject:stringphoto];
            
            NSString *stringtitle=[dic_photo objectForKey:@"title"];
            [orr_array_title addObject:stringtitle];
            
            NSString *stringdate=[dic_photo objectForKey:@"publishtime"];
            [orr_array_date addObject:stringdate];
            
            NSString *stringdiscribe=[dic_photo objectForKey:@"summary"];
            [orr_array_discribe addObject:stringdiscribe];
            
            NSString *stringid=[dic_photo objectForKey:@"id"];
            [orr_array_id addObject:stringid];
            
        }
        NSLog(@"oorid=%@",orr_array_id);
        isloadingoriginal=YES;
        
        
    }else{
        NSLog(@"在网上获取到普通新闻的数据");
        
        [self refreshnormal];
    }
    [tab_ reloadData];
    
}
-(void)getdatafromcacheonly{
    
}
#pragma mark-加载更多请求普通新闻的数据
-(void)jiazaimore{
    
    
    isloadingoriginal=NO;
    
    if (isshanglajiazai==NO)
    {
        if (pages==0) {
            pagecount++;
            isshanglajiazai=YES;
            
            NSString *  normalstring = [NSString stringWithFormat:URL_NESTEST,[personal place:self.category_string], @"0",pagecount,@"10"];
            NSURL *url104=[NSURL URLWithString:normalstring];
            
            NSLog(@"加载的%@",normalstring);
            ASIHTTPRequest *request104=[ASIHTTPRequest requestWithURL:url104];
            request104.tag=104;
            [request104 setTimeOutSeconds:120];
            request104.delegate=self;
            [request104 startAsynchronous];
            
        }else{
            NSLog(@"已经是最后一页");
            tab_.tableFooterView=nomore;
            
        }
    }
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    [refreshButton.layer removeAllAnimations];
    switch (request.tag) {
        case 101:{
            NSData *data=[request responseData];
            
            dic = [data objectFromJSONData];
            NSLog(@"新版本的幻灯新闻dic=%@",dic);
            NSString *string_imagename=[NSString stringWithFormat:@"%@",[personal place:self.category_string]];
            [personal bycategoryname:string_imagename myimage_dic:dic];
            
            [image_mutar removeAllObjects];
            [rec_array_id removeAllObjects];
            [rec_array_type removeAllObjects];
            [rec_array_title removeAllObjects];
            [rec_array_link removeAllObjects];
            
            array_=[dic objectForKey:@"news"];
            
            for (int i=0; i<[array_ count]; i++) {
                NSDictionary *dic_photo=[array_ objectAtIndex:i];
                NSString *stringphoto=[dic_photo objectForKey:@"photo"];
                [image_mutar addObject:stringphoto];
                NSString *string_id=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"id"]];
                [rec_array_id addObject:string_id];
                NSString *string_title=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"title"]];
                [rec_array_title addObject:string_title];
                NSString *string_link=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"link"]];
                [rec_array_link addObject:string_link];
                
                NSString *string_type=[NSString stringWithFormat:@"%@",[dic_photo objectForKey:@"type"]];
                [rec_array_type addObject:string_type];
                
            }
            isloadingrecommend=YES;
            
            [tab_ reloadData];
        }
            
            break;
        case 102:{
            
            NSData *data=[request responseData];
            
            ordinary_dic=[[NSDictionary alloc]init];
            ordinary_dic = [data objectFromJSONData];
            NSLog(@"新版本的普通新闻dic=%@",dic);
            
            [personal mycategoryname:self.category_string category_dic:ordinary_dic];
            
            ordinary_array=[ordinary_dic objectForKey:@"news"];
            pages=[[ordinary_dic objectForKey:@"errno"] integerValue];
            
            [orr_array_im removeAllObjects];
            [orr_array_title removeAllObjects];
            [orr_array_date removeAllObjects];
            [orr_array_discribe removeAllObjects];
            [orr_array_id removeAllObjects];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            tab_.contentOffset=CGPointMake(0, 0);
            [_refreshHeaderView szksetstate];
            [UIView commitAnimations];
            
            for (int i=0; i<[ordinary_array count]; i++)
            {
                NSDictionary *dic_photo=[ordinary_array objectAtIndex:i];
                NSString *stringphoto=[dic_photo objectForKey:@"photo"];
                [orr_array_im addObject:stringphoto];
                
                NSString *stringtitle=[dic_photo objectForKey:@"title"];
                [orr_array_title addObject:stringtitle];
                
                NSString *stringdate=[dic_photo objectForKey:@"publishtime"];
                [orr_array_date addObject:stringdate];
                
                NSString *stringdiscribe=[dic_photo objectForKey:@"summary"];
                [orr_array_discribe addObject:stringdiscribe];
                
                NSString *stringid=[dic_photo objectForKey:@"id"];
                [orr_array_id addObject:stringid];
                
            }
            NSLog(@"oorid=%@",orr_array_id);
            isloadingoriginal=YES;
            
            [tab_ reloadData];
            
            
            
            
        }
            break;
        case 104:{
            
            isshanglajiazai=NO;
            
            NSData *data=[request responseData];
            
            ordinary_dic=[[NSDictionary alloc]init];
            ordinary_array=[[NSArray alloc]init];
            ordinary_dic = [data objectFromJSONData];
            
            ordinary_array=[ordinary_dic objectForKey:@"news"];
            
            pages=[[ordinary_dic objectForKey:@"errno"] integerValue];
            
            
            NSLog(@"加载中。。。%@。。",ordinary_array);
            
            for (int i=0; i<[ordinary_array count]; i++)
            {
                NSDictionary *dic_photo=[ordinary_array objectAtIndex:i];
                NSString *stringphoto=[dic_photo objectForKey:@"photo"];
                [orr_array_im addObject:stringphoto];
                
                NSString *stringtitle=[dic_photo objectForKey:@"title"];
                [orr_array_title addObject:stringtitle];
                
                NSString *stringdate=[dic_photo objectForKey:@"publishtime"];
                [orr_array_date addObject:stringdate];
                
                NSString *stringdiscribe=[dic_photo objectForKey:@"summary"];
                [orr_array_discribe addObject:stringdiscribe];
                
                NSString *stringid=[dic_photo objectForKey:@"id"];
                [orr_array_id addObject:stringid];
                
            }
            [loadview stopLoading:1];
            isloadingoriginal=YES;
            if (pages==0) {
                [tab_ reloadData];
            }else{
                tab_.tableFooterView=nomore;
                NSLog(@"就这么多了");
                
            }
        }
            break;
            
        default:
            break;
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSString *stringnetwork=[Reachability checkNetWork ];
    
    NSLog(@"当前的网络为%@",stringnetwork);
    if ([stringnetwork isEqualToString:@"NONetWork"]) {
        //[self getdatafromcache];
        [self HaveNoNetWork];
        
    }else{
        [self HaveNoNetWork];
        
    }
}
#pragma mark-tableview的delegate和datesource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==tab_)
    {
        return [orr_array_date count]+1;
    }else
    {
        return self.array_searchresault.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == searchresaultview && mysegment.currentPage == 2)
    {
        static NSString * identifier = @"identifier";// [NSString stringWithFormat:@"%d",indexPath.row];
        
        NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[NewWeiBoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.delegate = self;
        }
        
        [cell setAllViewWithType:0];
        
        float height = [tableView rectForRowAtIndexPath:indexPath].size.height;
        
        if (self.array_searchresault.count !=0)
        {
            FbFeed * info = [self.array_searchresault objectAtIndex:indexPath.row];
            
            [cell setInfo:info withReplysHeight:height WithType:0];
        }
        
        return cell;
    }else
    {
        static NSString * identifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        for (UIView *view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        if (tableView==tab_)
        {
            if (indexPath.row==0)
            {
                if (image_mutar.count!=0)
                {
                    NSLog(@"到底有木有+%@",image_mutar);
                    //  tab_.separatorColor=[UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1];
                    
                    imagesc=[[newsimage_scro alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 163)];
                    [imagesc setImage_array:(NSArray *)image_mutar];
                    imagesc.delegate=self;
                    [imagesc startanimation];
                    [cell.contentView addSubview:imagesc];
                    
                    
                    
                    
                    
                    //   UILabel
                    
                    UITapGestureRecognizer *oneFingerOneTaps =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushtocomment)];
                    
                    [oneFingerOneTaps setNumberOfTapsRequired:1];
                    [oneFingerOneTaps setNumberOfTouchesRequired:1];
                    
                    // Add the gesture to the view
                    [imagesc addGestureRecognizer:oneFingerOneTaps];
                    imagesc.userInteractionEnabled=YES;
                    
                    //浅黑色边
                    UIColor *color_gray=[[UIColor blackColor] colorWithAlphaComponent:0.5];
                    UIView *_duantiaoview=[[UIView alloc]initWithFrame:CGRectMake(0, 137, DEVICE_WIDTH, 25)];
                    _duantiaoview.userInteractionEnabled = NO;
                    _duantiaoview.autoresizesSubviews=YES;
                    
                    _duantiaoview.backgroundColor=color_gray;
                    
                    _pagecontrol = [[SMPageControl alloc]initWithFrame:CGRectMake(-4, 1,  DEVICE_WIDTH-255, 25)];
                    
                    _pagecontrol.backgroundColor = [UIColor clearColor];
                    _pagecontrol.numberOfPages = image_mutar.count;
                    _pagecontrol.indicatorMargin=8.0f;
                    [_pagecontrol setPageIndicatorImage:[UIImage imageNamed:@"dot.png"]];
                    [_pagecontrol setCurrentPageIndicatorImage:[UIImage imageNamed:@"dot1.png"]];
                    _pagecontrol.center=CGPointMake(160, 130);
                    
                    _pagecontrol.currentPage = 0;
                    _pagecontrol.tag = 999;
                    labeltuiguang=[[UILabel alloc]initWithFrame:CGRectMake(10, 6, 27, 13)];
                    labeltuiguang.backgroundColor=[UIColor colorWithRed:80/255.f green:135/255.f blue:220/255.f alpha:1];
                    
                    labeltuiguang.text=@"推广";
                    labeltuiguang.textAlignment=UITextAlignmentCenter;
                    labeltuiguang.textColor=[UIColor whiteColor];
                    labeltuiguang.font=[UIFont systemFontOfSize:10];
                    
                    labeltuiguang.textAlignment=UITextAlignmentCenter;
                    _titleimagelabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 3, 310, 19)];
                    _titleimagelabel.backgroundColor=[UIColor clearColor];
                    // _titleimagelabel.text=@"2014进口全新大切预售火爆";
                    
                    _titleimagelabel.font=[UIFont systemFontOfSize:14];
                    _titleimagelabel.textAlignment=UITextAlignmentCenter;
                    _titleimagelabel.textColor=[UIColor whiteColor];
                    _titleimagelabel.text=[NSString stringWithFormat:@"%@",[rec_array_title objectAtIndex:0]];
                    
                    [cell.contentView addSubview:_duantiaoview];
                    
                    [cell.contentView addSubview:_pagecontrol];
                    //[_duantiaoview addSubview:labeltuiguang];
                    [_duantiaoview addSubview:_titleimagelabel];
                }
                else{
                    
                    imagesc=[[newsimage_scro alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 163)];
                    
                    
                    [cell.contentView addSubview:imagesc];
                    
                    NSLog(@"到底有木有+%@",image_mutar);
                    
                }
            }else{
                if (orr_array_date.count>indexPath.row-1)
                {
                    
                    orcell=[[newscellview alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 77)];
                    [orcell setImv_string:[orr_array_im objectAtIndex:indexPath.row-1]];
                    [orcell setTitle_string:[orr_array_title objectAtIndex:indexPath.row-1]];
                    [orcell setDate_string:[orr_array_date objectAtIndex:indexPath.row-1]];
                    [orcell setDiscribe_string:[orr_array_discribe objectAtIndex:indexPath.row-1]];
                    
                    orcell.userInteractionEnabled=YES;
                    UISwipeGestureRecognizer *recognizer;
                    
                    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
                    
                    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
                    [orcell addGestureRecognizer:recognizer];
                    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
                    
                    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
                    [orcell addGestureRecognizer:recognizer];
                    
                    
                    
                    
                    
                    
                    
                    [cell.contentView addSubview:orcell];
                    
                }
            }
        }
        
        if (tableView==searchresaultview)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            NSDictionary *dic_ssinfo =[self.array_searchresault objectAtIndex:indexPath.row];
            switch (mysegment.currentPage)
            {
                case 0:
                {
                    SearchNewsView *_search_news=[[SearchNewsView alloc]init];
                    [_search_news layoutSubviewsWithDicNewsinfo:dic_ssinfo];
                    [cell.contentView addSubview:_search_news];
                }
                    break;
                case 1:
                {
                    SearchNewsView *_search_news=[[SearchNewsView alloc]init];
                    [_search_news layoutSubviewsWithDicNewsinfo:dic_ssinfo];
                    [cell.contentView addSubview:_search_news];
                }
                    break;
                    
                case 3:
                {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    //                    cell.contentView.backgroundColor = RGBCOLOR(248,248,248);
                    cell.backgroundColor = [UIColor clearColor];
                    
                    PersonInfo * info = [_array_searchresault objectAtIndex:indexPath.row];
                    
                    
                    AsyncImageView * imagetouxiang=[[AsyncImageView alloc]initWithFrame:CGRectMake(5, 10,50 , 50)];
                    
                    imagetouxiang.layer.cornerRadius = 5;
                    imagetouxiang.layer.borderColor = (__bridge  CGColorRef)([UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]);
                    imagetouxiang.layer.borderWidth =1.0;
                    imagetouxiang.layer.masksToBounds = YES;
                    
                    [imagetouxiang loadImageFromURL:info.face_original withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
                    
                    [cell.contentView addSubview:imagetouxiang];
                    
                    UILabel * label_username=[[UILabel alloc]initWithFrame:CGRectMake(70,10,200, 20)];
                    label_username.text = info.username;
                    label_username.backgroundColor = [UIColor clearColor];
                    label_username.font = [UIFont systemFontOfSize:18];
                    [cell.contentView addSubview:label_username];
                    
                    
                    NSString * location = info.city;
                    if (info.city.length == 0||[info.city isEqualToString:@"(null)"])
                    {
                        location = @"未知";
                    }
                    
                    UILabel * label_location=[[UILabel alloc]initWithFrame:CGRectMake(70, 40, 200, 20)];
                    label_location.text = [NSString stringWithFormat:@"所在地:%@",location];
                    label_location.font = [UIFont systemFontOfSize:13];
                    label_location.backgroundColor = [UIColor clearColor];
                    label_location.textColor = RGBCOLOR(137,137,137);
                    [cell.contentView addSubview:label_location];
                    
                }
                    
                default:
                    break;
            }
        }
        
        return cell;
    }
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    NSLog(@"mycurrentlanmu=%d",mycurrentlanmu);//1
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (mycurrentlanmu<=12) {
            UIButton *_currentbutton=(UIButton *)[_titleView viewWithTag:mycurrentlanmu+1];
            [self choose:_currentbutton];
        }
        
        NSLog(@"向左滑动");
        
        //执行程序
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        if (mycurrentlanmu>1) {
            UIButton *_currentbutton=(UIButton *)[_titleView viewWithTag:mycurrentlanmu-1];
            
            [self choose:_currentbutton];
        }
        
        NSLog(@"向右滑动");
        //执行程序
    }
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag:99];
    
    
    [UIView animateWithDuration:0.3 animations:^(void){
        //        if (imageView.center.x>300) {
        //            _titleView.contentOffset=CGPointMake(DEVICE_WIDTH, 0);
        //        }else {
        //            _titleView.contentOffset=CGPointMake(0, 0);
        //        }
        //
        //
        //        if (mycurrentlanmu==13) {
        //            _titleView.contentOffset=CGPointMake(340, 0);
        //        }
        if (mycurrentlanmu<7) {
            _titleView.contentOffset=CGPointMake(0, 0);
        }
        if (mycurrentlanmu==7) {
            _titleView.contentOffset=CGPointMake(285, 0);
            NSLog(@"mycunrrent===%d,imageView.center.x-150=%f",mycurrentlanmu,imageView.center.x-150);
            
        } if (mycurrentlanmu==13) {
            _titleView.contentOffset=CGPointMake(310, 0);
            
        }
        
    }completion:^(BOOL finished){
        
    }];
    
    
    
    
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==tab_)
    {
        CGFloat height;
        if (indexPath.row==0)
        {
            height=163;
        }else
        {
            height=77;
        }
        return height;
    }else
    {
        if (mysegment.currentPage == 2)
        {
            //            float image_height = 0;
            //            float content_height;
            //            float theHeight1 = 0;
            
            
            FbFeed * info = [self.array_searchresault objectAtIndex:indexPath.row];
            
            if (!test_cell)
            {
                test_cell = [[NewWeiBoCustomCell alloc] init];
            }
            
            return [test_cell returnCellHeightWith:info WithType:0] + 20;
            
            
            //            float image_height1111 = 78;
            //
            //            content_height = [zsnApi theHeight:info.content withHeight:260 WidthFont:[UIFont systemFontOfSize:15]] ;
            //            content_height = [zsnApi theHeight:info.content withHeight:260 WidthFont:[UIFont systemFontOfSize:15]] ;
            //
            //            if (info.imageFlg)//判断是否有图片
            //            {
            //
            //                NSArray * array = [info.image_small_url_m componentsSeparatedByString:@"|"];
            //
            //                int nn = array.count/3;
            //                int pp = array.count%3?1:0;
            //                int hangshu = nn+pp;
            //
            //                image_height = image_height1111*hangshu + 10*hangshu;
            //
            //            }
            //
            //            if (info.rootFlg)
            //            {
            //                theHeight1 = [zsnApi theHeight:info.rcontent withHeight:240 WidthFont:[UIFont systemFontOfSize:15]] + 20;
            //
            //                if (info.rimageFlg)
            //                {
            //                    NSArray * array = [info.rimage_small_url_m componentsSeparatedByString:@"|"];
            //                    int nn = array.count/3;
            //                    int pp = array.count%3?1:0;
            //                    int hangshu = nn+pp;
            //
            //                    theHeight1 = theHeight1 + CELL_CONTENTIMAGE_SIZE*hangshu + 4*(hangshu-1)+10;
            //                }
            //            }else
            //            {
            //                theHeight1 = 0;
            //            }
            //            return content_height+theHeight1+image_height+30+33;
        }else
        {
            if (mysegment.currentPage ==3)
            {
                return 70;
            }else
            {
                
                NSDictionary *dic_ssinfo =[self.array_searchresault objectAtIndex:indexPath.row];
                
                NSString *string__tcon=[NSString stringWithFormat:@"%@",[dic_ssinfo objectForKey:@"content"]];
                CGSize constraintSize = CGSizeMake(310, MAXFLOAT);
                CGSize labelSize = [string__tcon sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
                return     30+labelSize.height+5+23;
                
            }
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellid=%@",orr_array_id);
    if (tableView==tab_)
    {
        
        if (orr_array_id.count>0)
        {
            NSLog(@"222");
            newsdetailViewController *    comment_=[[newsdetailViewController alloc]init];
            
            comment_.string_Id=[orr_array_id objectAtIndex:indexPath.row-1];
            // [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
            
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            [self.navigationController pushViewController:comment_ animated:YES];//跳入下一个View
            
            //[self setHidesBottomBarWhenPushed:NO] ;
        }
    }else
    {
        NSLog(@"点击的是搜索的内容");
        if (self.array_searchresault.count>0)
        {
            NSDictionary *dicinfoofsearchresault=[self.array_searchresault objectAtIndex:indexPath.row];
            switch (mysegment.currentPage)
            {
                case 0:
                {
                    newsdetailViewController *newsDe=[[newsdetailViewController alloc]init];
                    newsDe.string_Id=[NSString stringWithFormat:@"%@",[dicinfoofsearchresault objectForKey:@"tid"]];
                    [self.leveyTabBarController hidesTabBar:YES animated:YES];
                    [self.navigationController pushViewController:newsDe animated:YES];//跳入下一个View
                    
                }
                    break;
                case 1:
                {
                    bbsdetailViewController *_bbsdetail=[[bbsdetailViewController alloc]init];
                    _bbsdetail.bbsdetail_tid=[NSString stringWithFormat:@"%@",[dicinfoofsearchresault objectForKey:@"tid"]];
                    [self.navigationController pushViewController:_bbsdetail animated:YES];
                    
                }
                    break;
                case 2:
                {
                    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
                    if (isLogIn)
                    {
                        FbFeed * info = [self.array_searchresault objectAtIndex:indexPath.row];
                        
                        NewWeiBoDetailViewController *  detail = [[NewWeiBoDetailViewController alloc] init];
                        
                        detail.info = info;
                        
                        self.navigationController.navigationBarHidden = NO;
                        
                        [self.navigationController pushViewController:detail animated:YES];
                    }else
                    {
                        if (!logIn)
                        {
                            logIn = [LogInViewController sharedManager];
                        }
                        [self.leveyTabBarController hidesTabBar:YES animated:YES];
                        [self presentModalViewController:logIn animated:YES];
                    }
                    
                }
                    break;
                case 3:
                {
                    PersonInfo * info = [_array_searchresault objectAtIndex:indexPath.row];
                    [searchresaultview deselectRowAtIndexPath:[searchresaultview indexPathForSelectedRow] animated:YES];
                    
                    [self.leveyTabBarController hidesTabBar:YES animated:YES];
                    
                    NewMineViewController * mine = [[NewMineViewController alloc] init];
                    mine.uid = info.uid;
                    //                    mine.isPop = YES;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
                    {
                        [self.navigationController pushViewController:mine animated:YES];
                        
                        
                    }else{
                        LogInViewController *login=[LogInViewController sharedManager];
                        [self presentModalViewController:login animated:YES];
                    }
                    
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
    }
}


#pragma mark-CustomWeiBoCellDelegate

-(void)clickHeadImage:(NSString *)uid WithIndex:(int)index
{
    BOOL authkey=[[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    
    if (authkey)
    {
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        NewMineViewController * mine = [[NewMineViewController alloc] init];
        
        mine.uid = uid;
        
        [self.navigationController pushViewController:mine animated:YES];
    }else
    {
        if (!logIn)
        {
            logIn = [LogInViewController sharedManager];
        }
        
        [self presentModalViewController:logIn animated:YES];
    }
}

-(void)showImage:(FbFeed *)info isReply:(BOOL)isRe withIndex:(int)index
{
    
    NSString * sort = isRe?info.rsort:info.sort;
    [_photos removeAllObjects];
    
    if ([sort isEqualToString:@"3"])
    {
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        if (!isLogIn)
        {
            if (!logIn)
            {
                logIn = [LogInViewController sharedManager];
            }
            [self presentModalViewController:logIn animated:YES];
            return;
        }
    }
    
    
    NSArray * array = [info.imageFlg?info.image_original_url_m:info.rimage_original_url_m componentsSeparatedByString:@"|"];
    
    NSLog(@"------  %@",info.imageFlg?info.image_original_url_m:info.rimage_original_url_m);
    
    for (NSString * string in array)
    {
        NSString * url_string = [string stringByReplacingOccurrencesOfString:@"_s." withString:@"_b."];
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:url_string]]];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    
    browser.title_string = info.photo_title;
    
    [browser setInitialPageIndex:index];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self presentModalViewController:browser animated:YES];
    
}


-(void)pushToWeiBoDetail:(int)theTag
{
    isHyperlinks = YES;
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (isLogIn)
    {
        if (theTag >= 1000000)
        {
            theTag = theTag - 1000000;
        }
        FbFeed * info = [self.array_searchresault objectAtIndex:theTag];
        
        NewWeiBoDetailViewController *  detail = [[NewWeiBoDetailViewController alloc] init];
        
        detail.info = info;
        
        [self.navigationController pushViewController:detail animated:YES];
    }else
    {
        if (!logIn)
        {
            logIn = [LogInViewController sharedManager];
        }
        [self presentModalViewController:logIn animated:YES];
    }
}

-(void)ShowWeiBoDetail:(int)theTag isReply:(BOOL)isRe
{
    isHyperlinks = YES;
    FbFeed * info = [self.array_searchresault objectAtIndex:isRe?theTag-1000000:theTag];
    
    NSString * string = isRe?info.rsort:info.sort;
    
    NSString * sortId = isRe?info.rsortId:info.sortId;
    
    
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
            if (!logIn)
            {
                logIn = [LogInViewController sharedManager];
            }
            [self presentModalViewController:logIn animated:YES];
        }
        
        
    }else if ([string intValue] == 2)
    {
        if (!wenji)
        {
            wenji = [[WenJiViewController alloc] init];
        }
        wenji.bId = sortId;
        
        [self.navigationController pushViewController:wenji animated:YES];
        
    }else
    {
        NewWeiBoDetailViewController * detail = [[NewWeiBoDetailViewController alloc] init];
        
        detail.info = info;
        
        [self.navigationController pushViewController:detail animated:YES];
    }
}


-(void)deleteSomeWeiBoContent:(int)indexPathRow
{
    
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


-(void)pushtocomment
{
    
    NSLog(@"rec_id===%@",rec_array_id);
    
    if (rec_array_id.count>0)
    {
        NSLog(@"什么情况 ---  %d",imagesc.iscount-1);
        int type;
        NSString *string_link_;
        @try {
            type=[[NSString stringWithFormat:@"%@",[rec_array_type objectAtIndex:imagesc.iscount-1]] integerValue];
            
            string_link_=[NSString stringWithFormat:@"%@",[rec_array_link objectAtIndex:imagesc.iscount-1]];
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
            return;
            
        }
        @finally {
            switch (type) {
                case 1:
                    NSLog(@"到新闻的");
                    
                    if (imagesc.iscount-1>=0&&imagesc.iscount-1<5)
                    {
                        newsdetailViewController *    comment_=[[newsdetailViewController alloc]init];
                        
                        NSLog(@"点击的第几个 ------  %@",[NSString stringWithFormat:@"%d",imagesc.iscount-1]);
                        comment_.string_Id=[rec_array_id objectAtIndex:imagesc.iscount-1];
                        [self.leveyTabBarController hidesTabBar:YES animated:YES];
                        [self.navigationController pushViewController:comment_ animated:YES];//跳入下一个View
                        
                    }else{
                        
                    }
                    
                    break;
                case 2:{
                    
                    NSLog(@"到论坛的");
                    if (imagesc.iscount-1>=0&&imagesc.iscount-1<5) {
                        bbsdetailViewController *_bbsdetail=[[bbsdetailViewController alloc]init];
                        _bbsdetail.bbsdetail_tid=[rec_array_id objectAtIndex:imagesc.iscount-1];
                        [self.navigationController pushViewController:_bbsdetail animated:YES];
                    }
                    
                }
                    break;
                case 3:{
                    NSLog(@"到新闻的");
                    if (imagesc.iscount-1>=0&&imagesc.iscount-1<5) {
                        NSLog(@"第三种情况link=%@",string_link_);
                        fbWebViewController *_web=[[fbWebViewController alloc]init];
                        _web.urlstring=string_link_;
                        [self.navigationController pushViewController:_web animated:YES];
                        
                    }
                }
                    
                    break;
                    
                    
                default:
                    break;
            }
        }
    }
    
    
    
    
}
#pragma mark-搜索按钮促发方法
-(void)refresh:(UIButton *)button
{
    
    if (!array_search_zixun)
    {
        array_search_zixun = [[NSMutableArray alloc] init];
    }
    
    if (!array_search_bbs)
    {
        array_search_bbs = [[NSMutableArray alloc] init];
    }
    
    if (!weibo_search_data)
    {
        weibo_search_data = [[NSMutableArray alloc] init];
    }
    
    if (!array_search_user)
    {
        array_search_user = [[NSMutableArray alloc] init];
    }
    
    if (!array_cache)
    {
        array_cache = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",nil];
    }
    
    self.navigationController.navigationBarHidden=YES;
    
    
    mysearchPage=1;
    search_user_page = 1;
    issearchloadsuccess=NO;
    searchheaderview.hidden=NO;
    searchresaultview.hidden = NO;
    blackcolorview.hidden=NO;
    
    [_searchbar becomeFirstResponder];
    NSLog(@"搜索走你");
    
    if (!searchheaderview) {
        
        searchheaderview=[[UIView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7?0:0, DEVICE_WIDTH,IOS_VERSION>=7?108: 88)];
        searchheaderview.backgroundColor=RGBCOLOR(247, 247, 247);
        [self.view addSubview:searchheaderview];
        
        
        ImgV_ofsearch=[[UIImageView alloc]initWithFrame:CGRectMake(6, MY_MACRO_NAME?20:0, DEVICE_WIDTH-6, 44)];
        ImgV_ofsearch.backgroundColor=RGBCOLOR(247, 247, 247);
        ImgV_ofsearch.userInteractionEnabled=YES;
        [searchheaderview addSubview:ImgV_ofsearch];
        
        
        
        UIImageView *imgbc=[[UIImageView alloc]initWithFrame:CGRectMake(6, 6, 517/2, 56/2)];
        imgbc.image=[UIImage imageNamed:@"ios7_newssearchbar.png"];
        [ImgV_ofsearch addSubview:imgbc];
        
        _searchbar=[[UITextField alloc]initWithFrame:CGRectMake(30+6,MY_MACRO_NAME? 6:12,206-5,58/2)];
        //[[_searchbar.subviews objectAtIndex:0]removeFromSuperview];
        _searchbar.delegate=self;
        [_searchbar becomeFirstResponder];
        _searchbar.font=[UIFont systemFontOfSize:12.f];
        _searchbar.placeholder=@"输入关键词";
        _searchbar.returnKeyType=UIReturnKeySearch;
        // _searchbar.barStyle = UIBarStyleBlack;
        _searchbar.userInteractionEnabled = TRUE;
        [ImgV_ofsearch addSubview:_searchbar];
        
        
        
        UIView *selectview=[[UIView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7?64: 44, DEVICE_WIDTH, 44)];
        selectview.backgroundColor=RGBACOLOR(247, 247, 247, 1);
        [searchheaderview addSubview:selectview];
        mysegment=[[CustomSegmentView alloc]initWithFrame:CGRectMake(12, (44-28.5)/2, 296, 57/2)];
        [mysegment setAllViewWithArray:[NSArray arrayWithObjects:@"ios7_newsunselect.png",@"ios7_bbsunselect.png",@"ios7_fbunselect.png",@"ios7_userunselect.png", @"ios7_newsselected.png",@"ios7_bbsselected.png",@"ios7_fbselected.png",@"userselected.png",nil]];
        [mysegment settitleWitharray:[NSArray arrayWithObjects:@"资讯",@"论坛",@"微博",@"用户", nil]];
        // mysegment.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"segbackground.png"]];
        [selectview addSubview:mysegment];
        mysegment.delegate=self;
        
        UIImageView *imgvline=[[UIImageView alloc]initWithFrame:CGRectMake(0, MY_MACRO_NAME?64:44, DEVICE_WIDTH, 1)];
        imgvline.image=[UIImage imageNamed:@"line-2.png"];
        [searchheaderview addSubview:imgvline];
        
        
        
        
        //        _searchbar.showsCancelButton=NO;
        
        
        
        
        
        // searchresaultview.backgroundColor=[UIColor greenColor];
        searchresaultview.hidden=NO;
        
        if (!blackcolorview) {
            blackcolorview=[[UIView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7?108: 88, DEVICE_WIDTH,1000)];
            blackcolorview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8f];
            [self.view addSubview:blackcolorview];
        }
        blackcolorview.hidden=NO;
        
        
        cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(517/2, 6, DEVICE_WIDTH-517/2, 61/2)];
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.userInteractionEnabled=YES;
        //  [ cancelButton setBackgroundImage:[UIImage imageNamed:@"searchcancell.png"] forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];//文字
        
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(searchcancell) forControlEvents:UIControlEventTouchUpInside];
        [ImgV_ofsearch addSubview:cancelButton];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self WhetherOrNotRequest];
    return YES;
}
#pragma mark-自定义segment的代理
-(void)buttonClick:(int)buttonSelected
{
    if (buttonSelected != current_select)
    {
        [_array_searchresault removeAllObjects];
        [searchresaultview reloadData];
    }
    
    current_select = buttonSelected;
    
    [searchloadingview startLoading];
    
    [self WhetherOrNotRequest];
}

-(void)WhetherOrNotRequest
{
    mysearchPage=1;
    issearchloadsuccess=NO;
    
    if (_searchbar.text.length>0)
    {
        [_searchbar resignFirstResponder];
        
        [request_search cancel];
        
        request_search.delegate = nil;
        
        request_search=nil;
        
        if ([_searchbar.text isEqualToString:[array_cache objectAtIndex:mysegment.currentPage]])
        {
            [self.array_searchresault removeAllObjects];
            NSLog(@"------%d",array_search_zixun.count);
            if (mysegment.currentPage ==0 && array_search_zixun.count != 0)
            {
                [self.array_searchresault addObjectsFromArray:array_search_zixun];
                [searchresaultview reloadData];
                
            }else if (mysegment.currentPage ==1 && array_search_bbs.count != 0)
            {
                [self.array_searchresault addObjectsFromArray:array_search_bbs];
                
                [searchresaultview reloadData];
                
            }else if (mysegment.currentPage ==2 && weibo_search_data.count != 0)
            {
                [self.array_searchresault addObjectsFromArray:weibo_search_data];
                
                [searchresaultview reloadData];
                
            }else if (mysegment.currentPage ==3 && array_search_user.count != 0)
            {
                [self.array_searchresault addObjectsFromArray:array_search_user];
                
                [searchresaultview reloadData];
            }else
            {
                
                [self searchbythenetework];
            }
            
        }else
        {
            
            [self searchbythenetework];
        }
        
        [array_cache replaceObjectAtIndex:mysegment.currentPage withObject:_searchbar.text];
    }
    
    
}


#pragma mark-searchbar的代理



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self WhetherOrNotRequest];
    
}                   // called when keyboard search button pressed

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    self.navigationController.navigationBarHidden=NO;
    searchresaultview.backgroundColor=[UIColor redColor];
    searchresaultview.hidden=YES;
    
    //    [searchresaultview removeFromSuperview];
    [_searchbar resignFirstResponder];
    
    searchheaderview.hidden=YES;
    blackcolorview.hidden=YES;
}
-(void)searchcancell{
    
    self.navigationController.navigationBarHidden=NO;
    // [searchresaultview removeFromSuperview];
    [_searchbar resignFirstResponder];
    searchresaultview.hidden=YES;
    
    searchheaderview.hidden=YES;
    blackcolorview.hidden=YES;
    
    
}

#pragma mark-search取数据

-(void)searchbythenetework
{
    switch (mysegment.currentPage)
    {
        case 0:
        {
            NSLog(@"点击的是资讯");
            string_searchurl=[NSString stringWithFormat:@"http://so.fblife.com/api/searchapi.php?query=%@&fromtype=%d&pagesize=10&formattype=json&charset=utf8&page=%d",[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],2,mysearchPage];
            
        }
            break;
        case 1:
        {
            NSLog(@"点击的是论坛");
            string_searchurl=[NSString stringWithFormat:@"http://so.fblife.com/api/searchapi.php?query=%@&fromtype=%d&pagesize=10&formattype=json&charset=utf8&page=%d",[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],1,mysearchPage];
        }
            break;
        case 2:
        {
            NSLog(@"点击的是微博");
            
            string_searchurl = [NSString stringWithFormat:Search_weiBo,[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],mysearchPage];
        }
            break;
        case 3:
        {
            NSLog(@"点击的是用户");
            
            //            string_searchurl=[NSString stringWithFormat:@"http://so.fblife.com/api/searchapi.php?query=%@&fromtype=%d&pagesize=10&formattype=json",[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],4];
            
            
            string_searchurl=[NSString stringWithFormat:URL_SERCH_USER,[_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],search_user_page];
        }
            break;
            
        default:
            break;
    }
    
    
    NSLog(@"1请求的url = %@",string_searchurl);
    
    
    request_search = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:string_searchurl]];
    __block ASIHTTPRequest * _requset = request_search;
    
    _requset.delegate = self;
    [_requset setTimeOutSeconds:120];
    
    [_requset setCompletionBlock:^{
        
        
        @try {
            searchresaultview.hidden=NO;
            blackcolorview.hidden=YES;
            [searchloadingview stopLoading:1];
            issearchloadsuccess=NO;
            if (mysearchPage==1)
            {
                [self.array_searchresault removeAllObjects];
            }
            
            NSDictionary * dicofsearch = [request_search.responseData objectFromJSONData];
            
            NSLog(@"搜索的信息 -=-=  %@",dicofsearch);
            
            if (mysegment.currentPage == 2)
            {
                [self getWeiBoSearchData:dicofsearch];
                return;
            }
            
            
            
            if (mysegment.currentPage == 3)
            {
                
                NSString * errcode = [NSString stringWithFormat:@"%@",[dicofsearch objectForKey:@"errcode"]];
                
                [searchloadingview stopLoading:1];
                
                int the_count = [[dicofsearch objectForKey:@"count"] intValue];
                
                if (the_count == 0)
                {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到该用户,请检查用户名是否正确" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    
                    [alert show];
                    
                    blackcolorview.hidden=NO;
                    
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
                        
                        [array_search_user removeAllObjects];
                        [_array_searchresault removeAllObjects];
                        
                        searchresaultview.contentOffset = CGPointMake(0,0);
                        
                    }else
                    {
                        
                    }
                    
                    
                    for (int i = 0;i < allkeys.count;i++)
                    {
                        NSDictionary * myDic = [dic111 objectForKey:[allkeys objectAtIndex:i]];
                        
                        PersonInfo * info2 = [[PersonInfo alloc] initWithDictionary:myDic];
                        
                        info2.face_original = [dic111 objectForKey:@"small_avatar"];
                        
                        info2.city = [NSString stringWithFormat:@"%@",[dicofsearch objectForKey:@"location"]];
                        
                        if (info2.username.length !=0)
                        {
                            [_array_searchresault addObject:info2];
                            [array_search_user addObject:info2];
                        }
                    }
                    
                    [searchresaultview reloadData];
                    
                    return;
                    
                }else
                {
                    blackcolorview.hidden=NO;
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到该用户,请检查用户名是否正确" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    
                    [alert show];
                    
                    
                    
                    return;
                }
                
                
                
                
                
                /*
                 
                 NSString * errcode = [NSString stringWithFormat:@"%@",[dicofsearch objectForKey:@"errcode"]];
                 
                 if ([errcode intValue]==0)
                 {
                 NSDictionary * dic111 = [dicofsearch objectForKey:@"bbsinfo"];
                 
                 PersonInfo * info = [[PersonInfo alloc] initWithDictionary:dic111];
                 
                 info.face_original = [dic111 objectForKey:@"small_avatar"];
                 
                 info.city = [NSString stringWithFormat:@"%@",[dicofsearch objectForKey:@"location"]];
                 
                 if (info.username.length !=0)
                 {
                 [array_search_user removeAllObjects];
                 
                 [_array_searchresault addObject:info];
                 
                 [array_search_user addObject:info];
                 }
                 
                 [searchresaultview reloadData];
                 }else
                 {
                 UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到该用户,请检查用户名是否正确" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                 
                 [alert show];
                 blackcolorview.hidden=NO;
                 }
                 
                 return;
                 
                 */
            }
            
            
            //        if ([[dicofsearch objectForKey:@"allnumbers"] integerValue]>0)
            //        {
            if (dicofsearch.count>0) {
                
                if ([[dicofsearch objectForKey:@"allnumbers"] integerValue]>0) {
                    [self.array_searchresault addObjectsFromArray:[dicofsearch objectForKey:@"searchinfo"]];
                    NSLog(@"是有数据的");
                    
                    
                }else{
                    NSLog(@"没有相关数据");
                    
                    if (mysegment.currentPage==0) {
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到相关的新闻信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                        
                        [alert show];
                    }
                    if (mysegment.currentPage==1) {
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到相关的论坛信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                        
                        [alert show];
                    }
                    blackcolorview.hidden=NO;
                    return;
                }
                
                
                
            }
            
            
            //            if (self.array_searchresault.count>0)
            //            {
            //                searchresaultview.tableFooterView=searchloadingview;
            //            }else{
            //                searchresaultview.tableFooterView=nil;
            //            }
            
            if (mysegment.currentPage == 0)
            {
                
                [array_search_zixun removeAllObjects];
                [array_search_zixun addObjectsFromArray:self.array_searchresault];
            }else if (mysegment.currentPage==1)
            {
                [array_search_bbs removeAllObjects];
                [array_search_bbs addObjectsFromArray:self.array_searchresault];
            }else if (mysegment.currentPage==3)
            {
                [array_search_user removeAllObjects];
                [array_search_user addObjectsFromArray:self.array_searchresault];
            }
            
            NSLog(@"self.array_searchresault===%@",self.array_searchresault);
            [searchresaultview reloadData];
            //        }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request_search cancel];
        
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
}


-(void)getWeiBoSearchData:(NSDictionary *)dic11111
{
    if ([[dic11111 objectForKey:@"errcode"] intValue]!=0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到相关的微博信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        blackcolorview.hidden=NO;
        
        [alert show];
        return;
        //<<<<<<< HEAD
        //
        //=======
        //        blackcolorview.hidden=NO;
        //>>>>>>> FETCH_HEAD
    }
    
    NSDictionary * rootObject = [[NSDictionary alloc] initWithDictionary:dic11111];
    
    NSString *errcode =[NSString stringWithFormat:@"%@",[rootObject objectForKey:ERRCODE]];
    
    if ([@"0" isEqualToString:errcode])
    {
        NSDictionary* userinfo = [rootObject objectForKey:@"weiboinfo"];
        
        if ([userinfo isEqual:[NSNull null]])
        {
            
            if (mysearchPage == 1)
            {
                //如果没有微博的话
                NSLog(@"------------没有微博信息---------------");
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到相关的微博信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                
                [alert show];
                blackcolorview.hidden=NO;
                
                return;
            }else
            {
                searchloadingview.normalLabel.text = @"没有更多了";
            }
            
        }else
        {
            NSMutableArray * temp_array =  [zsnApi conversionFBContent:userinfo isSave:NO WithType:0];
            
            [self.array_searchresault addObjectsFromArray:temp_array];
            
            [weibo_search_data addObjectsFromArray:temp_array];
            
            [searchresaultview reloadData];
        }
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tab_];
    
}
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView==_titleView) {
        NSLog(@"_tit.x=====%f",_titleView.contentOffset.x);

        
    }else if (scrollView==imagesc)
    {
        int pageNumber = (int)scrollView.contentOffset.x/DEVICE_WIDTH;
        
        // NSLog(@"------  %d ---  %f",pageNumber,scrollView.contentOffset.x);
        
        _pagecontrol.currentPage = pageNumber;
        
        if (rec_array_title.count>pageNumber)
        {
            _titleimagelabel.text=[NSString stringWithFormat:@"%@",[rec_array_title objectAtIndex:pageNumber]];
            
        }
        
        if (pageNumber < image_mutar.count)
        {
            pageNumber++;
        }else
        {
            pageNumber = 1;
        }
        imagesc.iscount=pageNumber;
        
    }
    else if(scrollView==tab_)
    {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
        if(tab_.contentOffset.y > (tab_.contentSize.height - tab_.frame.size.height+40)) {
            
            [loadview startLoading];
            [self jiazaimore];
        }
        
    }else if(scrollView==newsScrow){
        
        
        NSLog(@"newsss.x===%f",newsScrow.contentOffset.x);
        
        if (newsScrow.contentOffset.x<-40) {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

        }else if(newsScrow.contentOffset.x>3870){
        
//            [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];

        }
        
        
        int   number=(int)newsScrow.contentOffset.x/DEVICE_WIDTH;
        //   NSLog(@"yes当前是%@===number==%d====%f",[array_lanmu objectAtIndex:number],number,newsScrow.contentOffset.x);
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag:99];
        //  imageView.frame=CGRectMake(35/2+48*newsScrow.contentOffset.x/DEVICE_WIDTH, 0, 71/2, 2);
        imageView.center=CGPointMake(28+48*newsScrow.contentOffset.x/DEVICE_WIDTH, 0.5);
        
        
        if (DEVICE_WIDTH<=320) {
            if (number==6) {
                _titleView.contentOffset=CGPointMake(285, 0);
            }
            if (number<6) {
                _titleView.contentOffset=CGPointMake(0, 0);
            }
            if (number>6&&number<12) {
                _titleView.contentOffset=CGPointMake(285, 0);
            }
            if (number==12) {
                _titleView.contentOffset=CGPointMake(310, 0);
                
            }

            
        }//
        else{
            if (number==8) {
                _titleView.contentOffset=CGPointMake(285, 0);
            }
            if (number<8) {
                _titleView.contentOffset=CGPointMake(0, 0);
            }
            if (number>8&&number<12) {
                _titleView.contentOffset=CGPointMake(285, 0);
            }
            if (number==12) {
//                _titleView.contentOffset=CGPointMake(310, 0);
                
            }
        
        }//
        
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    if (scrollView==_titleView) {
        
    }else if(scrollView==tab_) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        
    }else if(scrollView==searchresaultview){
        
        
        if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+40) && scrollView.contentOffset.y > 0)
        {
            if (issearchloadsuccess==NO&&_searchbar.text.length>0) {
                
                issearchloadsuccess=!issearchloadsuccess;
                mysearchPage++;
                if (mysegment.currentPage==3)
                {
                    if (search_user_page*20>=total_count_users)
                    {
                        searchloadingview.normalLabel.text = @"没有更多了";
                        return;
                    }
                    
                    search_user_page++;
                }else{
                    //                    if (self.array_searchresault.count>0) {
                    //                        searchresaultview.tableFooterView=searchloadingview;
                    //                    }else{
                    //
                    //                        searchresaultview.tableFooterView=nil;
                    //                    }
                }
                
                [self searchbythenetework];
                [searchloadingview startLoading];
            }
            
        }
        
    }else if(scrollView ==newsScrow)
    {
        int   number=scrollView.contentOffset.x/DEVICE_WIDTH;
        NSLog(@"/////yes当前是%@===number==%d====%f",[array_lanmu objectAtIndex:number],number,scrollView.contentOffset.x);
        
        
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    
    
    NSLog(@"scrollViewDidEndScrollingAnimation");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    
    
    
    int   number=scrollView.contentOffset.x/DEVICE_WIDTH;
    NSLog(@"前是%@===number==%d====%f",[array_lanmu objectAtIndex:number],number,scrollView.contentOffset.x);
    newsTableview *mytab=(newsTableview*)[self.view viewWithTag:number+800];
    
    
    
    if (mytab.normalarray.count==0) {
        [UIView animateWithDuration:0.5 animations:^{
            [mytab.tab setContentOffset:CGPointMake(0, -80)];
            
            //动画内容
            
        }completion:^(BOOL finished)
         
         {
             
             
             
         }];
        
        rootnewsModel *model=[[rootnewsModel alloc]init];
        [model startloadcommentsdatawithtag:number+800 thetype:[personal place:[array_lanmu objectAtIndex:number]]];
        model.delegate=self;
        
        
    }else{
        NSLog(@"当前已经有数据，不需要刷新");
    }
    
    
    
    
    
}      // called when scroll view grinds to a halt


#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    
    
    
    
	
	[self sendrecommedrequest];
    [self refreshnormal];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

-(void)showguanggao{
    
    downloadtool *tool_=[[downloadtool alloc]init];
    [tool_ setUrl_string:@"http://cmsweb.fblife.com/data/app.ad.txt"];
    tool_.delegate=self;
    
    
    
    
    
    [tool_ start];
    
}


-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    
    @try {
        //  NSDictionary * dic = [data objectFromJSONData];
        NSLog(@"%s",__FUNCTION__);
        NSDictionary *array_test=[data objectFromJSONData];
        NSLog(@"dic== %@",array_test);
        AsyncImageView *guanggao_image=[[AsyncImageView alloc]init];
        guanggao_image.delegate=self;
        if (array_test.count==0) {
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"img"];
            
            NSLog(@"没有找到图片");
            
        }else{
            
            NSString *string_src=[NSString stringWithFormat:@"%@",[array_test objectForKey:@"imgsrc"]];
            
            [guanggao_image loadImageFromURL:string_src withPlaceholdImage:nil];
            
            [[NSUserDefaults standardUserDefaults] setObject:string_src forKey:@"img"];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

#pragma mark--综合首页过来之后，可以定位到某个栏目

-(void)refreshWithZonghe{
    
    
    
    NSLog(@"self.diji===%@",self.str_dijige);
    int mm=[self.str_dijige intValue];
    
    [newsScrow setContentOffset:CGPointMake(DEVICE_WIDTH*(mm-1), 0)];
    
   [self refreshmydatawithtag:mm-1+800];


}



#pragma mark-新的请求新闻和推荐新闻

-(void)loadmorewithtage:(int)_tag page:(int)_page{
    
    
    
    rootnewsModel *model=[[rootnewsModel alloc]init];
    [model loadmorewithtag:_tag thetype:[personal place:[array_lanmu objectAtIndex:_tag-800]] page:_page];
    model.delegate=self;
    NSLog(@"11111111111111111111tag===%d",_tag);
    
}

-(void)refreshmydatawithtag:(int)tag{
    
    
    rootnewsModel *model=[[rootnewsModel alloc]init];
    [model startloadcommentsdatawithtag:tag thetype:[personal place:[array_lanmu objectAtIndex:tag-800]]];
    model.delegate=self;
}

-(void)doneloadmoremornormal:(NSDictionary*)_morenormaldic tag:(int)_tag{
    
    newsTableview *mytab=(newsTableview*)[self.view viewWithTag:_tag];
    
    [mytab newstabreceivemorenormaldic:_morenormaldic];
}
-(void)successloadcommentdic:(NSDictionary *)_comdic mormaldic:(NSDictionary *)_nordic tag:(int)_tag{
    
    NSLog(@"推荐新闻的dic===%@普通新闻的dic=====%@=======%d",_comdic,_nordic,_tag);
    newsTableview *mytab=(newsTableview*)[self.view viewWithTag:_tag];
    [mytab newstabreceivecommentdic:_comdic normaldic:_nordic];
    
    
}

#pragma mark-未知
-(void)downloadtoolError{
    NSLog(@"获取图片失败");
    
}
-(void)seccesDownLoad:(UIImage *)image{
    
}
-(void)handleImageLayout:(AsyncImageView *)tag{
    NSLog(@"成功下载到了图片");
}

#pragma mark-获取广告的
-(void)testmymodelofadvertising{
    if (!admodel) {
        admodel=[[AdvertisingModel alloc]init];
    }
    admodel.delegate=self;
    isHaveNetWork?[admodel startload]:[admodel startload] ;
    
}
-(void)finishload{
    NSLog(@"model获取到了广告");
    isadvertisingoadsuccess=YES;
}
-(void)failedload{
    NSLog(@"model获取广告失败");
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-NewWeiBoCustomCellDelegate


-(void)LogIn
{
    logIn = [LogInViewController sharedManager];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [self presentModalViewController:logIn animated:YES];
}



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
            NSDictionary * dic111 = [request.responseData objectFromJSONData];
            NSLog(@"个人信息 -=-=  %@",dic);
            
            NSString *errcode =[NSString stringWithFormat:@"%@",[dic111 objectForKey:ERRCODE]];
            
            if ([@"0" isEqualToString:errcode])
            {
                NSDictionary * userInfo = [dic111 objectForKey:@"weiboinfo"];
                
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
    
}

-(void)presentToCommentControllerWithInfo:(FbFeed *)info WithCell:(NewWeiBoCustomCell *)theCell
{
   
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
        
        WenJiViewController * wenji111 = [[WenJiViewController alloc] init];
        
        wenji.bId = sortId;
        
        [self setHidesBottomBarWhenPushed:YES];
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        
        [self.navigationController pushViewController:wenji111 animated:YES];
        
        [self setHidesBottomBarWhenPushed:NO];
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
    
    [self presentModalViewController:browser animated:YES];
}




//对应ios6下的横竖屏问题
- (BOOL)shouldAutorotate{
    return  NO;
}
@end
