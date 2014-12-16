//
//  commentViewController.m
//  ZixunDetail
//
//  Created by szk on 13-1-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//101刷新数据，102上传评论，103加载更多

#import "commentViewController.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"
#import "personal.h"
#import "detailcommentViewController.h"
#import "loadingview.h"
#import "LogInViewController.h"
#import "DefaultConstant.h"
#import "NewsCommentModel.h"
#import "NewMineViewController.h"

#import "CustomInputView.h"//少男写的公共评论条


@interface commentViewController (){
    NSDictionary * _dic ;
    NSDictionary *dic_info;
    UIButton *button_face;
    UIImageView *imv_up;
    UIImageView *imv_down;
    BOOL isiphone5;
    detailcommentViewController *detai_comment;
    
    NSString *string_106;//发送评论的评论
    NewMineViewController *_people;
    
    CustomInputView *inputV;//这个是新换的条
    
    
}
@end
@implementation commentViewController
@synthesize string_content,pageN,allcount,string_paixu,string_ID,string_biaoti;
@synthesize string_commentnumber,string_date,string_title,string_author;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    
    [MobClick beginEvent:@"commentViewController"];
    
    self.navigationController.navigationBarHidden=NO;
    
    
    [text_write resignFirstResponder];
    [self facescrowhiden];
    //aview.frame=CGRectMake(0,-249+31, DEVICE_WIDTH,DEVICE_HEIGHT);
    
    NSUserDefaults *user_=[NSUserDefaults standardUserDefaults];
    NSString *string_=@"refresh";
    [user_ setObject:string_ forKey:@"last"];
    [inputV addKeyBordNotification];
    
    [self fasongpinglunqingqiu];
    
    
    
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [inputV deleteKeyBordNotification];
    
    self.navigationController.navigationBarHidden = YES;
    
    [MobClick endEvent:@"commentViewController"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //提醒的
    self.thezkingAlertV=[[ZkingAlert alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH,DEVICE_HEIGHT) labelString:@""];
    _thezkingAlertV.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_thezkingAlertV];
    
    
    whichsectionopend=100000;
    isopen=YES;
    isiphone5=[personal isiphone5];
    
    isloadsuccess=YES;
    isup=YES;
    pageN=1;
    
    array_time=[[NSMutableArray alloc]init];
    array_tid=[[NSMutableArray alloc]init];
    array_peopleid=[[NSMutableArray alloc]init];
    
    array_content=[[NSMutableArray alloc]init];
    array_name=[[NSMutableArray alloc]init];
    array_reply=[[NSMutableArray alloc]init];
    array_image=[[NSMutableArray alloc]init];
    array_weiboinfo=[[NSMutableArray alloc]init];
    dic_info=[[NSMutableDictionary alloc]init];
    
    
    self.string_paixu=[[NSString alloc]initWithFormat:@"up"];
    
    aview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    [self.view addSubview:aview];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    //导航部分
    
    self.title = @"评论";
    
    //    UIColor * cc = [UIColor blackColor];
    //
    //    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    //
    //    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIButton *button_comment;
    //
    if (MY_MACRO_NAME) {
        button_comment=[[UIButton alloc]initWithFrame:CGRectMake(18, (44-37/2)/2, 50, 37/2)];
        
    }else{
        button_comment=[[UIButton alloc]initWithFrame:CGRectMake(8, (44-37/2)/2, 50, 37/2)];
        
    }
    button_comment.tag=26;
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(paixu) forControlEvents:UIControlEventTouchUpInside];
    // [button_comment setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?@"ios_zhuanfa44_37.png": @"replay.png"] forState:UIControlStateNormal];
    [button_comment setTitle:@"排序" forState:UIControlStateNormal];
    [button_comment setTitleColor:RGBCOLOR(128, 128, 128) forState:UIControlStateNormal];
    
    
    UIButton *   rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightView addTarget:self action:@selector(paixu) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button_comment];
    rightView.backgroundColor=[UIColor clearColor];
    
    
    //    button_comment.userInteractionEnabled=NO;
    //    button_comment.backgroundColor=[UIColor redColor];
    
    
    //    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    //排序不先要，所以先隐藏掉
    //    self.navigationItem.rightBarButtonItem=comment_item;
    
    
    
    //    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
    //
    //        //iOS 5 new UINavigationBar custom background
    //              [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
    //    }
    //    //self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:74 green:73 blue:72 alpha:1];
    //
    //    UIButton *button_back=[[UIButton alloc]initWithFrame:MY_MACRO_NAME? CGRectMake(-5, (44-43/2)/2, 12, 43/2):CGRectMake(5, (44-43/2)/2, 12, 43/2)];
    //
    //    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    //    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    //
    //    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    //    [back_view addSubview:button_back];
    //    back_view.backgroundColor=[UIColor clearColor];
    //    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    //    self.navigationItem.leftBarButtonItem=back_item;
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    //  self.navigationItem.title=@"新闻中心";
    //    self.navigationItem.titleView=yaoxibiaoti;
    
    
    //评论部分
   
    view_pinglun=[[UIView alloc]initWithFrame:CGRectMake(0,DEVICE_HEIGHT-103,DEVICE_WIDTH, 41)];
    
    //点击后键盘收起
    
    UITapGestureRecognizer *backkeyboard =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backkeyboard)];
    
    // Set required taps and number of touches
    [backkeyboard setNumberOfTapsRequired:1];
    [backkeyboard setNumberOfTouchesRequired:1];
    // [aview addGestureRecognizer:backkeyboard];
    tab_pinglunliebiao.userInteractionEnabled=YES;
    [tab_pinglunliebiao addGestureRecognizer:backkeyboard];
    
    
    
    [self prepairCommentTiao];
    
    
    //  [aview addSubview:view_pinglun];
    view_pinglun.backgroundColor=RGBCOLOR(243, 243, 243);
    
    UIImageView *image_write=[[UIImageView alloc]initWithFrame:CGRectMake(40,(41-58/2)/2, 421/2, 58/2)];
    image_write.image=[UIImage imageNamed:@"ios7_commentkuang421_58.png"];
    
    [view_pinglun addSubview:image_write];
    
    
    text_write=[[UITextField alloc]initWithFrame:CGRectMake(45,MY_MACRO_NAME? (41-14)/2:(41-17)/2, 200,MY_MACRO_NAME? 15:17)];
    text_write.backgroundColor=[UIColor clearColor];
    [view_pinglun addSubview:text_write];
    view_paixu.userInteractionEnabled=NO;
    
    
    
    text_write.font=[UIFont systemFontOfSize:14];
    text_write.placeholder=@"说两句，转一下";
    text_write.text=@"";
    text_write.delegate=self;
    text_write.returnKeyType=UIReturnKeySend;
    
    
    UIButton *button_sender=[[UIButton alloc]initWithFrame:CGRectMake(520/2, (41-56/2)/2, 50, 56/2)];
    button_sender.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios7_newssendbutton_99_56.png"]];
    [view_pinglun addSubview:button_sender];
    [button_sender addTarget:self action:@selector(fabiao) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    isjianpan=NO;
    button_face=[[UIButton alloc]initWithFrame:CGRectMake(10, (40-43/2)/2, 43/2, 43/2)];
    [button_face setBackgroundImage:[UIImage imageNamed:@"ios7_face43_43.png"] forState:UIControlStateNormal];
    [view_pinglun addSubview:button_face];
    [button_face addTarget:self action:@selector(faceview) forControlEvents:UIControlEventTouchUpInside];
    button_face.backgroundColor=[UIColor clearColor];
    
    
    UIButton *backfacebutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backfacebutton addTarget:self action:@selector(faceview) forControlEvents:UIControlEventTouchUpInside];
    backfacebutton.backgroundColor=[UIColor clearColor];
    [view_pinglun addSubview:backfacebutton];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,0.5)];
    lineView.backgroundColor= RGBCOLOR(201,201,201);
    [view_pinglun addSubview:lineView];
    
    //有关facescroview,刚开始是隐藏的
    
    faceScrollView = [[WeiBoFaceScrollView alloc] initWithFrame:CGRectMake(0, 900, self.view.frame.size.width, 215) target:self];
    //    faceScrollView.pagingEnabled = YES;
    faceScrollView.delegate=self;
    faceScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:faceScrollView];
    pageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0,900,DEVICE_WIDTH,25)];
    
    pageControl.center = CGPointMake(DEVICE_WIDTH/2,460-12.5);
    
    pageControl.numberOfPages = 3;
    
    pageControl.currentPage = 0;
    
    [self.view addSubview:pageControl];
    
    //有关下拉刷新
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tab_pinglunliebiao.bounds.size.height, self.view.frame.size.width, tab_pinglunliebiao.bounds.size.height)];
		view.delegate = self;
		//[tab_pinglunliebiao addSubview:view];
		_refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    
    //load
    //评论列表
    
    tab_pinglunliebiao=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,DEVICE_HEIGHT-64-44)];
    
    //    [tab_pinglunliebiao headerViewForSection:0];
    
    
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
    loadview.backgroundColor=[UIColor clearColor];
    
    tab_pinglunliebiao.separatorColor=[UIColor clearColor];
    tab_pinglunliebiao.backgroundColor=RGBCOLOR(245, 245, 245);
    // tab_pinglunliebiao.backgroundColor=[UIColor redColor];
    
    tab_pinglunliebiao.delegate=self;
    tab_pinglunliebiao.dataSource=self;
    tab_pinglunliebiao.userInteractionEnabled=YES;
    [aview addSubview:tab_pinglunliebiao];
    // aview.backgroundColor=[UIColor greenColor];
    
    UISwipeGestureRecognizer *_swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backto)];
    _swipe.direction=UISwipeGestureRecognizerDirectionRight;
    [tab_pinglunliebiao addGestureRecognizer:_swipe];
    
    // tab_pinglunliebiao.tableFooterView=loadview;
    tab_pinglunliebiao.tableHeaderView = _refreshHeaderView;
    
    //排序
    view_paixu=[[UIView alloc]initWithFrame:CGRectMake(200, 44-44, 120, 90)];
    view_paixu.backgroundColor=[UIColor clearColor];
    [aview addSubview:view_paixu];
    
    imv_up=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 50)];
    imv_up.image=[UIImage imageNamed:@"up268_100.png"];
    [ view_paixu addSubview:imv_up];
    imv_up.hidden=YES;
    duihaoup=[[UIImageView alloc]initWithFrame:CGRectMake(90, 20, 25, 25)];
    duihaoup.image=[UIImage imageNamed:@"sel38_38.png"];
    duihaoup.hidden=NO;
    [imv_up addSubview:duihaoup];
    
    imv_down=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 120, 40)];
    imv_down.hidden=YES;
    imv_down.image=[UIImage imageNamed:@"down268_82.png"];
    [ view_paixu addSubview:imv_down];
    duihaodown=[[UIImageView alloc]initWithFrame:CGRectMake(90, 10, 25, 25)];
    duihaodown.image=[UIImage imageNamed:@"sel38_38.png"];
    duihaodown.hidden=YES;
    [imv_down addSubview:duihaodown];
    
    UITapGestureRecognizer *oneFingerOneTaps =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapup:)];
    
    // Set required taps and number of touches
    [oneFingerOneTaps setNumberOfTapsRequired:1];
    [oneFingerOneTaps setNumberOfTouchesRequired:1];
    
    // Add the gesture to the view
    [imv_up addGestureRecognizer:oneFingerOneTaps];
    imv_up.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *oneFingerOneTaps2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapdown:)];
    
    // Set required taps and number of touches
    [oneFingerOneTaps2 setNumberOfTapsRequired:1];
    [oneFingerOneTaps2 setNumberOfTouchesRequired:1];
    
    
    
    [imv_down addGestureRecognizer:oneFingerOneTaps2];
    imv_down.userInteractionEnabled=YES;
    
    
    //    //动态获取键盘高度
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //    //点击隐藏键盘按钮所触发的事件
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /*发表评论的接口*/
    //http://t.fblife.com/openapi/index.php?mod=comment&code=commentadd&sortid=511&content=ttttt&title=ssfsf&fromtype=b5eeec0b&authkey=V2gAalEwUzcCMlM/USoH1QHAVYEMllqyUZQ=
    //获取评论的接口
    //http://t.fblife.com/openapi/index.php?mod=comment&code=commentlist&sortid=511&fbtype=json
    
    //数据解析部分
    
    
    label_noneshuju=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    label_noneshuju.backgroundColor=[UIColor clearColor];
    label_noneshuju.text=@"暂无评论";
    label_noneshuju.textAlignment=NSTextAlignmentCenter;
    label_noneshuju.textColor=[UIColor grayColor];
    
    label_meiduoshao=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    label_meiduoshao.backgroundColor=[UIColor clearColor];
    label_meiduoshao.text=@"没有更多数据";
    label_meiduoshao.textAlignment=NSTextAlignmentCenter;
    label_meiduoshao.font=[UIFont systemFontOfSize:12];
    label_meiduoshao.alpha=0.7;
    label_meiduoshao.textColor=[UIColor lightGrayColor];
}


