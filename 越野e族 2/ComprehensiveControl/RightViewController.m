//
//  RightViewController.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-7.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "RightViewController.h"
#import "SliderBBSViewController.h"
#import "AppDelegate.h"
#import "FriendListViewController.h"
#import "MessageViewController.h"
#import "FBNotificationViewController.h"
#import "SliderRightSettingViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "NewWeiBoViewController.h"
#import "NewMineViewController.h"
#import "MMDrawerController.h"
#import "DraftBoxViewController.h"
#import "DetailViewController.h"
#import "ShowImagesViewController.h"
#import "ShoucangViewController.h"//收藏界面
#import "MyWriteAndCommentViewController.h"//我发布的帖子和我回复的帖子
#import "GscanfViewController.h"
#import "SliderSearchViewController.h"


@interface RightViewController ()
{
    AppDelegate * myDelegate;
    
    UIScrollView * _rootScrollView;
    
}

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
//    self.navigationController.navigationBarHidden = YES;
//    
//    self.wantsFullScreenLayout = YES;
//    
//    if (MY_MACRO_NAME) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        
//    }

    
//    [self setup];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(237,238,243);
    
//    if (MY_MACRO_NAME) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        
//    }
    
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBarHidden = YES;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(checkallmynotification) userInfo:nil repeats:YES];
    
