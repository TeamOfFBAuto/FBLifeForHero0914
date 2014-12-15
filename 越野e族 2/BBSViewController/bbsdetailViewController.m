//
//  bbsdetailViewController.m
//  FbLife
//  Created by 史忠坤 on 13-3-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//
//skllk;k;l/

///




#import "PraiseAndCollectedModel.h"



#import "bbsdetailViewController.h"
#import "personal.h"
#import "loadingview.h"
#import "commrntbbdViewController.h"
#import "LogInViewController.h"
#import "NewMineViewController.h"
#import "WriteBlogViewController.h"
#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"
#import "SSWBViewController.h"


#define PRAISE_IMAGE @"atlas_zan-2"
#define UN_PRAISE_IMAGE @"love_unselected_image"

#define COLLECTED_IMAGE @"atlas_collect-1"
#define UN_COLLECTED_IMAGE @"star_unselected_image-1"




#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
@interface bbsdetailViewController (){
    NSDictionary *dic;
    UIView *aview;
    UIImageView * xialaView_bbs;
    AlertRePlaceView *_replaceAlertView;
    UIButton *  button_share;
    
    PraiseAndCollectedModel * praise_model;

}

@end
///
@implementation bbsdetailViewController
@synthesize bbsdetail_tid,imgforshare;
@synthesize collection_array = _collection_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [MobClick beginEvent:@"bbsdetailViewController"];
    for (id aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([aviewp isEqual:[AlertRePlaceView class]])
        {
            [aviewp removeFromSuperview];
        }
    }
    

    [super viewWillDisappear:NO];
    self.navigationController.navigationBarHidden=NO;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
    [MobClick endEvent:@"bbsdetailViewController"];
    
    if (!isHidden)
    {
        [self showPopoverView:nil];
    }
    _isloadingIv.hidden=YES;
    
    //如果接收到通知，就刷新数据
    
}

- (void)viewDidLoad
{    isauthor=NO;//默认是全部
    
    zanNumber=0;

    
    self.thezkingAlertV=[[ZkingAlert alloc]initWithFrame:CGRectMake(0, 0, 320, 480) labelString:@""];
    _thezkingAlertV.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_thezkingAlertV];

    jiushizhegele=1;
    [super viewDidLoad];
    isloading=YES;
    currentpage=1;
    selecttionofxialaview=1;
    issuccessload=YES;
    if (!isHaveNetWork) {
        [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(sendallmore) name:@"refreshmydata" object:nil];
        [self sendallmore];
        [_replaceAlertView removeFromSuperview];
        _replaceAlertView=nil;
        _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
        _replaceAlertView.delegate=self;
        _replaceAlertView.hidden=YES;
        [[UIApplication sharedApplication].keyWindow
         addSubview:_replaceAlertView];

        

    }else{
        [_replaceAlertView removeFromSuperview];
        _replaceAlertView=nil;
        _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"当前没有连接到网络，请检测wifi或蜂窝数据是否开启"];
        _replaceAlertView.delegate=self;
        _replaceAlertView.hidden=NO;
        [[UIApplication sharedApplication].keyWindow
         addSubview:_replaceAlertView];
    }
    
    
    self.navigationController.navigationBarHidden=NO;
    //关于两个uiwebview切换的
    
    dangqianwebview=1;
    string_upordown=[NSString stringWithFormat:@""];
    
    
    
    
//    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, (44-43/2)/2, 12, 43/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back.png"] forState:UIControlStateNormal];
//    
//    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
//    [back_view addSubview:button_back];
//    back_view.backgroundColor=[UIColor clearColor];
//    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
//    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?30: 23, (44-37/2)/2, 43/2, 37/2)];
//    
//    
//    button_comment.tag=26;
//    
//    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
//    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
//    [button_comment addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
//    [button_comment setBackgroundImage:[UIImage imageNamed:@"ios_zhuanfa44_37.png"] forState:UIControlStateNormal];
//    button_comment.userInteractionEnabled=NO;
//    
//    UIButton *   rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
//    [rightView addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
//    [rightView addSubview:button_comment];
//    rightView.backgroundColor=[UIColor clearColor];
//    
//    
//    
//    
//    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
//    
//    
//    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,160,44)];
//    topView.backgroundColor = [UIColor clearColor];
//    //导航栏上的label
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_MACRO_NAME? 40:40, 0, 80, 44)];
//    titleLabel.text = @"主题帖";
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font= [UIFont systemFontOfSize:20];
//    titleLabel.textColor = [UIColor blackColor];
//    [topView addSubview:titleLabel];
//    
//
//
//    UIButton *button_author=[[UIButton alloc]initWithFrame:CGRectMake(120, (44-35/2)/2, 70/2, 35/2)];
//    button_author.tag=1314;
//    [button_author setBackgroundImage:[UIImage imageNamed:@"ios7_authorunselect70_37.png"] forState:UIControlStateNormal];
//    [button_author setTitle:@"楼主" forState:UIControlStateNormal];
//    button_author.titleLabel.font=[UIFont systemFontOfSize:12];
//    [button_author setTitleColor:RGBCOLOR(108, 108, 108) forState:UIControlStateNormal];
//    [button_author setTitleColor:RGBCOLOR(108, 108, 108) forState:UIControlStateSelected];
//    [button_author setTitleColor:RGBCOLOR(108, 108, 108) forState:UIControlStateHighlighted];
//
//    [topView addSubview:button_author];
//    [button_author addTarget:self action:@selector(Doauthor:) forControlEvents:UIControlEventTouchUpInside];
//    
//
//
//    self.navigationItem.titleView = topView;
//
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
//        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
//        
//    }
//    self.navigationItem.rightBarButtonItem=comment_item;
//
//    self.navigationItem.leftBarButtonItem=back_item;

    [self prepairNavigationbar];

    
    array_chose=[NSArray arrayWithObjects:@"查看全部",@"只看楼主", nil];
    isHidden=YES;
    allpages=1;
    
    
    UIImage * image =[UIImage imageNamed:@"xiala_new_detail.png"] ;
    xialaView_bbs = [[UIImageView alloc] initWithImage:image];
    xialaView_bbs.userInteractionEnabled = YES;
    xialaView_bbs.center = CGPointMake(160,MY_MACRO_NAME? image.size.height/2+54: image.size.height/2+54+20);
    xialaView_bbs.tag = 112;
    xialaView_bbs.alpha = 0;
    
    for (int i = 0;i < array_chose.count;i++)
    {
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,10+(260/6)*i,195,260/6)];
        imageView1.userInteractionEnabled = YES;
        imageView1.tag = 1+i;
        imageView1.backgroundColor = [UIColor clearColor];
        if (i==0) {
            imageView1.image = [personal getImageWithName:@"bg_sel"];
        }
        [xialaView_bbs addSubview:imageView1];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [imageView1 addGestureRecognizer:tap];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,195,260/6)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [array_chose objectAtIndex:i];
        label.font=[UIFont systemFontOfSize:20];
        [imageView1 addSubview:label];
    }
    
    UIButton *button_send=[[UIButton alloc]initWithFrame:CGRectMake(40, 8, 32, 27.5)];
    [button_send addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    [button_send setBackgroundImage:[UIImage imageNamed:WRITE_DEFAULT_IMAGE] forState:UIControlStateNormal];
    // UIBarButtonItem *buttonitem_send=[[UIBarButtonItem alloc]initWithCustomView:button_send];
    
    
    
    aview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568:480)];
    [self.view addSubview:aview];
    
    aview.backgroundColor=[UIColor clearColor];
    _webView=[[UIWebView alloc] init];
    _webView.backgroundColor=[UIColor whiteColor];
    _webView.delegate=self;
    if (IOS_VERSION >= 5.0)
    {
        _webView.scrollView.delegate=self;
    }else
    {
        UIScrollView * scrollView = (UIScrollView *)[_webView.subviews objectAtIndex:0];
        scrollView.delegate = self;
    }
    // _webView.scalesPageToFit=YES;
    _webView.opaque=NO;
    
    _webView.frame=CGRectMake(0, 0, 320 ,iPhone5? 314+88+105-41:314+105-41);
    //给webview加手势
    _webView.userInteractionEnabled=YES;
    
    //底部配置
    secondWebView=[[UIWebView alloc]init];
    secondWebView.backgroundColor=[UIColor whiteColor];
    secondWebView.opaque=NO;
    secondWebView.userInteractionEnabled=YES;
    secondWebView.delegate=self;
    [aview addSubview:_webView];

    [aview addSubview:secondWebView];
    
    
    
    
    UISwipeGestureRecognizer* recognizer1;
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom)];
    
    recognizer1.direction = UISwipeGestureRecognizerDirectionRight;
    [_webView addGestureRecognizer:recognizer1];
    
    
    UISwipeGestureRecognizer* recognizer2;
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom)];
    
    recognizer2.direction = UISwipeGestureRecognizerDirectionRight;
    
    [secondWebView addGestureRecognizer:recognizer2];
    
    

    if (IOS_VERSION >= 5.0)
    {
        secondWebView.scrollView.delegate=self;
    }else
    {
        UIScrollView * scrollView = (UIScrollView *)[secondWebView.subviews objectAtIndex:0];
        scrollView.delegate = self;
    }
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:xialaView_bbs];
    
    
    barview=[[bottombarview alloc]initWithFrame:CGRectMake(0,iPhone5?419+88-42:378, 320, 40)];
    [barview setcommentimage2];
    barview.delegate=self;
    [aview addSubview:barview];
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
 
}