#pragma mark--新版的评论条

-(void)prepairCommentTiao{
    
    inputV=[[CustomInputView alloc]initWithFrame:CGRectMake(0,DEVICE_HEIGHT-41-64, DEVICE_WIDTH, 41)];
    
    
    __weak typeof(self)wself=self;
    
    [inputV loadAllViewWithPinglunCount:self.string_commentnumber WithType:1 WithPushBlock:^(int type){
        
        if (type == 0)//评论
        {
            
        }else//分页
        {
            
        }
        
        
    } WithSendBlock:^(NSString *content, BOOL isForward) {
        //发表
        
        
        inputV.send_button.userInteractionEnabled=NO;
        
        
        SzkLoadData *loaddata=[[SzkLoadData alloc]init];
        
        NSString *string_102=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentadd&sort=%@&sortid=%d&content=%@&title=%@&fromtype=b5eeec0b&authkey=%@",self.sortString,[self.string_ID integerValue],[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.string_title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
        
        
        NSLog(@"str102===%@",string_102);
        
        [loaddata SeturlStr:string_102 mytest:^(NSDictionary *dicinfo, int errcode) {
            
            inputV.send_button.userInteractionEnabled=YES;
            
            
            if ([[dicinfo objectForKey:@"errcode"] intValue]==0) {
                
                [inputV hiddeninputViewTap];
                [inputV.pinglun_button setTitle:[NSString stringWithFormat:@"%d",[self.string_commentnumber intValue]+1] forState:UIControlStateNormal];
                
                [_thezkingAlertV zkingalertShowWithString:@"评论成功"];
                
                [wself fasongpinglunqingqiu];
                
                [[NSNotificationCenter defaultCenter]
                 
                 postNotificationName:@"commentNumberaddandadd" object:nil];
                
                
            }
            
            
            
            NSLog(@"评论返回的数据===%@",dicinfo);
        }];
    }];
    
    [aview addSubview:inputV];
}