//    [self setup];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL islogin = [userDefaults boolForKey:USER_IN];
    

    
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,298,(iPhone5?568:480))];
    
    _rootScrollView.backgroundColor = RGBCOLOR(242,242,242);
    
    _rootScrollView.showsVerticalScrollIndicator = NO;
    
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    
    _rootScrollView.bounces = NO;
    
    _rootScrollView.backgroundColor = [UIColor clearColor];
    
 //   [self.view addSubview:_rootScrollView];
    
    
    
    UIView * user_Info_BackView = [[UIView alloc] initWithFrame:CGRectMake(0,0,298,191)];
    
    user_Info_BackView.backgroundColor = RGBCOLOR(248,248,248);
    
    user_Info_BackView.layer.masksToBounds = NO;
    
    user_Info_BackView.layer.shadowColor = [UIColor blackColor].CGColor;//RGBCOLOR(216,216,216).CGColor;
    
    user_Info_BackView.layer.shadowOffset = CGSizeMake(0.5,0.5);
    
    user_Info_BackView.layer.shadowRadius = 1;
    
    user_Info_BackView.layer.shadowOpacity = 0.2;
    
    [self.view addSubview:user_Info_BackView];
    
    
    
    //    [self receivemyimage_head];
    
    headerImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(103,46,82,82)];
    
    if (islogin)
    {
        NSString * header_image_url = [userDefaults objectForKey:USER_FACE];
        
        if (header_image_url.length == 0)
        {
            [self receivemyimage_head];
        }else{
            [headerImageView loadImageFromURL:header_image_url withPlaceholdImage:[UIImage imageNamed:@"touxiang"]];
        }
    }else
    {
        headerImageView.image = [UIImage imageNamed:@"SliderRightLogin.png"];
    }
    
    headerImageView.layer.masksToBounds = YES;
    
    headerImageView.layer.cornerRadius = 41;
    
    headerImageView.userInteractionEnabled = YES;
    
    headerImageView.layer.borderColor = RGBCOLOR(121,121,121).CGColor;
    
    headerImageView.layer.borderWidth = 1;
    
    [user_Info_BackView addSubview:headerImageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapToLogIn:)];
    
    [headerImageView addGestureRecognizer:tap];
    
    
    LogIn_label = [[UILabel alloc] initWithFrame:CGRectMake(0,145,288,25)];
    
    LogIn_label.text = islogin?[userDefaults objectForKey:USER_NAME]:@"点击立即登录";
    
    LogIn_label.font = [UIFont systemFontOfSize:15];
    
    LogIn_label.textAlignment = NSTextAlignmentCenter;
    
    LogIn_label.textColor = RGBCOLOR(142,142,142);
    
    LogIn_label.backgroundColor = [UIColor clearColor];
    
    [user_Info_BackView addSubview:LogIn_label];
    
    
    NSArray * arrary = [NSArray arrayWithObjects:@"SliderRighttiezi.png",@"SliderRightstar.png",@"SliderRightfriend.png",@"SliderRightfbgray73_67.png",@"SliderRightmessage.png",@"SliderRighttongzhi.png",@"SliderRightcaogaoxiangRes61_69.png",@"SliderRightsaoyisao.png",@"SliderSeachImage.png",nil];
    
    NSArray * arrary1 = [NSArray arrayWithObjects:@"帖子",@"收藏",@"好友",@"自留地",@"私信",@"通知",@"草稿箱",@"扫一扫",@"搜索",nil];
    
    
    for (int i = 0;i < 3;i++) {
        for (int j = 0;j < 3;j++)
        {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(30 + 90*j,(iPhone5?230:210)+(iPhone5?90:75)*i,44,60);
            
            [button setTitle:[arrary1 objectAtIndex:j+i*3] forState:UIControlStateNormal];
            
            [button setTitleColor:RGBCOLOR(145,145,145) forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(60,-5,0,-5)];
            
            button.tag = 1000 + i*3+j;
            
            button.backgroundColor = [UIColor clearColor];
            
            [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:button];
            
            
            UIImage * image = [UIImage imageNamed:[arrary objectAtIndex:j+i*3]];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,image.size.width,image.size.height)];
            
            imageView.image = image;
            
            imageView.center = CGPointMake(22,23);
            
            [button addSubview:imageView];
            
            
            if (i*3+j == 5)
            {
                if (!notification_view)
                {
                    notification_view = [[UIView alloc] initWithFrame:CGRectMake(35,50,8,8)];
                    
                    notification_view.backgroundColor = RGBCOLOR(255,0,60);
                    
                    notification_view.hidden = !NewsMessageNumber;
                    
                    notification_view.layer.cornerRadius = 4;
                    
                    notification_view.layer.masksToBounds = NO;
                    
                    [button addSubview:notification_view];
                }
            }
        }
    }
    
    
    UILabel * version_label = [[UILabel alloc] initWithFrame:CGRectMake(40,_rootScrollView.frame.size.height-(iPhone5?50:40),100,30)];
    
    version_label.text = [NSString stringWithFormat:@"v %@",NOW_VERSION];
    
    version_label.textAlignment = NSTextAlignmentLeft;
    
    version_label.textColor = RGBCOLOR(143,143,145);
    
    version_label.font = [UIFont systemFontOfSize:14];
    
    version_label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:version_label];
    
    
    
    UIButton * setting_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    setting_button.frame = CGRectMake(207,_rootScrollView.frame.size.height-(iPhone5?48:38),60,30);
    
    [setting_button setTitle:@"设置" forState:UIControlStateNormal];
    
    [setting_button setImage:[UIImage imageNamed:@"SliderRightshezhi.png"] forState:UIControlStateNormal];
    
    [setting_button setTitleColor:RGBCOLOR(143,143,145) forState:UIControlStateNormal];
    
    setting_button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [setting_button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,40)];
    
    [setting_button addTarget:self action:@selector(settingButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:setting_button];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(receivemyimage_head) name:@"LogIn" object:nil];//登陆成功通知
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(LogOutNotification) name:@"logoutToChangeHeader" object:nil];//退出登陆通知
}



-(void)setup
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL islogin = [userDefaults boolForKey:USER_IN];
    
    if (islogin)
    {
        [self checkallmynotification];
    }
    
    if (_rootScrollView)
    {
        if (islogin)
        {
            NSString * header_image_url = [userDefaults objectForKey:USER_FACE];
            
            if (header_image_url.length == 0)
            {
                [self receivemyimage_head];
            }else{
                [headerImageView loadImageFromURL:header_image_url withPlaceholdImage:[UIImage imageNamed:@"touxiang"]];
            }
        }else
        {
            headerImageView.image = [UIImage imageNamed:@"SliderRightLogin.png"];
        }
        
        return;
    }
    
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,298,(iPhone5?568:480))];
    
    _rootScrollView.backgroundColor = RGBCOLOR(242,242,242);
    
    _rootScrollView.showsVerticalScrollIndicator = NO;
    
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    
    _rootScrollView.bounces = NO;
    
    _rootScrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_rootScrollView];
    
    
    
    UIView * user_Info_BackView = [[UIView alloc] initWithFrame:CGRectMake(0,0,298,191)];
    
    user_Info_BackView.backgroundColor = RGBCOLOR(248,248,248);
    
    user_Info_BackView.layer.masksToBounds = NO;
    
    user_Info_BackView.layer.shadowColor = [UIColor blackColor].CGColor;//RGBCOLOR(216,216,216).CGColor;
    
    user_Info_BackView.layer.shadowOffset = CGSizeMake(0.5,0.5);
    
    user_Info_BackView.layer.shadowRadius = 1;
    
    user_Info_BackView.layer.shadowOpacity = 0.2;
    
    [_rootScrollView addSubview:user_Info_BackView];
    
    
    