-(void)handleSwipeFrom{

    [self backto];

}

#pragma mark--准备导航栏
-(void)prepairNavigationbar{
    
    
    
    
    
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
        
    }
    
    UIBarButtonItem * spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton.width = MY_MACRO_NAME?-13:5;
    
    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, 3,40,44)];
    
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    [button_back setImage:[UIImage imageNamed:@"fanhui_image"] forState:UIControlStateNormal];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(-20, 0, 50, 44)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    self.navigationItem.leftBarButtonItems=@[spaceButton,back_item];
    
    
    //点赞的
    
    
//    praise_model = [[PraiseAndCollectedModel alloc] init];
    
    isPraise = [[[PraiseAndCollectedModel getTeamInfoById:self.bbsdetail_tid] praise] intValue];

    UIButton *heartButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [heartButton addTarget:self action:@selector(dianzan:) forControlEvents:UIControlEventTouchUpInside];
    
    [heartButton setImage:[UIImage imageNamed:UN_PRAISE_IMAGE] forState:UIControlStateNormal];
    
    [heartButton setImage:[UIImage imageNamed:PRAISE_IMAGE] forState:UIControlStateSelected];
    
    if  (isPraise)
    {
        
        
        
        
        heartButton.selected = YES;
    }
    
    
    
    //收藏的
    
    UIButton *collectButton=[[UIButton alloc]initWithFrame:CGRectMake(74,0, 44/2,42.5)];
    [collectButton addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    [collectButton setImage:[UIImage imageNamed:UN_COLLECTED_IMAGE] forState:UIControlStateNormal];
    
    
    
    
    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?140: 25-3,0, 43/2,44)];
    
    
    button_comment.tag=26;
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
    [button_comment setImage:[UIImage imageNamed:@"zhuanfa_image.png"] forState:UIControlStateNormal];
   // button_comment.userInteractionEnabled=NO;
    
    UIButton *    rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    // [rightView addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button_comment];
    
    rightView.backgroundColor=[UIColor clearColor];
    
    
    [rightView addSubview:heartButton];
    [rightView addSubview:collectButton];
    
    
    
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    self.navigationItem.rightBarButtonItem=comment_item;
    
    if ([personal getMyAuthkey].length==0||[[personal getMyAuthkey] isEqualToString:@"(null)"]) {
        
    }else{
        
        [self panduanIsshoucang:collectButton];
        
    }
    
    
    
}

#pragma mark--点赞的

-(void)dianzan:(UIButton *)sender{
    
    
  
    if (isPraise)
    {
        
        sender.selected = NO;
        
        isPraise = NO;
        
        [PraiseAndCollectedModel deleteWithId:self.bbsdetail_tid];
        
        return;
    }
    
    
    
    [self changeMySizeAnimationWithView:sender];
    
    
    [self.thezkingAlertV zkingalertShowWithString:[NSString stringWithFormat:@"感兴趣" ]];
    
    sender.selected=YES;
    
    isPraise=YES;
    
    [PraiseAndCollectedModel addIntoDataSourceWithId:self.bbsdetail_tid WithPraise:[NSNumber numberWithBool:YES]];
    
    
    NSLog(@"ID===%@",self.bbsdetail_tid);
    
    //    isPraise = [[[PraiseAndCollectedModel getTeamInfoById:self.string_Id] praise] intValue];
    
    
    NSLog(@"isPraise==%d",isPraise);
    

    
    
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    
    
    [loaddata SeturlStr:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/cmsthreadlikes.php?tid=%@",self.bbsdetail_tid] mytest:^(NSDictionary *dicinfo, int errcode) {
        
        
        
        NSLog(@"点赞返回的数据===%@",dicinfo);
        
        
        
        
        
    }];    // sender.userInteractionEnabled=NO;
    
    
    
    
}


#pragma mark - 放到再缩小动画