#pragma mark-开始编辑评论内容
-(void)textwrotebecomfirstresponder{
    [self textFieldDidBeginEditing:text_write];
}

#pragma mark-点击之后让键盘收起
-(void)backkeyboard{
    [text_write resignFirstResponder];
    [self  facescrowhiden];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
   // aview.frame=CGRectMake(0, 0, DEVICE_WIDTH,DEVICE_HEIGHT);
    [UIView commitAnimations];
    
    
}

//pagecontrol
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    //获取当前页码
    int index = fabs(faceScrollView.contentOffset.x) / faceScrollView.frame.size.width;
    
    //设置当前页码
    pageControl.currentPage = index;
}
#pragma mark 解析jason数据
-(void)fasongpinglunqingqiu{
    
    label_bigbiaoti.text=self.string_biaoti;
    
    isloadsuccess=YES;
    pageN=1;
    NSUserDefaults *user_=[NSUserDefaults standardUserDefaults];
    NSString *string_=@"shuaxinle";
    [user_ setObject:string_ forKey:@"last"];
    if (isup) {
        NSLog(@".......................");
        
        NSURL *url101 = [NSURL URLWithString:[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentlist&sort=%@&sortid=%d&fbtype=json&page=1&order=1",self.sortString,[self.string_ID integerValue]]];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url101];
        request.tag=101;
        [request setDelegate:self];
        [request startAsynchronous];
        NSLog(@"开始请求评论数据");
    }else{
        
        NSURL *url101 = [NSURL URLWithString:[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentlist&sort=%@&sortid=%d&fbtype=json&page=1&order=2",self.sortString,[self.string_ID integerValue]]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url101];
        request.tag=101;
        [request setDelegate:self];
        [request startAsynchronous];
        NSLog(@"开始加载评论数据");
        
    }
    
}
-(void)jiazaimore{
    
    if (isloadsuccess==YES) {
        isloadsuccess=!isloadsuccess;
        pageN++;
        BOOL isqingqiu=     [personal islastpage:allcount pagenumber:pageN];
        if (isqingqiu==YES) {
            NSString *string103=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentlist&sort=%@&sortid=%@&fbtype=json&page=%d",self.sortString,self.string_ID,pageN];
            NSURL *url103 = [NSURL URLWithString:string103];
            
            NSLog(@"ahaurl====%@",string103);
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url103];
            request.tag=103;
            [request setDelegate:self];
            [request startAsynchronous];
            NSLog(@"开始加载更多数据");
            
        }else{
            
            [loadview stopLoading:1];
            NSUserDefaults *user_=[NSUserDefaults standardUserDefaults];
            NSString *string_=@"lastpage";
            [user_ setObject:string_ forKey:@"last"];
            
        }
        
    }
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //       content = ttttt;
    // dateline = 1358138263;
    NSLog(@"??????");
    switch (request.tag) {
        case 101:{
            NSLog(@"xxxxxx");
            
            NSLog(@"获取评论列表");
            NSData *data=[request responseData];
            _dic = [data objectFromJSONData];
            NSLog(@"_dic======%@",_dic);
            allcount=[[_dic objectForKey:@"total"]intValue];
            self.string_commentnumber=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"total"]];
            [inputV.pinglun_button setTitle:self.string_commentnumber forState:UIControlStateNormal];
            [array_name removeAllObjects];
            [array_reply removeAllObjects];
            [array_time removeAllObjects];
            [array_tid removeAllObjects];
            [array_content removeAllObjects];
            [array_image removeAllObjects];
            [array_peopleid removeAllObjects];
            
            array_weiboinfo=[[NSMutableArray alloc]init];
            array_weiboinfo= [_dic objectForKey:@"weiboinfo"];
            if (allcount==0) {
                NSLog(@"jiutama0ge");
                // tab_pinglunliebiao.tableFooterView=label_noneshuju;
                
            }else{
                NSLog(@"weiboinfo===%@",array_weiboinfo);
                if ([array_weiboinfo count]!=0)
                    
                {
                    
                    for (int i=0; i<[array_weiboinfo count]; i++) {
                        NSMutableDictionary *dic_3ge=[array_weiboinfo objectAtIndex:i];
                        NSString *string_name=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"username"]];
                        [array_name addObject:string_name];
                        
                        
                        
                        NSString *string_reply=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"replys"]];
                        [array_reply addObject:string_reply];
                        
                        NSString *string_time=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"dateline"]];
                        [array_time addObject:string_time];
                        
                        NSString *string_tid=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"tid"]];
                        [array_tid addObject:string_tid];
                        
                        NSString *string_image=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"face_small"]];
                        [array_image addObject:string_image];
                        
                        NSString *string_peopleuid=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"uid"]];
                        [array_peopleid addObject:string_peopleuid];
                        
                        
                        
                        NSString *string_neirong=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"content"]];
                        NSString *stringtest=[string_neirong stringByReplacingOccurrencesOfString:@"[" withString:@" ["];
                        NSArray *arraytest = [stringtest componentsSeparatedByString:@" "];
                        
                        [array_content addObject:arraytest];
                        
                        [tab_pinglunliebiao reloadData];
                    }
                    if([array_content count]>0&&[array_content count]<20){
                        
                        tab_pinglunliebiao.tableFooterView=label_meiduoshao;
                        
                    }else{
                        tab_pinglunliebiao.tableFooterView=loadview;
                        
                    }
                    
                    if (array_weiboinfo.count<20) {
                        tab_pinglunliebiao.tableFooterView=label_meiduoshao;
                        
                    }
                    
                    if (array_weiboinfo.count==0&&array_content==0) {
                        tab_pinglunliebiao.tableFooterView=label_noneshuju;
                        
                    }
                    
                }
                else {
                    NSLog(@"wocao ,zhenmeiyou");
                    NSLog(@"array_content==%@",array_content);}
                // [tab_pinglunliebiao reloadData];
                
            }
            
        }
            break;
        case 102:{
            
            
            NSData *data=[request responseData];
            
            _dic = [data objectFromJSONData];
            
            NSLog(@"评论返回数据_dic======%@",_dic);
            NSLog(@"上传评论");
            if ([[_dic objectForKey:@"errcode"] integerValue]!=0) {
                NSString *stringerr=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"data"]];
                UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:stringerr delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert_ show];
            }else{
                [self fasongpinglunqingqiu];
            }
            [activity stopAnimating];
            
            
        }
            
            break;
        case 103:{
            
            
            isloadsuccess=!isloadsuccess;
            NSData *dataloadmore=[request responseData];
            NSDictionary *dic_loadmore=[dataloadmore objectFromJSONData];
            
            
            
            NSLog(@"==dic_loadmore====%@",dic_loadmore);
            
            if (!array_weiboinfo) {
                array_weiboinfo=[[NSMutableArray alloc]init];
            }else{
                
                
                @try {
                    array_weiboinfo= [dic_loadmore objectForKey:@"weiboinfo"];
                    
                    
                    
                    for (int i=0; i<[array_weiboinfo count]; i++) {
                        NSMutableDictionary *dic_3ge=[array_weiboinfo objectAtIndex:i];
                        NSString *string_name=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"username"]];
                        [array_name addObject:string_name];
                        
                        
                        NSString *string_reply=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"replys"]];
                        [array_reply addObject:string_reply];
                        
                        NSString *string_time=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"dateline"]];
                        [array_time addObject:string_time];
                        
                        NSString *string_image=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"face_small"]];
                        [array_image addObject:string_image];
                        
                        NSString *string_peopleuid=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"uid"]];
                        [array_peopleid addObject:string_peopleuid];
                        
                        NSString *string_tid=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"tid"]];
                        [array_tid addObject:string_tid];
                        
                        
                        
                        NSString *string_neirong=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"content"]];
                        NSString *stringtest=[string_neirong stringByReplacingOccurrencesOfString:@"[" withString:@" ["];
                        NSArray *arraytest = [stringtest componentsSeparatedByString:@" "];
                        
                        [array_content addObject:arraytest];
                        
                        if([array_content count]>0&&[array_content count]<20){
                            
                            tab_pinglunliebiao.tableFooterView=label_meiduoshao;
                            
                        }else{
                            tab_pinglunliebiao.tableFooterView=loadview;
                            
                        }
                        
                        if (array_weiboinfo.count<20) {
                            tab_pinglunliebiao.tableFooterView=label_meiduoshao;
                            isloadsuccess=NO;
                            
                        }
                        
                        if (array_weiboinfo.count==0&&array_content==0) {
                            tab_pinglunliebiao.tableFooterView=label_noneshuju;
                            isloadsuccess=NO;
                            
                        }
                        
                        
                        
                    }
                    
                }
                @catch (NSException *exception) {
                    NSLog(@"catch====");
                    
                }
                @finally {
                    [tab_pinglunliebiao reloadData];
                    [loadview stopLoading:1];
                    
                }
                
                
                
                
                
            }
        }
            
            break;
        default:{
        }
            break;
    }
    
    
}