//    [self receivemyimage_head];
    
    headerImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(103,46,82,82)];
    
    if (islogin)
    {
        NSString * header_image_url = [userDefaults objectForKey:USER_FACE];
        
        if (header_image_url.length == 0)
        {
            [self receivemyimage_head];
        }else{
            [headerImageView loadImageFromURL:header_image_url withPlaceholdImage:[UIImage imageNamed:@"touxiang"]];
        }
    }else
    {
        headerImageView.image = [UIImage imageNamed:@"SliderRightLogin.png"];
    }
    
    headerImageView.layer.masksToBounds = YES;
    
    headerImageView.layer.cornerRadius = 41;
    
    headerImageView.userInteractionEnabled = YES;
    
    headerImageView.layer.borderColor = RGBCOLOR(121,121,121).CGColor;
    
    headerImageView.layer.borderWidth = 1;
    
    [user_Info_BackView addSubview:headerImageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapToLogIn:)];
    
    [headerImageView addGestureRecognizer:tap];
    
    
    LogIn_label = [[UILabel alloc] initWithFrame:CGRectMake(0,145,288,25)];
    
    LogIn_label.text = islogin?[userDefaults objectForKey:USER_NAME]:@"点击立即登录";
    
    LogIn_label.font = [UIFont systemFontOfSize:15];
    
    LogIn_label.textAlignment = NSTextAlignmentCenter;
    
    LogIn_label.textColor = RGBCOLOR(142,142,142);
    
    LogIn_label.backgroundColor = [UIColor clearColor];
    
    [user_Info_BackView addSubview:LogIn_label];
    
    
    NSArray * arrary = [NSArray arrayWithObjects:@"SliderRighttiezi.png",@"SliderRightstar.png",@"SliderRightfriend.png",@"SliderRightfbgray73_67.png",@"SliderRightmessage.png",@"SliderRighttongzhi.png",@"SliderRightcaogaoxiangRes61_69.png",@"SliderRightsaoyisao.png",@"SliderSeachImage.png",nil];
    
    NSArray * arrary1 = [NSArray arrayWithObjects:@"帖子",@"收藏",@"好友",@"自留地",@"私信",@"通知",@"草稿箱",@"扫一扫",@"搜索",nil];
    
    
    for (int i = 0;i < 3;i++) {
        for (int j = 0;j < 3;j++)
        {

            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(30 + 90*j,(iPhone5?230:210)+(iPhone5?90:75)*i,44,60);
            
            [button setTitle:[arrary1 objectAtIndex:j+i*3] forState:UIControlStateNormal];
            
            [button setTitleColor:RGBCOLOR(145,145,145) forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(60,-5,0,-5)];
            
            button.tag = 1000 + i*3+j;
            
            button.backgroundColor = [UIColor clearColor];
            
            [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            
            [_rootScrollView addSubview:button];
        
        
            UIImage * image = [UIImage imageNamed:[arrary objectAtIndex:j+i*3]];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,image.size.width,image.size.height)];
        
            imageView.image = image;
        
            imageView.center = CGPointMake(22,23);
            
            [button addSubview:imageView];
            
            
            if (i*3+j == 5)
            {
                if (!notification_view)
                {
                    notification_view = [[UIView alloc] initWithFrame:CGRectMake(35,50,8,8)];
                    
                    notification_view.backgroundColor = RGBCOLOR(255,0,60);
                    
                    notification_view.hidden = !NewsMessageNumber;
                    
                    notification_view.layer.cornerRadius = 4;
                    
                    notification_view.layer.masksToBounds = NO;
                    
                    [button addSubview:notification_view];
                }
            }
        }
    }
    

    UILabel * version_label = [[UILabel alloc] initWithFrame:CGRectMake(40,_rootScrollView.frame.size.height-(iPhone5?50:40),100,30)];
    
    version_label.text = [NSString stringWithFormat:@"v %@",NOW_VERSION];
    
    version_label.textAlignment = NSTextAlignmentLeft;
    
    version_label.textColor = RGBCOLOR(143,143,145);
    
    version_label.font = [UIFont systemFontOfSize:14];
    
    version_label.backgroundColor = [UIColor clearColor];
    
    [_rootScrollView addSubview:version_label];
    
    
    
    UIButton * setting_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    setting_button.frame = CGRectMake(207,_rootScrollView.frame.size.height-(iPhone5?48:38),60,30);
    
    [setting_button setTitle:@"设置" forState:UIControlStateNormal];
    
    [setting_button setImage:[UIImage imageNamed:@"SliderRightshezhi.png"] forState:UIControlStateNormal];
    
    [setting_button setTitleColor:RGBCOLOR(143,143,145) forState:UIControlStateNormal];
    
    setting_button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [setting_button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,40)];
    
    [setting_button addTarget:self action:@selector(settingButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [_rootScrollView addSubview:setting_button];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(receivemyimage_head) name:@"LogIn" object:nil];//登陆成功通知
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(LogOutNotification) name:@"logoutToChangeHeader" object:nil];//退出登陆通知
}