-(void)changeMySizeAnimationWithView:(UIView *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        
        sender.transform = CGAffineTransformMakeScale(1.5,1.5);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            sender.transform = CGAffineTransformMakeScale(1,1);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];
}



/**
 12. 收藏帖子的接口
 
 测试环境：http://demo03.fblife.com/bbsapinew/addfavoritesthread.php?authcode=U2VRMgdnVzVQZlc8AnkKelo7A25fd1JhCWEANw&tid=56&formattype=json
 线上环境：http://bbs.fblife.com/bbsapinew/addfavoritesthread.php?authcode=U2VRMgdnVzVQZlc8AnkKelo7A25fd1JhCWEANw&tid=56&formattype=json
 
 接口参数：
 action ； add
 tid : 帖子id
 authcode ：用户登录took
 formattype : 返回数据类型（xml，json）
 
 返回值：
 errcode : > 0 时即为有错误
 errinfo : 错误描述
 
 
 11. 删除帖子收藏的接口
 
 测试环境：http://demo03.fblife.com/bbsapinew/delfavoritesthread.php?delid=1573498&formattype=json&authcode=U2VRMgdnVzVQZlc8AnkKelo7A25fd1JhCWEANw
 线上环境：http://bbs.fblife.com/bbsapinew/delfavoritesthread.php?delid=1573498&formattype=json&authcode=U2VRMgdnVzVQZlc8AnkKelo7A25fd1JhCWEANw

 15. “赞”帖子的接口
 
 测试环境：http://demo03.fblife.com/bbsapinew/cmsthreadlikes.php?tid=1574017
 线上环境：http://bbs.fblife.com/bbsapinew/cmsthreadlikes.php?tid=1574017
 

 
 */

#pragma mark-判断是否收藏


-(void)panduanIsLogin{
    
    if ([personal getMyAuthkey].length==0||[[personal getMyAuthkey] isEqualToString:@"(null)"]) {
        
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentViewController:login animated:YES completion:^{
            
        }];
        return;
        
        
    }else{
        
        
    }
    
    
}



-(void)panduanIsshoucang:(UIButton *)sender{
    
    sender.userInteractionEnabled=NO;
    
    
    
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    __weak typeof(self) weself=self;
    
    __weak typeof(sender) wsender=sender;
    
    [loaddata SeturlStr:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/addfavoritesthread.php?authcode=%@&tid=%@&formattype=json",[personal getMyAuthkey],self.bbsdetail_tid] mytest:^(NSDictionary *dicinfo, int errcode) {
        
        
        NSLog(@"收藏返回的数据===%@",dicinfo);
        
        if ([[dicinfo objectForKey:@"errcode"] intValue]==0) {
            
            sender.userInteractionEnabled=YES;
            
            
            
            
            [weself tempQuxiaoshoucang:wsender];
            
            
        }else{
            
            sender.userInteractionEnabled=YES;
            
            [sender setImage:[UIImage imageNamed:COLLECTED_IMAGE] forState:UIControlStateNormal];
            
            
            
            
        }
        
        
    }];
    
    
    
}

-(void)tempQuxiaoshoucang:(UIButton *)sender{

    sender.userInteractionEnabled=YES;
    
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    // __weak typeof(self) weself=self;
    
    [loaddata SeturlStr:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/delfavoritesthread.php?delid=%@&formattype=json&authcode=%@",self.bbsdetail_tid,[personal getMyAuthkey]] mytest:^(NSDictionary *dicinfo, int errcode) {
        
        NSLog(@"取消该收藏的dic==%@",dicinfo);
        
        
        if ([[dicinfo objectForKey:@"errcode"] intValue]==0) {
            
            [sender setImage:[UIImage imageNamed:UN_COLLECTED_IMAGE] forState:UIControlStateNormal];
            
            
        }
        
        
    }];


}

#pragma mark-收藏

-(void)shoucang:(UIButton *)sender{
    
    
    [self panduanIsLogin];
    
    
    sender.userInteractionEnabled=NO;
    
    
    
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    __weak typeof(self) weself=self;
    
    __weak typeof(sender) wsender=sender;
    
    [loaddata SeturlStr:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/addfavoritesthread.php?authcode=%@&tid=%@&formattype=json",[personal getMyAuthkey],self.bbsdetail_tid] mytest:^(NSDictionary *dicinfo, int errcode) {
        
        
        NSLog(@"收藏返回的数据===%@",dicinfo);
        
        if ([[dicinfo objectForKey:@"errcode"] intValue]==0) {
            
            [self.collection_array addObject:self.bbsdetail_tid];
            
            sender.userInteractionEnabled=YES;
            [self.thezkingAlertV zkingalertShowWithString:@"收藏成功"];
            
            [sender setImage:[UIImage imageNamed:COLLECTED_IMAGE] forState:UIControlStateNormal];
            
            //zsn
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                sender.transform = CGAffineTransformMakeScale(1.5,1.5);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    sender.transform = CGAffineTransformMakeScale(1.0,1.0);
                    
                } completion:^(BOOL finished) {
                    
                }];
                
            }];
            
            
            
 //szk
//            [UIView animateWithDuration:0.6 animations:^{
//                
//                sender.frame=CGRectMake(sender.frame.origin.x-5, sender.frame.origin.y-5, 1.4*sender.frame.size.width,  1.4*sender.frame.size.height);
//                
//                
//                
//                
//            } completion:^(BOOL finished) {}];
//            
//            [UIView animateWithDuration:0.6 animations:^{
//                
//                sender.frame=CGRectMake(sender.frame.origin.x+5, sender.frame.origin.y+5, 0.71428571*sender.frame.size.width,  0.71428571*sender.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {}];
            
            
            
        }else{
            
            
            [weself quxiaoShoucang:wsender];
            
            
            
        }
        
        
    }];
    
    
    
}

//取消收藏





-(void)quxiaoShoucang:(UIButton *)sender{
    
    sender.userInteractionEnabled=YES;
    
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    // __weak typeof(self) weself=self;
    
    [loaddata SeturlStr:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/delfavoritesthread.php?delid=%@&formattype=json&authcode=%@",self.bbsdetail_tid,[personal getMyAuthkey]] mytest:^(NSDictionary *dicinfo, int errcode) {
        
        NSLog(@"取消该收藏的dic==%@",dicinfo);
        
        
        if ([[dicinfo objectForKey:@"errcode"] intValue]==0) {
            
            
            if ([self.collection_array containsObject:self.bbsdetail_tid])
            {
                [self.collection_array removeObject:self.bbsdetail_tid];
            }
            
            [self.thezkingAlertV zkingalertShowWithString:@"已取消收藏"];

            [sender setImage:[UIImage imageNamed:UN_COLLECTED_IMAGE] forState:UIControlStateNormal];
            
        }
        
        
    }];
    
    
    
    
}