#pragma mark-获取评论付值
-(void)pinglnjieguochuli{
    NSLog(@"获取评论列表");
    allcount=[[_dic objectForKey:@"total"]intValue];
    [array_name removeAllObjects];
    [array_reply removeAllObjects];
    [array_time removeAllObjects];
    [array_tid removeAllObjects];
    [array_content removeAllObjects];
    
    array_weiboinfo=[[NSMutableArray alloc]init];
    array_weiboinfo= [_dic objectForKey:@"weiboinfo"];
    NSLog(@"array_weiboinfo=%@",array_weiboinfo);
    for (int i=0; i<[array_weiboinfo count]; i++)
    {
        NSMutableDictionary *dic_3ge=[array_weiboinfo objectAtIndex:i];
        NSString *string_name=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"username"]];
        [array_name addObject:string_name];
        
        NSString *reply=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"replys"]];
        [array_reply addObject:reply];
        
        NSString *string_tid=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"tid"]];
        [array_tid addObject:string_tid];
        
        
        
        
        NSString *string_time=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"dateline"]];
        [array_time addObject:string_time];
        
        NSString *string_neirong=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"content"]];
        NSString *stringtest=[string_neirong stringByReplacingOccurrencesOfString:@"[" withString:@" ["];
        NSArray *arraytest = [stringtest componentsSeparatedByString:@" "];
        
        [array_content addObject:arraytest];
        
    }
}
#pragma mark-获取评论结果
-(void)shangchuanpinglunchuli{
    NSLog(@"上传评论");
    [activity stopAnimating];
    [self fasongpinglunqingqiu];
    
}
#pragma mark-加载更多数据处理
-(void)jiazaigengduoshujuchuli{
    
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求错误");
    [activity stopAnimating];
    [loadview stopLoading:1];
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alertview show];
}
#pragma mark-按时间排序的
-(void)paixu{
    NSLog(@"paixu");
    if (!ispaixu) {
        [self show];
        
    }else{
        [self hiden];
    }
}
-(void)show{
    ispaixu=!ispaixu;
    
    imv_down.hidden=NO;
    imv_up.hidden=NO;
}
-(void)hiden{
    ispaixu=!ispaixu;
    
    imv_down.hidden=YES;
    imv_up.hidden=YES;
    
}
-(void)tapup:(UIGestureRecognizer *)sender{
    isup=YES;
    NSLog(@"up");
    duihaoup.hidden=NO;
    duihaodown.hidden=YES;
    self.string_paixu=[[NSString alloc]initWithFormat:@"up"];
    [self hiden];
    [self fasongpinglunqingqiu];
}
-(void)tapdown:(UIGestureRecognizer *)sender{
    isup=NO;
    [self hiden];
    duihaodown.hidden=NO;
    duihaoup.hidden=YES;
    [self fasongpinglunqingqiu];
    self.string_paixu=[[NSString alloc]initWithFormat:@"down"];
    NSLog(@"down");
}
#pragma mark tableviewdelegate and datesource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }else if(section==1)
    {
        return 0;
    }else{
        if (section==whichsectionopend) {
            return [arrayofcommentc count];
        }else{
            return 0;
        }
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *stringcell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stringcell];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dic_infocommofcomm=[arrayofcommentc objectAtIndex:indexPath.row];
    
    UIView *otherheaderview=[[UIView alloc]init];
    
    UILabel *label_name=[[UILabel alloc]initWithFrame:CGRectMake(55, 9, 100, 20)];
    label_name.backgroundColor=[UIColor clearColor];
    label_name.font=[UIFont boldSystemFontOfSize:14.f];
    
    UILabel *label_time=[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-80, 7, 75, 15)];
    label_time.textAlignment=NSTextAlignmentLeft;
    label_time.backgroundColor=[UIColor clearColor];
    label_time.textColor=RGBCOLOR(170, 170, 170);
    label_time.font=[UIFont fontWithName:@"Helvetica" size:12.0];
    
    //     UILabel *label_content=[[UILabel alloc]initWithFrame:CGRectMake(37, 25, 290, 20)];
    
    [otherheaderview addSubview:label_time];
    
    AsyncImageView *image_head=[[AsyncImageView alloc]initWithFrame:CGRectMake(11, 13, 35, 35)];
    
    CALayer *l = [image_head layer];   //获取ImageView的层
    [l setMasksToBounds:YES];
    [l setCornerRadius:2.0f];
    
    if ([arrayofcommentc count]!=0) {
        NSLog(@"image==%@",array_image);
        [ image_head loadImageFromURL:[dic_infocommofcomm objectForKey:@"face_original"] withPlaceholdImage:[UIImage imageNamed:@"head_img64X64.png"]];
        image_head.tag=[[dic_infocommofcomm objectForKey:@"uid"] integerValue];
        image_head.backgroundColor=[UIColor clearColor];
        UITapGestureRecognizer *_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(turntopeoplewithuid:)];
        image_head.userInteractionEnabled=YES;
        [image_head addGestureRecognizer:_tap];
        [otherheaderview addSubview:image_head];
        
        
        // label_content.text=[NSString stringWithFormat:@"%@",[array_content objectAtIndex:section-2]];
        label_name.text=[NSString stringWithFormat:@"%@",[dic_infocommofcomm objectForKey:@"username"]] ;
        NSString *stringtime=[personal timchange:[NSString stringWithFormat:@"%@",[dic_infocommofcomm objectForKey:@"dateline"]]];
        
        
        
        label_time.text=stringtime;
        
        
        NSString *string_neirong=[NSString stringWithFormat:@"%@",[dic_infocommofcomm objectForKey:@"content"]];
        NSString *stringtest=[string_neirong stringByReplacingOccurrencesOfString:@"[" withString:@" ["];
        NSArray *arraytest = [stringtest componentsSeparatedByString:@" "];
        
        CGFloat haha=[self qugaodu:arraytest];
        
        UIView *aview1=[self assembleMessageAtIndex:arraytest];
        aview1.frame=CGRectMake(55, 30, 250, aview1.frame.size.height);
        [otherheaderview addSubview:aview1];
        
        otherheaderview.frame=CGRectMake(0, 0, DEVICE_WIDTH, haha+48);
        
        UIImageView *imagexian=[[UIImageView alloc]initWithFrame:CGRectMake(0, haha+44, DEVICE_WIDTH, 4)];
        imagexian.image=[UIImage imageNamed:@"lineofnews@2x.png"];
        [otherheaderview addSubview:imagexian];
        otherheaderview.backgroundColor=RGBCOLOR(247, 247, 247);
        
        [cell.contentView addSubview:otherheaderview];
    }
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic_infocommofcomm=[arrayofcommentc objectAtIndex:indexPath.row];
    NSString *string_neirong=[NSString stringWithFormat:@"%@",[dic_infocommofcomm objectForKey:@"content"]];
    NSString *stringtest=[string_neirong stringByReplacingOccurrencesOfString:@"[" withString:@" ["];
    NSArray *arraytest = [stringtest componentsSeparatedByString:@" "];
    
    CGFloat haha=[self qugaodu:arraytest]+44;
    
    return haha;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2+[array_name count];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        
        UIView *firstsectionview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 156/2)];
        firstsectionview.backgroundColor=RGBCOLOR(255, 255, 255);
        UILabel *label_bigtitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, DEVICE_WIDTH-20, 30)];
        label_bigtitle.font=[UIFont systemFontOfSize:20];
        label_bigtitle.lineBreakMode = UILineBreakModeWordWrap|UILineBreakModeTailTruncation;
        label_bigtitle.backgroundColor=[UIColor clearColor];
        label_bigtitle.text=self.string_title;
        label_bigtitle.numberOfLines=0;
        NSLog(@"slafjlasjflka=%@",label_bigtitle.text);
        
        
        CGSize constraintSize = CGSizeMake(300, MAXFLOAT);
        CGSize labelSize = [label_bigtitle.text sizeWithFont:label_bigtitle.font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByCharWrapping];
        label_bigtitle.frame=CGRectMake(10, 10, 300, labelSize.height);
        
        
        label_bigtitle.textAlignment=UITextAlignmentLeft;
        [firstsectionview addSubview:label_bigtitle];
        
        
        UILabel *label_mytime=[[UILabel alloc]initWithFrame:CGRectMake(10, labelSize.height+15, 80, 20)];
        label_mytime.font=[UIFont systemFontOfSize:11];
        label_mytime.textAlignment=UITextAlignmentLeft;
        label_mytime.textColor=[UIColor grayColor];
        label_mytime.text=self.string_date;
        label_mytime.backgroundColor=[UIColor clearColor];
        [firstsectionview addSubview:label_mytime];
        if ([self.sortString isEqualToString:@"7"]) {
            UILabel *label_fblife=[[UILabel alloc]initWithFrame:CGRectMake(90,labelSize.height+15, 60, 20)];
            label_fblife.font=[UIFont systemFontOfSize:11];
            label_fblife.textAlignment=UITextAlignmentLeft;
            label_fblife.textColor=[UIColor grayColor];
            label_fblife.text=@"越野e族";
            label_fblife.backgroundColor=[UIColor clearColor];
            [firstsectionview addSubview:label_fblife];
            
            UILabel *label_comment=[[UILabel alloc]initWithFrame:CGRectMake(150, labelSize.height+15, 100, 20)];
            label_comment.font=[UIFont systemFontOfSize:11];
            label_comment.textAlignment=UITextAlignmentLeft;
            label_comment.textColor=[UIColor grayColor];
            label_comment.backgroundColor=[UIColor clearColor];
            label_comment.text=[NSString stringWithFormat:@"%@" ,self.string_author ];
            [firstsectionview addSubview:label_comment];
            
            
        }
        
        
        
        
        
        
        return firstsectionview ;
    }else if(section==1){
        UIImageView *secondimgv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 30)];
        // secondimgv.image=[[UIImage imageNamed:@"pinglun_bg2856.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        secondimgv.backgroundColor=[UIColor whiteColor];
        
        
        
        //  self.string_commentnumber=[NSString stringWithFormat:@"%d",array_name.count];
        
        //判断，如果等于0，就是没有数据
        if ([self.string_commentnumber integerValue]==0) {
            //上面带箭头的线
            UIImageView *img_topline=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weibo_detai_line.png"]];
            img_topline.center=CGPointMake(DEVICE_WIDTH/2, 2);
            [secondimgv addSubview:img_topline];
            //中间的那个图
            
            UIImageView *img_iconnone=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_nonecomment121_114.png"]];
            img_iconnone.center =CGPointMake(DEVICE_WIDTH/2, 70);
            [secondimgv addSubview:img_iconnone];
            
            //最下面的还没有人评论
            
            UILabel *label_none=[[UILabel alloc]initWithFrame:CGRectMake(0, 105, DEVICE_WIDTH, 20)];
            
            label_none.textAlignment=UITextAlignmentCenter;
            label_none.textColor=RGBCOLOR(205, 205, 205);
            label_none.text=@"还没有人评论";
            label_none.font=[UIFont systemFontOfSize:15];
            [secondimgv addSubview:label_none];
            
            
            
        }else{
            UILabel *label_commentnumber=[[UILabel alloc]initWithFrame:CGRectMake(11, 5, 220, 20)];
            label_commentnumber.font=[UIFont systemFontOfSize:15];
            label_commentnumber.backgroundColor=[UIColor clearColor];
            label_commentnumber.text=[NSString stringWithFormat:@"最新评论 (%@)",self.string_commentnumber];
            label_commentnumber.textColor=RGBCOLOR(1, 1, 1);
            [secondimgv addSubview:label_commentnumber];
            secondimgv.backgroundColor=RGBCOLOR(250, 250, 250);
        }
        
        
        
        
        return secondimgv;
        
    }
    
    else  {
        
        UIView *otherheaderview=[[UIView alloc]init];
        
        UILabel *label_name=[[UILabel alloc]initWithFrame:CGRectMake(55, 9, 100, 20)];
        label_name.backgroundColor=[UIColor clearColor];
        label_name.textColor= RGBCOLOR(90,107,148);
        label_name.font=[UIFont boldSystemFontOfSize:15];
        
        
        UILabel *label_time=[[UILabel alloc]init];
        label_time.backgroundColor=[UIColor clearColor];
        label_time.textColor=RGBCOLOR(170, 170, 170);
        label_time.font=[UIFont fontWithName:@"Helvetica" size:12.0];
        
        UIImageView *img_reply=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weibo_detail_talk.png"]];
        
        img_reply.tag=section+2000-2;
        
        
        
        
        UILabel *label_replys=[[UILabel alloc]init];
        label_replys.backgroundColor=[UIColor clearColor];
        label_replys.textColor=RGBCOLOR(49 , 49, 49);
        label_replys.font=[UIFont fontWithName:@"Helvetica" size:13.0];
        
        
        //     UILabel *label_content=[[UILabel alloc]initWithFrame:CGRectMake(37, 25, 290, 20)];
        
        [otherheaderview addSubview:label_name];
        [otherheaderview addSubview:label_time];
        
        AsyncImageView *image_head=[[AsyncImageView alloc]initWithFrame:CGRectMake(11, 13, 35, 35)];
        
        //        CALayer *l = [image_head layer];   //获取ImageView的层
        //        [l setMasksToBounds:YES];
        //        [l setCornerRadius:2.0f];
        
        if ([array_name count]!=0) {
            
            NSLog(@"image==%@",array_image);
            [image_head loadImageFromURL:[array_image objectAtIndex:section-2] withPlaceholdImage:[UIImage imageNamed:@"head_img64X64.png"]];
            image_head.tag=section+100;
            
            image_head.backgroundColor=[UIColor clearColor];
            UITapGestureRecognizer *_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(turntopeople:)];
            image_head.userInteractionEnabled=YES;
            [image_head addGestureRecognizer:_tap];
            [otherheaderview addSubview:image_head];
            
            // label_content.text=[NSString stringWithFormat:@"%@",[array_content objectAtIndex:section-2]];
            label_name.text=[NSString stringWithFormat:@"%@",[array_name objectAtIndex:section-2]];
            NSString *stringtime=[personal timechange:[NSString stringWithFormat:@"%@",[array_time objectAtIndex:section-2]]];
            
            label_time.text=stringtime;
            
            NSArray *array=[array_content objectAtIndex:section-2];
            
            CGFloat haha=[self qugaodu:array];
            
            UIView *aview1=[self assembleMessageAtIndex:array];
            aview1.frame=CGRectMake(57 , 34, 250, aview1.frame.size.height);
            aview1.backgroundColor=[UIColor whiteColor];
            [otherheaderview addSubview:aview1];
            label_time.frame=CGRectMake(DEVICE_WIDTH-75, 10, 100, 20);
            img_reply.frame=CGRectMake(DEVICE_WIDTH-40, haha+49, 26/2, 25/2);
            // [otherheaderview addSubview:img_reply];
            
            label_replys.frame=CGRectMake(300, haha+44, 100, 20);
            label_replys.text=[NSString stringWithFormat:@"%@",[array_reply objectAtIndex:section-2]];
            //[otherheaderview addSubview:label_replys];
            otherheaderview.frame=CGRectMake(0, 0, DEVICE_WIDTH, haha+48+20);
            
            otherheaderview.backgroundColor=RGBCOLOR(255, 255, 255);
            
            
            UIImageView *imagexian=[[UIImageView alloc]initWithFrame:CGRectMake(0, haha+52, DEVICE_WIDTH, 4)];
            //          imagexian.image=[UIImage imageNamed:@"lineofnews@2x.png"];
            [otherheaderview addSubview:imagexian];
            
            UITapGestureRecognizer *_tapofsection=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openmysection:)];
            otherheaderview.userInteractionEnabled=YES;
            otherheaderview.tag=section-2+1000;
            [otherheaderview addGestureRecognizer:_tapofsection];
            
            if (section==whichsectionopend) {
                imagexian.image=[UIImage imageNamed:@"zipinglun_jiantou@2x.png"];
                tab_pinglunliebiao.backgroundColor=RGBCOLOR(247, 247, 247);
                
            }else{
                imagexian.image=[UIImage imageNamed:@"lineofnews@2x.png"];
                tab_pinglunliebiao.backgroundColor=RGBCOLOR(255, 255, 255);
                
            }
            
        }
        
        
        return otherheaderview;
        
        
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        
        CGSize constraintSize = CGSizeMake(300, MAXFLOAT);
        CGSize labelSize = [self.string_title sizeWithFont:[UIFont boldSystemFontOfSize:20.f] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByCharWrapping];
        
        return labelSize.height+20+12+5;
    }else if(section==1)
    {
        //self.string_commentnumber=[NSString stringWithFormat:@"%d",array_name.count];
        
        
        
        if ([self.string_commentnumber integerValue]==0) {
            return isiphone5?340+88:340;
        }else{
            return 60/2;
            
        }
        
    }
    else {
        NSArray *array=[array_content objectAtIndex:section-2];
        
        CGFloat haha=[self qugaodu:array];
        return haha+56;
    }
}
#pragma mark-打开我的section
-(void)openmysection:(UIGestureRecognizer *)sender{
    [self backkeyboard];
    long hahaha=sender.view.tag-1000;
    NSString *string_tid=[NSString stringWithFormat:@"%@",[array_tid objectAtIndex:hahaha]];
    
    NSString *str_number=[NSString stringWithFormat:@"%@",[array_reply objectAtIndex:hahaha]];
    if ([str_number isEqualToString:@"0"]) {
        NSLog(@"这个不需要打开");
    }else{
        NSLog(@"走你");
        //        UIImageView *img_v=(UIImageView *)[self.view viewWithTag:sender.view.tag+1000];
        //        img_v.image=[UIImage imageNamed:@"zipinglun_jiantou.png"];
        
        isopen=!isopen;
        if (sender.view.tag-1000+2!=whichsectionopend) {
            whichsectionopend=sender.view.tag-1000+2;
            NSLog(@"aha=%d",sender.view.tag);
            NSString *string105=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=subcommentlist&tid=%@&fbtype=json",string_tid];
            downloadtool *comentofcoment_tool=[[downloadtool alloc]init];
            [comentofcoment_tool setUrl_string:string105];
            comentofcoment_tool.delegate=self;
            arrayofcommentc=nil;
            if (!arrayofcommentc) {
                arrayofcommentc=[[NSArray alloc]init];
            }
            
        }else{
            if (isopen==NO) {
                NSLog(@"应该打开");
                NSLog(@"arraycomm=%@",arrayofcommentc);
                [tab_pinglunliebiao reloadData];
                
            }else{
                NSLog(@"这次是应该关闭");
                whichsectionopend=100000;
                [tab_pinglunliebiao reloadData];
            }
        }
    }
    
    
    NSLog(@"jajjajjhhaha%ld",hahaha);
    //    if (sender.view.tag-1000) {
    //        <#statements#>
    //    }
    
    
    
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    @try {
        NSDictionary *dicofcommentofcomment=[data objectFromJSONData];
        NSLog(@"dicofcommentofcomment==%@",dicofcommentofcomment);
        arrayofcommentc=[dicofcommentofcomment objectForKey:@"weiboinfo"];
        NSLog(@"arraycomcom=you%d个=%@",arrayofcommentc.count,arrayofcommentc);
        if (arrayofcommentc.count>0) {
            //        NSIndexSet * nd=[[NSIndexSet alloc]initWithIndex:whichsectionopend];//刷新第二个section
            //        [tab_pinglunliebiao reloadSections:nd withRowAnimation:UITableViewRowAnimationAutomatic];
            [tab_pinglunliebiao reloadData];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
    
}
-(void)downloadtoolError{
    NSLog(@"errroofcpmm");
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [text_write resignFirstResponder];
//    [self facescrowhiden];
//    if (isiphone5) {
//        aview.frame=CGRectMake(0, 0, 320, 568);
//
//    }else{
//        aview.frame=CGRectMake(0, 0, 320, 480);
//
//    }
//    if (!detai_comment) {
//        detai_comment=[[detailcommentViewController alloc]init];
//
//    }
//    detai_comment.string_ID=[array_tid objectAtIndex:indexPath.row];
//
//}
-(void)seccesDownLoad:(UIImage *)image{
    
}
#pragma mark-点击头像跳转的方法
-(void)turntopeople:(UITapGestureRecognizer *)sender{
    NSLog(@"=====ok,cufacufa");
    
    NSLog(@"=====ok,cufacufa");
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        
        UIView *imv__=sender.view;
        _people =[[NewMineViewController alloc]init];
        _people.uid=[NSString stringWithFormat:@"%@",[array_peopleid objectAtIndex:imv__.tag-100-2]];
        [self.navigationController pushViewController:_people animated:YES];
    }else{
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentViewController:login animated:YES completion:nil];
        
    }
    
}
#pragma mark-有关图文混排的，返回view和高度

-(UIView *)assembleMessageAtIndex:(NSArray *)arr
{
#define KFacialSizeWidth 17
#define KFacialSizeHeight 17
    UIView *returnView = [[UIView alloc] init];
    
    NSArray *data = [[NSArray alloc]initWithArray:arr];
    UIFont *fon= [UIFont systemFontOfSize:13];
	CGFloat upX=0;
    CGFloat upY=0;
    
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                if (upX > 240)
                {
                    upY = upY + KFacialSizeHeight+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[personal imgreplace:yaoxi];
                
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, 13, 14);
                [returnView addSubview:img];
				upX=KFacialSizeWidth+upX+5;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 240)
                    {
                        upY = upY + KFacialSizeHeight+3;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(240, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.backgroundColor=[UIColor clearColor];
                    la.font = fon;
                    la.text = temp;
                    la.textColor=RGBCOLOR(49, 49, 49);
                    [returnView addSubview:la];
                    upX=upX+size.width;
                }
			}
        }
	}
    return returnView;
}
-(CGFloat)qugaodu:(NSArray*)arr{
    
    UIView *returnView = [[UIView alloc] init];
    
    NSArray *data = [[NSArray alloc]initWithArray:arr];
    
    UIFont *fon=   [UIFont fontWithName:@"Helvetica" size:13];
    
	CGFloat upX=0;
    CGFloat upY=0;
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                if (upX > 240)
                {
                    upY = upY + KFacialSizeHeight+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[personal imgreplace:yaoxi];
                
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, 19, 20);
                [returnView addSubview:img];
				upX=KFacialSizeWidth+upX+3;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 240)
                    {
                        upY = upY + KFacialSizeHeight+3;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(240, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    upX=upX+size.width;
                }
			}
        }
	}
    
    return upY+10;
}