#pragma mark - 登陆

-(void)headerTapToLogIn:(UIButton *)sender
{
    BOOL logIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (logIn)
    {
        NewMineViewController * mine = [[NewMineViewController alloc] init];
        
        [myDelegate.root_nav pushViewController:mine animated:YES];
        
    }else
    {
        LogInViewController * login = [LogInViewController sharedManager];
        
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
}


#pragma mark - 登陆成功获取用户头像等信息

-(void)receivemyimage_head{
    
    [timer fire];
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:URL_USERMESSAGE,@"(null)",authkey];
    NSLog(@"1请求的url = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            if ([[dic objectForKey:@"errcode"] intValue] !=1)
            {
                NSDictionary * dictionary = [[[dic objectForKey:@"data"] allValues] objectAtIndex:0];
                
                NSString *string_uid=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"uid"]];
                
                NSString * userName = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"nickname"]];
                
                NSString * userFace = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"face_original"]];
                                
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:string_uid forKey:USER_UID];
                
                [defaults setObject:userName forKey:USER_NAME];
                
                [defaults setObject:userFace forKey:USER_FACE];
                
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"successgetuid" object:Nil];
                
                
                LogIn_label.text = userName;
                
//                [headerImageView loadImageFromURL:userFace withPlaceholdImage:[UIImage imageNamed:@"SliderRightLogin.png"]];
                
                [headerImageView loadUserHeaderImageFromUrl:userFace withPlaceholdImage:[UIImage imageNamed:@"touxiang"]];
                
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


#pragma mark - 退出登陆

-(void)LogOutNotification
{
    headerImageView.image = [UIImage imageNamed:@"SliderRightLogin.png"];
    
    LogIn_label.text = @"点击立即登录";
    
    [timer invalidate];
}


#pragma mark - 点击功能按钮