#pragma mark-新版本加authorbutton
-(void)Doauthor:(UIButton *)sender{
    isauthor=!isauthor;
    currentpage=1;
    [barview.button_refresh setBackgroundImage:isauthor?[UIImage imageNamed:@"louzhured38_52.png"]:[UIImage imageNamed:@"louzhu38_52.png"] forState:UIControlStateNormal];
   
    [self sendallmore];
    
}
#pragma mark-进入分享



-(void)ShareMore{
    
    __weak typeof(_shareView)w_shareView=_shareView;
    
    
    __weak typeof(self)wself=self;
    if (!_shareView) {
        _shareView =[[ShareView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) thebloc:^(NSInteger indexPath) {
            
            NSLog(@"xxx==%d",indexPath);
            
            
            [wself clickedButtonAtIndex:indexPath];
            
            
        }];
        
        [_shareView ShareViewShow];
        
    }else{
        [_shareView ShareViewShow];
        
    }
    
    
    
}

-(void)clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
        {
            WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
            
            writeBlogView.theText = [NSString stringWithFormat:@"分享论坛:“%@”,链接:%@",string_title,string_url] ;
            
            [self presentModalViewController:writeBlogView animated:YES];
            
            
        }
        else{
            //没有激活fb，弹出激活提示
            LogInViewController *login=[LogInViewController sharedManager];
            [self presentViewController:login animated:YES completion:nil];
        }
        
        
    }else if(buttonIndex==2){
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            NSLog(@"????share==%@",self.imgforshare);
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneTimeline;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alView show];
            
        }
        
        
        NSLog(@"分享到微信朋友圈");
        
        
        
    }
    
    else if(buttonIndex==4){
        
        NSLog(@"分享到邮箱");
        
        //        [UMSocialData defaultData].shareText =[NSString stringWithFormat:@"%@（分享自越野e族）  %@<html><a href=http://mobile.fblife.com/>\n点击下载越野e族客户端</a></html>",string_title,string_url] ;
        //
        //        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"email"];
        //
        //        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
        NSString *string_bodyofemail=[NSString stringWithFormat:@"%@ \n %@ \n\n 下载越野e族客户端 http://mobile.fblife.com/download.php",string_title,string_url] ;
        [self okokokokokokowithstring:string_bodyofemail];
        
        
    }else if(buttonIndex==1){
        NSLog(@"分享给微信好友");
        
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            NSLog(@"????share==%@",self.imgforshare);
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneSession;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alView show];        }
        
    }
    else if(buttonIndex==3){
        if ([WeiboSDK isWeiboAppInstalled]) {

        NSLog(@"到新浪微博界面的");
        WBWebpageObject *pageObject = [ WBWebpageObject object ];
        pageObject.objectID =@"nimeideid";
        pageObject.thumbnailData =UIImageJPEGRepresentation([UIImage imageNamed:@"Icon@2x.png"], 1);
        pageObject.title = @"分享自越野e族客户端";
        pageObject.description = string_title;
        pageObject.webpageUrl = string_url;
        WBMessageObject *message = [ [ WBMessageObject alloc ] init ];
        message.text =[NSString stringWithFormat:@"%@（分享自@越野e族）",string_title] ;
        
        message.mediaObject = pageObject;
        WBSendMessageToWeiboRequest *req = [ [  WBSendMessageToWeiboRequest alloc ] init  ];
        req.message = message;
            [ WeiboSDK sendRequest:req ];
        }else{
            
            
            UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的手机未安装微博客户端" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            
            [myAlert show];
            }
        
        
    }
    //分享编辑页面的接口
    //



}