#pragma mark 回到上一个页面
-(void)backto{
    [text_write resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//#pragma mark-回复评论的评论
//-(void)huifupinglun:(UIButton*)sender{
//    [text_write becomeFirstResponder];
//
//    text_write.text=[NSString stringWithFormat:@"回复@%@ ：",[array_name objectAtIndex:dijige]] ;
//    iszipinglun=YES;
//    dijige=sender.tag-100;
//    NSLog(@"sender.tag==%d",sender.tag);
//    NSLog(@"array_tid==%@",array_tid);
//
//}
#pragma mark 输入评论内容的代理
- (void) keyboardWillShow:(NSNotification *)notification {
    
    NSLog(@"key===%@",[personal getMyAuthkey ]);
    
    
    
    if ([[personal getMyAuthkey ] isEqualToString:@"(null)"]||[personal getMyAuthkey ].length==0) {
        
        
        LogInViewController *loginV=[LogInViewController sharedManager];
        
        
        [self presentViewController:loginV animated:YES completion:^{
            
            [inputV hiddeninputViewTap];
            
            
            
        }];
        
        
    }
    
    
    
    
}
- (void)keyboardWillHide:(NSNotification *)note
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [text_write resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self facescrowhiden];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_CHECKUSER])
        {
            NSLog(@"已经激活／。。。");
            //已经激活过FB 加载个人信息
            text_write.returnKeyType=UIReturnKeyDone;
            text_write.keyboardType=UIKeyboardTypeDefault;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            
           // aview.frame=CGRectMake(0,-249+31, DEVICE_WIDTH,DEVICE_HEIGHT);
            [UIView commitAnimations];
            
            
        }
    }
    else{
        //没有激活fb，弹出激活提示
        [text_write resignFirstResponder];
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentModalViewController:login animated:YES];
    }
}
#pragma mark-激活fb
-(void)jihuoFb{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"激活" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    
}
#pragma mark-uiactionsheetdelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"激活");
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentModalViewController:login animated:YES];
    }else{
        NSLog(@"取消");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self fabiao];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
   // aview.frame=CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    
    [UIView commitAnimations];
}
#pragma mark-发表状态的方法
-(void)fabiao{
    [self facescrowhiden];
    faceScrollView.frame =CGRectMake(0, 1000, self.view.frame.size.width, 215);
    
    //aview.frame=CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    
    if (text_write.text.length==0) {
        UIAlertView *viewalert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"评论内容不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [viewalert show];
        return;
    }
    [text_write resignFirstResponder];
    if (iszipinglun==NO) {
        NSString *string_102=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentadd&sort=%@&sortid=%d&content=%@&title=%@&fromtype=b5eeec0b&authkey=%@",self.sortString,[self.string_ID integerValue],[text_write.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.string_title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
        
        NSLog(@"评论请求的接口。。。。。。。。。。=%@",string_102);
        NSURL *url102 = [NSURL URLWithString:string_102];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url102];
        request.tag=102;
        [request setDelegate:self];
        [request startAsynchronous];
        activity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145,165, 30, 30)];
        [aview addSubview:activity];
        [activity startAnimating];
    }
    else{
        iszipinglun=NO;
        string_106=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=subcommentadd&tid=%d&content=%@&topictype=reply&fromtype=b5eeec0b&authkey=%@",[[array_tid objectAtIndex:dijige]integerValue],[text_write.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
        
        NSURL *url106 = [NSURL URLWithString:string_106];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url106];
        request.tag=106;
        [request setDelegate:self];
        [request startAsynchronous];
        
    }
    
    text_write.text=@"";
}
-(void)faceview{
    isjianpan=!isjianpan;
    button_face.backgroundColor=[UIColor clearColor];
    
    if (isjianpan) {
        
        button_face.frame=CGRectMake(10, (40-35/2)/2, 48/2, 35/2);
        [button_face setBackgroundImage:[UIImage imageNamed:@"ios7_keyboard_48_35.png"] forState:UIControlStateNormal];
        
        
        
        
        [text_write resignFirstResponder];
        //aview.frame=CGRectMake(0, 0,DEVICE_WIDTH,DEVICE_HEIGHT);
        [self facescrowviewshow];
        
    }else{
        button_face.frame=CGRectMake(10, (40-43/2)/2, 43/2, 43/2);
        
        [button_face setBackgroundImage:[UIImage imageNamed:@"ios7_face43_43.png"] forState:UIControlStateNormal];
        
        [text_write becomeFirstResponder];
        //aview.frame=CGRectMake(0,-249+31, DEVICE_WIDTH,DEVICE_HEIGHT);
        [self facescrowhiden];
    }
    
}
#pragma mark-让facesvrowview弹出或者隐藏的方法
-(void)facescrowviewshow{
    [text_write resignFirstResponder];
    if (isiphone5) {
        faceScrollView.frame = CGRectMake(0, 568-180-44-55, self.view.frame.size.width, 221);
        pageControl.frame=CGRectMake(0, 568-90, self.view.frame.size.width, 25);
        
        
    }else{
        faceScrollView.frame = CGRectMake(0, 480-180-44-55, self.view.frame.size.width, 221);
        pageControl.frame=CGRectMake(0, 480-90, self.view.frame.size.width, 25);
    }
    
    
}
-(void)facescrowhiden{
    
    faceScrollView.frame = CGRectMake(0, 900, self.view.frame.size.width, 221);
    pageControl.frame=CGRectMake(0, 900, self.view.frame.size.width, 25);
}
-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        text_write.text=[NSString stringWithFormat:@"%@%@",text_write.text,name];
    }
    else
    {
        [self facescrowhiden];
        //没有激活fb，弹出激活提示
        [text_write resignFirstResponder];
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentViewController:login animated:YES completion:nil];
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tab_pinglunliebiao];
    
}
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+40)) {
        NSUserDefaults *user_=[NSUserDefaults standardUserDefaults];
        NSString *string_=[user_ objectForKey:@"last"];
        if ([string_ isEqualToString:@"lastpage"]) {
            return;
        }else{
            
            
            
            
            
            [loadview startLoading];
            [self jiazaimore];
            NSLog(@"上提刷新");
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self fasongpinglunqingqiu];
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
//对应ios6下的横竖屏问题
- (BOOL)shouldAutorotate{
    return  NO;
}
@end