-(void)buttonTap:(UIButton *)sender
{
    if (sender.tag - 1000 != 7 && sender.tag-1000 != 8)
    {
        BOOL islogIn = [self isLogIn];
        
        if (!islogIn) {
            return;
        }
    }
    
    
        
    switch (sender.tag - 1000) {
        case 0:
        {
            NSLog(@"帖子");
            MyWriteAndCommentViewController * shoucangVC = [[MyWriteAndCommentViewController alloc] init];
                        
            [myDelegate.root_nav pushViewController:shoucangVC animated:YES];

  
            
        }
            break;
        case 1:
        {
            NSLog(@"收藏");
            
            ShoucangViewController * shoucangVC = [[ShoucangViewController alloc] init];
            
            [myDelegate.root_nav pushViewController:shoucangVC animated:YES];
            
        }
            break;
        case 2://好友
        {
            FriendListViewController * friend = [[FriendListViewController alloc] init];
            
            friend.title_name_string = @"联系人";
            
            friend.delegate = self;
            
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:friend];
            
            [self presentViewController:nav animated:YES completion:NULL];
            
        }
            break;
        case 3://个人主页
        {
            [self headerTapToLogIn:sender]; //已登录跳转到个人信息页
        }
            break;
        case 4://私信
        {
            MessageViewController * message = [[MessageViewController alloc] init];
            
//            [myDelegate.pushViewController.navigationController pushViewController:message animated:YES];
//            
//            [myDelegate.pushViewController setNavigationHiddenWith:NO WithBlock:^{
//                
//            }];
            
            [myDelegate.root_nav pushViewController:message animated:YES];
            
            
            
            
            
        }
            break;
        case 5://通知
        {
            
            NewsMessageNumber = NO;
            
            notification_view.hidden = YES;
            
            FBNotificationViewController *fbno=[[FBNotificationViewController alloc]init];
            
            [myDelegate.root_nav pushViewController:fbno animated:YES];
        }
            break;
        case 6://草稿箱
        {
            DraftBoxViewController *draft=[[DraftBoxViewController alloc]init];
            
            [myDelegate.root_nav pushViewController:draft animated:YES];
        }
            break;
        case 7://扫一扫
        {
            DetailViewController *_qrcode=[[DetailViewController alloc]init];
            
            [myDelegate.root_nav pushViewController:_qrcode animated:YES];
        
        }
            break;
        case 8://搜索
        {
            SliderSearchViewController * search =[[SliderSearchViewController alloc]init];
            
            UINavigationController * search_nav = [[UINavigationController alloc] initWithRootViewController:search];
            
            [self presentViewController:search_nav animated:YES completion:NULL];
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 判断是否登录


-(BOOL)isLogIn
{
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!isLogIn)
    {
        LogInViewController * login = [LogInViewController sharedManager];
        
//        [[self getAppDelegate].pushViewController presentViewController:login animated:YES completion:^{
//            
//        }];
        
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
    
    return isLogIn;
}


#pragma mark - 跳转到设置界面

-(void)settingButtonTap:(UIButton *)sender
{    
    SliderRightSettingViewController * settingVC = [[SliderRightSettingViewController alloc] init];
    
    [myDelegate.root_nav pushViewController:settingVC animated:YES];
}


#pragma mark - 去更新

#pragma mark-UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag == 10000)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/yue-ye-yi-zu/id605673005?mt=8"]];
    }
}



-(AppDelegate *)getAppDelegate
{
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return appdelegate;
}



#pragma mark - 联系人代理，跳转到个人界面

-(void)returnUserName:(NSString *)username Uid:(NSString *)uid
{
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    
    mine.uid = uid;
    
    [[self getAppDelegate].root_nav pushViewController:mine animated:YES];
}



#pragma mark - 获取消息

-(void)checkallmynotification
{
    NSString *string_code=[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD];
    
    //    NSLog(@"steing_code ----   %@",string_code);
    
    if (string_code.length !=0 && ![string_code isEqual:[NSNull null]])
    {
        if (!allnotificationtool)
        {
            allnotificationtool=[[downloadtool alloc]init];
        }
        
        [allnotificationtool setUrl_string:[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",string_code ]];
        
        //  NSLog(@"未读消息接口 ----   %@",[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",string_code ]);
        
        allnotificationtool.delegate=self;
        [allnotificationtool start];
    }
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        if (tool==allnotificationtool)
        {
            NewsMessageNumber = 0;
            
            NSDictionary * alertnum_dic = [dic objectForKey:@"alertnum"];
            
           // NSLog(@"未读消息 ------  %@",alertnum_dic);
            
            for (int i = 0;i <= 16;i++)
            {
                if (i == 9)
                {
                    if ([[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue]>0)
                    {
                        NewsMessageNumber = YES;
                        
                        notification_view.hidden = NO;
                    }
                }
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(void)downloadtoolError
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end