//-(void)ShareMore{
//    
//    my_array =[[NSMutableArray alloc]init];
//    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"  " delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    
//      editActionSheet.actionSheetStyle = UIActivityIndicatorViewStyleGray;
//    
//    [editActionSheet addButtonWithTitle:@"分享到FB自留地"];
//    
//    [editActionSheet addButtonWithTitle:@"分享到微信朋友圈"];
//    
//    [editActionSheet addButtonWithTitle:@"分享给微信好友"];
//    
//    for (NSString *snsName in [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
//        /*2013-07-22 17:09:59.546 UMSocial[4631:907] name==qzone
//         2013-07-22 17:09:59.55x3 UMSocial[4631:907] name==sina
//         2013-07-22 17:09:59.559 UMSocial[4631:907] name==tencent
//         2013-07-22 17:09:59.564 UMSocial[4631:907] name==renren
//         2013-07-22 17:09:59.575 UMSocial[4631:907] name==douban
//         2013-07-22 17:09:59.578 UMSocial[4631:907] name==wechat
//         2013-07-22 17:09:59.583 UMSocial[4631:907] name==wxtimeline
//         2013-07-22 17:09:59.587 UMSocial[4631:907] name==email
//         2013-07-22 17:09:59.592 UMSocial[4631:907] name==sms
//         2013-07-22 17:09:59.595 UMSocial[4631:907] name==facebook
//         2013-07-22 17:09:59.598 UMSocial[4631:907] name==twitter*/
//        
//        if ([snsName isEqualToString:@"facebook"]||[snsName isEqualToString:@"twitter"]||[snsName isEqualToString:@"renren"]||[snsName isEqualToString:@"qzone"]||[snsName isEqualToString:@"douban"]||[snsName isEqualToString:@"tencent"]||[snsName isEqualToString:@"sms"]||[snsName isEqualToString:@"wxtimeline"]) {
//        }else{
//            NSLog(@"weishenmehaiyu===%@",my_array);
//            [my_array addObject:snsName];
//            if ([snsName isEqualToString:@"sina"]) {
//                [editActionSheet addButtonWithTitle:@"分享到新浪微博"];
//                
//            }
//            if ([snsName isEqualToString:@"email"]) {
//                
//            }
//            
//            //            else if([snsName isEqualToString:@"wechat"])
//            //            {
//            //                [editActionSheet addButtonWithTitle:@"分享给微信好友"];
//            //
//            //
//            //            }
//            //            else if([snsName isEqualToString:@"wxtimeline"])
//            //            {
//            //                [editActionSheet addButtonWithTitle:@"分享到微信朋友圈"];
//            //
//            //            }
//            //            else{
//            //                [editActionSheet addButtonWithTitle:@"短信分享"];
//            //
//            //            }
//            //
//            
//        }
//        
//        
//    }
//
//    [editActionSheet addButtonWithTitle:@"分享到朋友邮箱"];
//
//    [editActionSheet addButtonWithTitle:@"取消"];
//    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
//    // [editActionSheet showFromTabBar:self.tabBarController.tabBar];
//    [editActionSheet showFromRect:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) inView:self.view animated:YES];
//    editActionSheet.delegate = self;
//    
//    
//    CGRect oldFrame;
//    
//    for (id label in editActionSheet.subviews)
//    {
//        if ([label isKindOfClass:[UILabel class]])
//        {
//            [[(UILabel *)label text] isEqualToString:@"  "];
//            
//            oldFrame = [(UILabel *)label frame];
//        }
//    }
//    
//    
//    UILabel *newTitle = [[UILabel alloc] initWithFrame:oldFrame];
//    newTitle.font = [UIFont systemFontOfSize:18];
//    newTitle.textAlignment = NSTextAlignmentCenter;
//    newTitle.backgroundColor = [UIColor clearColor];
//    newTitle.textColor = RGBCOLOR(160,160,160);
//    newTitle.text = @"分享";
//    [editActionSheet addSubview:newTitle];
//    
//
//}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
        {
            WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
            
            writeBlogView.theText = [NSString stringWithFormat:@"分享论坛:“%@”,链接:%@",string_title,string_url] ;
            
            [self presentModalViewController:writeBlogView animated:YES];
            
            
        }
        else{
            //没有激活fb，弹出激活提示
            LogInViewController *login=[LogInViewController sharedManager];
            [self presentViewController:login animated:YES completion:nil];
        }
        
        
    }else if(buttonIndex==1){
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            NSLog(@"????share==%@",self.imgforshare);
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneTimeline;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:@"免费下载微信", nil];
            [alView show];
            
        }
        
        
        NSLog(@"分享到微信朋友圈");
        
        
        
    }
    
    else if(buttonIndex==4){
        
        NSLog(@"分享到邮箱");
        
        //        [UMSocialData defaultData].shareText =[NSString stringWithFormat:@"%@（分享自越野e族）  %@<html><a href=http://mobile.fblife.com/>\n点击下载越野e族客户端</a></html>",string_title,string_url] ;
        //
        //        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"email"];
        //
        //        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
        NSString *string_bodyofemail=[NSString stringWithFormat:@"%@ \n %@ \n\n 下载越野e族客户端 http://mobile.fblife.com/download.php",string_title,string_url] ;
        [self okokokokokokowithstring:string_bodyofemail];
        
        
    }else if(buttonIndex==2){
        NSLog(@"分享给微信好友");
        
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            NSLog(@"????share==%@",self.imgforshare);
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneSession;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:@"免费下载微信", nil];
            [alView show];
        }
        
    }
    else if(buttonIndex==3){
        
        NSLog(@"到新浪微博界面的");
        WBWebpageObject *pageObject = [ WBWebpageObject object ];
        pageObject.objectID =@"nimeideid";
        pageObject.thumbnailData =UIImageJPEGRepresentation([UIImage imageNamed:@"Icon@2x.png"], 1);
        pageObject.title = @"分享自越野e族客户端";
        pageObject.description = string_title;
        pageObject.webpageUrl = string_url;
        WBMessageObject *message = [ [ WBMessageObject alloc ] init ];
        message.text =[NSString stringWithFormat:@"%@（分享自@越野e族）",string_title] ;
        
        message.mediaObject = pageObject;
        WBSendMessageToWeiboRequest *req = [ [  WBSendMessageToWeiboRequest alloc ] init  ];
        req.message = message;
        [ WeiboSDK sendRequest:req ];
        
        
    }
    //分享编辑页面的接口
    //

    
}


-(void)okokokokokokowithstring:(NSString *)___str{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"分享自越野e族"];
    
    
    
    
    // Fill out the email body text
    NSString *emailBody =___str;
    [picker setMessageBody:emailBody isHTML:NO];
    
    @try {
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
}




- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    NSString *title = @"Mail";
    
    NSString *msg;
    
    switch (result)
    
    {
            
        case MFMailComposeResultCancelled:
            
            msg = @"Mail canceled";//@"邮件发送取消";
            
            break;
            
        case MFMailComposeResultSaved:
            
            msg = @"Mail saved";//@"邮件保存成功";
            
            // [self alertWithTitle:title msg:msg];
            
            break;
            
        case MFMailComposeResultSent:
            
            msg = @"邮件发送成功";//@"邮件发送成功";
            
            [self alertWithTitle:title msg:msg];
            
            break;
            
        case MFMailComposeResultFailed:
            
            msg = @"邮件发送失败";//@"邮件发送失败";
            
            [self alertWithTitle:title msg:msg];
            
            break;
            
        default:
            
            msg = @"Mail not sent";
            
            // [self alertWithTitle:title msg:msg];
            
            break;
            
    }
    
    [self  dismissModalViewControllerAnimated:YES];
    
    
}
- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg

{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                          
                                                    message:msg
                          
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
    
    
}


- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(void)showPopoverView:(UIButton *)button
{
    
    isHidden = !isHidden;
    UIImageView * xiala = (UIImageView *)[[UIApplication sharedApplication].keyWindow viewWithTag:112];
    UIImageView * tipView = (UIImageView *)[self.navigationItem.titleView viewWithTag:102];
    
    [UIView animateWithDuration:0.3 animations:^{
        tipView.image = [personal getImageWithName:isHidden?@"arrow":@"arrow_up"];
        xiala.alpha = isHidden?0:1;
    }completion:^(BOOL finished)
     {
     }];
    
}

-(void)doTap:(UITapGestureRecognizer *)sender
{
    [self showPopoverView:nil];
    
    //    UIImageView * xiala = (UIImageView *)[[UIApplication sharedApplication].keyWindow viewWithTag:111];
    
    titleLabel.text = [array_chose objectAtIndex:sender.view.tag - 1];
    UIImageView * imageView = (UIImageView *)sender.view;
    UILabel * label = (UILabel *)[imageView viewWithTag:888888888];
    label.textColor = [UIColor whiteColor];
    
    UIImageView * imageView111111 = (UIImageView *)[xialaView_bbs viewWithTag:selecttionofxialaview];
    UILabel * label1 = (UILabel *)[imageView111111 viewWithTag:888888888];
    label1.textColor = [UIColor blackColor];
    
    if (imageView.tag==1)
    {
        imageView.image=[personal getImageWithName:@"bg_sel"];
        UIImageView * imageView1 = (UIImageView *)[xialaView_bbs viewWithTag:2];
        imageView1.image=nil;
        selecttionofxialaview=1;
        currentpage=1;
        issuccessload=YES;
        [self sendallmore];
        
    }else{
        imageView.image=[personal getImageWithName:@"bg_sel"];
        UIImageView * imageView1 = (UIImageView *)[xialaView_bbs viewWithTag:1];
        imageView1.image=nil;
        selecttionofxialaview=2;
        currentpage=1;
        issuccessload=YES;
        [self sendallmore];
    }
    [_SelectPick removeFromSuperview];
}
#pragma mark-提示正在加载
-(void)PromptingisLoading{
    
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    //[hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:@"正在加载"];
    [hud setActivity:YES];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    
}

#pragma mark-barview delegate
-(void)clickbutton:(UIButton *)sender{
    
    NSLog(@"button==%d",sender.tag);
    
    if (!isHidden)
    {
        [self showPopoverView:nil];
    }
    
    switch (sender.tag) {
        case 201:
            NSLog(@"刷新");
             selecttionofxialaview=1;
             currentpage=1;
           issuccessload=YES;
//            
          [_SelectPick removeFromSuperview];
            [self Doauthor:sender];
            
            break;
        case 202:
            NSLog(@"向前翻页");
            [_SelectPick removeFromSuperview];
            if (currentpage>1&&currentpage<=allpages&&issuccessload==YES) {
                issuccessload=!issuccessload;
                string_upordown=[NSString stringWithFormat:@"down"];
                [_SelectPick removeFromSuperview];
                
                if (dangqianwebview==1)//当前的webview是第一个webview,要让第二个webview的frame变成如下，在下载完之后显示出来
                {
                    dangqianwebview=2;
                    secondWebView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
                }else
                {
                    dangqianwebview=1;
                    _webView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
                    
                }
                currentpage--;
                [self sendallmore];
            }
            break;
        case 203:{
            NSLog(@"显示");
            
            
            
            
            NSLog(@"allpages===%d",allpages);
            NSMutableArray *array_shu=[[NSMutableArray alloc]init];
            for (int i=0; i<allpages; i++) {
                [array_shu addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            
            if (_SelectPick) {
                [_SelectPick removeFromSuperview];
                
            }
            _SelectPick=[[SelectNumberView alloc]initWithFrame:CGRectMake(0,iPhone5? 260:171, 320, 200) receiveArray:array_shu];

            
            _SelectPick.delegate=self;
            
            if (dangqianwebview==1) {
                [_webView addSubview:_SelectPick];
                
            }else{
                [secondWebView addSubview:_SelectPick];
            }
            
            if (allpages>1) {
                [_SelectPick ShowPick];
            }else{
                [_SelectPick removeFromSuperview];
            }
        }
            break;
        case 204:
            [_SelectPick removeFromSuperview];
            
            if (currentpage>0&&currentpage<allpages&&issuccessload==YES) {
                issuccessload=!issuccessload;
                string_upordown=[NSString stringWithFormat:@"up"];
                issuccessload=!issuccessload;
                currentpage++;
                if (dangqianwebview==1) {
                    dangqianwebview=2;
                    secondWebView.frame=CGRectMake(0,iPhone5? 314+88+105-41:314+105-41, 320 ,iPhone5? 314+88+105-41:314+105-41);
                    
                }else{
                    dangqianwebview=1;
                    _webView.frame=CGRectMake(0,iPhone5? 314+88+105-41:314+105-41, 320 ,iPhone5? 314+88+105-41:314+105-41);
                    
                }
                
                [self sendallmore];
            }
            break;
        case 205:
            [_SelectPick removeFromSuperview];
            
            NSLog(@"快速回复");
            [self comment];
            break;
            
        default:
            break;
    }
}
#pragma mark-webview的代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"request.URL.relativeString====%@",request.URL.relativeString);
    NSLog(@"request.URL.absoluteString====%@",request.URL.absoluteString);
    NSString *str_test=[request.URL.absoluteString substringToIndex:2];
    NSLog(@"str_test=%@",str_test);
    
    if ([str_test isEqualToString:@"he"]) {
        
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
        {
            
            NSString *string_realnumber=[request.URL.absoluteString substringFromIndex:5];
            NSLog(@"number=%@",string_realnumber);
            NewMineViewController *   _people =[[NewMineViewController alloc]init];
            _people.uid=[NSString stringWithFormat:@"%@",string_realnumber];
            [self.navigationController pushViewController:_people animated:YES];        }
        else{
            //没有激活fb，弹出激活提示
            LogInViewController *login=[LogInViewController sharedManager];
            [self presentViewController:login animated:YES completion:nil];
        }
        //
        //
        return NO;
    }
    
    if ([str_test isEqualToString:@"si"]) {
        NSString *string_realnumber=[request.URL.absoluteString substringFromIndex:3];
        NSLog(@"url===%@",string_realnumber);
        [self ShowbigImage:string_realnumber];
        return NO;
        
    }
    
    //floor:9回复楼层
    if ([str_test isEqualToString:@"fl"]) {
        NSString *string_realnumber=[request.URL.absoluteString substringFromIndex:6];
        NSLog(@"url===%@",string_realnumber);
        NSArray * idarray = [string_realnumber componentsSeparatedByString:@"pid:"];
        
        [self cfloor:idarray];
        
        return NO;
        
    }
    
    //
    //  request.URL.absoluteString====si:http://img1.fblife.com/attachments1/month_1307/20130712_52cb7fe23659d1665229x01x1BQkPEpd.png.thumb.jpg
    
    return YES;
}

#pragma mark-uiscrowviewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+60)&&scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height+100)) {
        NSLog(@"daole！");
        if (!didulabel) {
            didulabel=[[UILabel alloc]init];
            
        }
        didulabel.text=@"上拉进入下一页";
        didulabel.textColor=TEXT_COLOR;
        didulabel.textAlignment=NSTextAlignmentCenter;
        didulabel.font=[UIFont boldSystemFontOfSize:13.0f];
        didulabel.frame=CGRectMake(0,iPhone5?88+320:320, 320, 60);
        if (!diimgv) {
            diimgv=[[UIImageView alloc]initWithFrame:CGRectMake(40, 2, 20, 50)];
        }
        diimgv.image=[UIImage imageNamed:@"blueArrow.png"];
        [didulabel addSubview:diimgv];
        didulabel.backgroundColor=[UIColor clearColor];
        if (dangqianwebview==1) {
            [_webView addSubview:didulabel];
            
        }else{
            [secondWebView addSubview:didulabel];
        }
        
        if (currentpage>0&&currentpage<allpages) {
            didulabel.hidden=NO;
        }else{
            didulabel.hidden=YES;
        }
    }
    
    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+80)) {
        didulabel.text=@"松开进入下一页";
        diimgv.image=[UIImage imageNamed:@"bluedown.png"];
    }
    if (scrollView.contentOffset.y< (scrollView.contentSize.height - scrollView.frame.size.height+55)&&scrollView.contentOffset.y>0) {
        NSLog(@"慢慢来吧，总会到达的！");
        didulabel.hidden=YES;
    }
    
    if (scrollView.contentOffset.y< -50&&scrollView.contentOffset.y> -70) {
        if (!gaolabel) {
            gaolabel=[[UILabel alloc]init];
            
        }
        gaolabel.text=@"下拉进入上一页";
        gaolabel.textColor= TEXT_COLOR;
        gaolabel.textAlignment=NSTextAlignmentCenter;
        gaolabel.frame=CGRectMake(0, 0, 320, 60);
        gaolabel.font=[UIFont boldSystemFontOfSize:13.0f];
        gaolabel.backgroundColor=[UIColor clearColor];
        if (!gaoimgv) {
            gaoimgv=[[UIImageView alloc]initWithFrame:CGRectMake(40, 2, 20, 50)];
            
        }
        gaoimgv.image=[UIImage imageNamed:@"bluedown.png"];
        [gaolabel addSubview:gaoimgv];
        if (dangqianwebview==1) {
            [_webView addSubview:gaolabel];
            
        }
        if (dangqianwebview==2)
            
            
        {
            [secondWebView addSubview:gaolabel];
        }
        
        if (currentpage>1&&currentpage<=allpages) {
            gaolabel.hidden=NO;
            
        }else{
            gaolabel.hidden=YES;
            
        }
        
    }
    if (scrollView.contentOffset.y<-70) {
        gaolabel.text=@"松开进入上一页";
        gaoimgv.image=[UIImage imageNamed:@"blueArrow.png"];
        
    }
    if (scrollView.contentOffset.y> -50&&scrollView.contentOffset.y<0) {
        NSLog(@"下拉隐藏");
        gaolabel.hidden=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+80)) {
        NSLog(@"dayu80");
        
        if (currentpage>0&&currentpage<allpages&&issuccessload==YES)
        {
            string_upordown=[NSString stringWithFormat:@"up"];
            issuccessload=!issuccessload;
            currentpage++;
            if (dangqianwebview==1) {
                dangqianwebview=2;
                secondWebView.frame=CGRectMake(0,iPhone5? 314+88+105-41:314+105-41, 320 ,iPhone5? 314+88+105-41:314+105-41);
                
            }else{
                dangqianwebview=1;
                _webView.frame=CGRectMake(0,iPhone5? 314+88+105-41:314+105-41, 320 ,iPhone5? 314+88+105-41:314+105-41);
                
                
            }
            [self sendallmore];
            
        }
        
    }
    
    if (scrollView.contentOffset.y< -70) {
        
        if (currentpage>1&&currentpage<=allpages&&issuccessload==YES) {
            issuccessload=!issuccessload;
            string_upordown=[NSString stringWithFormat:@"down"];
            
            if (dangqianwebview==1)//当前的webview是第一个webview,要让第二个webview的frame变成如下，在下载完之后显示出来
            {
                dangqianwebview=2;
                secondWebView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
                
            }else
            {
                dangqianwebview=1;
                _webView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
                
            }
            
            currentpage--;
            [self sendallmore];
        }
        
    }
    
    
}


#pragma selectviewdelegate
-(void)ReceiveNumber:(NSInteger)number{
    if (currentpage>number) {
        issuccessload=!issuccessload;
        
        string_upordown=[NSString stringWithFormat:@"down"];
        
        if (dangqianwebview==1)//当前的webview是第一个webview,要让第二个webview的frame变成如下，在下载完之后显示出来
        {
            dangqianwebview=2;
            secondWebView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
            
        }else
        {
            dangqianwebview=1;
            _webView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
            
        }
        currentpage=number;
        
        [self sendallmore];
        [_SelectPick Dismiss];
        
        NSLog(@"下拉");
        
        
    }else if(currentpage==number){
        
        [_SelectPick Dismiss];
        
        
    }
    else {
        
        issuccessload=!issuccessload;
        string_upordown=[NSString stringWithFormat:@"up"];
        issuccessload=!issuccessload;
        if (dangqianwebview==1) {
            dangqianwebview=2;
            secondWebView.frame=CGRectMake(0,iPhone5? 314+88+105-41:314+105-41, 320 ,iPhone5? 314+88+105-41:314+105-41);
            
        }else{
            dangqianwebview=1;
            _webView.frame=CGRectMake(0,iPhone5? 314+88+105-41:314+105-41, 320 ,iPhone5? 314+88+105-41:314+105-41);
            
            
        }
        
        currentpage=number;
        
        [self sendallmore];
        [_SelectPick Dismiss];
        NSLog(@"上啦");
    }
}

-(void)NoticeFrameHigh{
    aview.frame=CGRectMake(0, -10, 320, iPhone5?568:480);
}
-(void)NoticeFrameLow{
    
    aview.frame=CGRectMake(0, 0, 320, iPhone5?568:480);
    
}
#pragma mark-回帖
-(void)comment{
    if (!isHidden)
    {
        [self showPopoverView:nil];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        commrntbbdViewController *_comment=[[commrntbbdViewController alloc]init];
        _comment.title_string=@"回帖";
        _comment.string_distinguish=@"回帖";
        
        _comment.string_fid=str_fid;
        _comment.string_tid=str_tid;
        [self presentModalViewController:_comment animated:YES];
    }
    else{
        //没有激活fb，弹出激活提示
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentModalViewController:login animated:YES];
    }
    
}
#pragma mark-回复楼层
-(void)cfloor:(NSArray*)floor{
    NSLog(@"floorarray=%@",floor);
    if (!isHidden)
    {
        [self showPopoverView:nil];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        commrntbbdViewController *_comment=[[commrntbbdViewController alloc]init];
        _comment.title_string=@"回贴";
        _comment.string_fid=str_fid;
        _comment.string_tid=str_tid;
        _comment.string_distinguish=@"回复主题";
        if (floor.count==2) {
            _comment.string_subject=[NSString stringWithFormat:@"回复%@楼的帖子",[floor objectAtIndex:0]];
            _comment.string_floor=[NSString stringWithFormat:@"%@",[floor objectAtIndex:0]];
            _comment.string_pid=[NSString stringWithFormat:@"%@",[floor objectAtIndex:1]];
            [self presentModalViewController:_comment animated:YES];
            
        }else{
            NSLog(@"取了不正确的数据");
        }
        
    }
    else{
        //没有激活fb，弹出激活提示
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentModalViewController:login animated:YES];
    }
    
    
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photos.count;
}
//返回点击的哪一张
- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
    
}
-(void)ShowbigImage:(NSString *)imgurl{
    
    _photos=[[NSMutableArray alloc]init];
    
    NSString *string_imgurl=[NSString stringWithFormat:@"%@",imgurl];
    NSLog(@"string_url=%@",string_imgurl);
    [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:string_imgurl]]];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.title_string=string_title;
    browser.displayActionButton = YES;
    
    [browser setInitialPageIndex:0];
    [self presentModalViewController:browser animated:YES];
    
}

#pragma mark-发送请求数据
-(void)sendallmore{
    //self.bbsdetail_tid=@"1573337";
    if (!_isloadingIv) {
        _isloadingIv=[[loadingimview alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"正在加载"];
        [[UIApplication sharedApplication].keyWindow
         addSubview:_isloadingIv];
        
    }
    _isloadingIv.hidden=NO;
    
    NSString *string_authcode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    if (!isauthor) {
        all_tool=[[downloadtool alloc]init];
        
        [all_tool setUrl_string:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getthreadsnew.php?tid=%@&page=%d&formattype=json&authcode=%@",self.bbsdetail_tid,currentpage,string_authcode]];
      //  [all_tool setUrl_string:@"http://bbs2.fblife.com/bbsapinew/getthreadsnew_tmp.php?tid=2999060&page=1&formattype=json"];
        [all_tool start];
        all_tool.tag=107;
        all_tool.delegate=self;
        
        NSString *stringurl=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getthreadsnew.php?tid=%@&page=%d&formattype=json&authcode=%@",self.bbsdetail_tid,currentpage,string_authcode];
        NSLog(@"查看全部url=%@",stringurl);
        
    }else{
        authortool=[[downloadtool alloc]init];
        [authortool setUrl_string:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getthreadauthornew.php?tid=%@&page=%d&formattype=json&authcode=%@",self.bbsdetail_tid,currentpage,string_authcode]];
        
        [authortool start];
        authortool.tag=107;
        authortool.delegate=self;
        
        NSString *stringurl=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getthreadauthornew.php?tid=%@&page=%d&formattype=json&authcode=%@",self.bbsdetail_tid,currentpage,string_authcode];
        NSLog(@"查看楼主的url=%@",stringurl);
    }
    
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    
    @try {
        dic = [data objectFromJSONData];
        NSString *errcode_string=[NSString stringWithFormat:@"%@",[dic objectForKey:@"errcode"]];
        NSLog(@"dicinfo=%@",dic);
        
        /*
         errcode = 0;
         fid = 216;
         tid = 2875684;
         title = "\U5357\U7ca4\U8c79\U519b\Uff0c\U73a9\U8f6c\U5e7f\U5dde";
         url = "bbs.fblife.com/thread_2875684.hmtl";
         */
        
        string_title=[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
        string_url=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
        
        _isloadingIv.hidden=YES;
        if (tool.tag==107) {
            if ([errcode_string isEqualToString:@"0"]) {
                button_share.userInteractionEnabled=YES;
                
                str_fid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"fid"]];
                str_tid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"tid"]];
                NSMutableString *stringhtml=[[NSMutableString alloc]initWithString:[dic objectForKey:@"bbsinfo"]];
                
                [ stringhtml insertString:@"<style type=text/css>img {max-width:240px;}  </style>" atIndex:0];
                //stringhtml= (NSMutableString*)[stringhtml stringByReplacingOccurrencesOfString:@"background-color:#efedea;" withString:@""];
                
                
                
                
                allpages=[[dic objectForKey:@"all_pages"] integerValue];
                
                
                
                NSLog(@"xjshjall====%d",allpages);
                
                
                
                
                //  barview.button_show.titleLabel.text=[NSString stringWithFormat:@"%d/%d",currentpage,allpages];
                [barview.button_show setTitle:[NSString stringWithFormat:@"%d/%d",currentpage,allpages] forState:UIControlStateNormal];
                
                if (dangqianwebview==1) {
                    [_webView loadHTMLString:stringhtml  baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                }else{
                    [secondWebView loadHTMLString:stringhtml  baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                    
                }
                issuccessload=YES;
                [hud hideAfter:0.4];
                [self ShowbeforeFineshed];
                
                
                
            }else{
                [hud hideAfter:0.4];
                
                NSString *stringerrorinfo=[NSString stringWithFormat:@"%@",[dic objectForKey:@"bbsinfo"]];
                            UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:stringerrorinfo delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                         [alert_ show];
                [_replaceAlertView removeFromSuperview];
//                _replaceAlertView=nil;
//                _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:stringerrorinfo];
//                _replaceAlertView.delegate=self;
//                _replaceAlertView.hidden=NO;
//                [_replaceAlertView hide];
//                [[UIApplication sharedApplication].keyWindow
//                 addSubview:_replaceAlertView];
                
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
   
}
-(void)downloadtoolError{
    _isloadingIv.hidden=YES;
    
    //    UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接超时，请检查您的网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert_ show];
    jiushizhegele++;
    if (jiushizhegele<20) {
        [self sendallmore];
    }else{
        _replaceAlertView.hidden=NO;
        [_replaceAlertView hide];
        
    }

}
#pragma mark-没有加载完就进行动画
-(void)ShowbeforeFineshed{
    
    if ([string_upordown isEqualToString:@""]) {
        NSLog(@"第一次加载，不做操作");
        
    }else     if ([string_upordown isEqualToString:@"up"]) {
        NSLog(@"上拉");
        if (dangqianwebview==1) {
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            _webView.frame=CGRectMake(0, 0, 320 ,iPhone5? 314+88+105-41:314+105-41);
            secondWebView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
            [UIView commitAnimations];
            
            
            
        }else{
            NSLog(@"应该走这个方法");
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            secondWebView.frame=CGRectMake(0, 0, 320 ,iPhone5? 314+88+105-41:314+105-41);
            _webView.frame=CGRectMake(0, -(iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
            [UIView commitAnimations];
            
        }
        
        
        
        
    }else     if ([string_upordown isEqualToString:@"down"]) {
        NSLog(@"下拉");
        
        if (dangqianwebview==1) {
            
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            _webView.frame=CGRectMake(0, 0, 320 ,iPhone5? 314+88+105-41:314+105-41);
            secondWebView.frame=CGRectMake(0, (iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
            [UIView commitAnimations];
            
            
            
        }else{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            secondWebView.frame=CGRectMake(0, 0, 320 ,iPhone5? 314+88+105-41:314+105-41);
            _webView.frame=CGRectMake(0, (iPhone5? 314+88+105-41:314+105-41), 320 ,iPhone5? 314+88+105-41:314+105-41);
            [UIView commitAnimations];
            
        }
        
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
-(void)backto
{
    
    if (!isHidden)
    {
        [self showPopoverView:nil];
    }
    
    [authortool stop];
    authortool.delegate=nil;
    
    [all_tool stop];
    all_tool.delegate=nil;
    [xialaView_bbs removeFromSuperview];
    
    [_replaceAlertView removeFromSuperview];
    _replaceAlertView=nil;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
