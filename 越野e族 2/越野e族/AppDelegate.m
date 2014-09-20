//
//  AppDelegate.m
//  越野e族
//
//  Created by soulnear on 13-12-16.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//ifaiqingshenai

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "bbsdetailViewController.h"
#import "FbFeed.h"
#import "UMSocialSnsService.h"
#import "WXApi.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "MessageViewController.h"
#import "PersonalmoreViewController.h"
/**
 *  tes
 */
#import "MMDrawerController.h"

#import "RightViewController.h"

@implementation AppDelegate
@synthesize rootVC;
@synthesize bbsVC;
@synthesize mineVC;
@synthesize moreVC;
@synthesize weiboVC;
@synthesize _center;
@synthesize pushViewController = _pushViewController;
@synthesize navigationController = _navigationController;
@synthesize root_nav = _root_nav;
@synthesize RootVC = _RootVC;


@synthesize managedObjectModel=_managedObjectModel;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;



- (void)dealloc
{
    [_window release];
    
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [super dealloc];
}

#pragma mark-友盟分享

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self judgeversionandclean];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    //友盟分享平台
    
    if (launchOptions) {
        
        
        
        
        
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey) {
            
            
          
            // [alert show];
            dic_push =[[NSDictionary alloc]initWithDictionary:pushNotificationKey];
            
            
            
//            UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",dic_push] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            
//            [myalert show];
        }
        
        
        NSDictionary * locationNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        if (locationNotificationKey)
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",locationNotificationKey] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
    
    self.window = [[[UIWindow alloc] initWithFrame:CGRectMake(0,MY_MACRO_NAME?0:0,320,MY_MACRO_NAME? [[UIScreen mainScreen] bounds].size.height:iPhone5?568+20:480+20)] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    flagofpage=0;
    bgCount=1;
    
    //    UIDevice *device_=[[UIDevice alloc] init];
    //    NSLog(@"设备所有者的名称－－%@",device_.name);
    //    NSLog(@"设备的类别－－－－－%@",device_.model);
    //    NSLog(@"设备的的本地化版本－%@",device_.localizedModel);
    //    NSLog(@"设备运行的系统－－－%@",device_.systemName);
    //    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
    //    NSLog(@"设备识别码－－－－－%@",device_.identifierForVendor.UUIDString);
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    
    [UMSocialData setAppKey:@"5153e5e456240b79e20006b9"];
    [WXApi registerApp:@"wx4fb411c415f89047"];
    
    [ WeiboSDK registerApp:@"2335514239"];
    [ WeiboSDK enableDebugMode:YES ];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newsid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"version"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"content"];
    
    
    
    
    [MobClick startWithAppkey:@"5153e5e456240b79e20006b9" reportPolicy:BATCH channelId:nil];
    
    [MobClick setLogEnabled:YES];
    
    self.window = [[[UIWindow alloc] initWithFrame:CGRectMake(0,MY_MACRO_NAME?0:0,320,MY_MACRO_NAME? [[UIScreen mainScreen] bounds].size.height:iPhone5?568+20:480+20)] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //    if (IOS_VERSION<7.0)
    //    {
    //        self.window.frame = CGRectMake(0,-20,320,[[UIScreen mainScreen] bounds].size.height+20);
    //    }
    
    
    if (!bigimageview) {
        bigimageview=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
    }
    bigimageview.backgroundColor=[UIColor colorWithRed:245/255.f green:244/255.f blue:242/255.f alpha:1];
    [self.window addSubview:bigimageview];
    
    if (!iMagelogo) {
        iMagelogo=[[UIImageView alloc]init];
        
    }
    iMagelogo.frame=CGRectMake(0,iPhone5? 568-217/2:480-217/2, 320, 217/2);
    
    iMagelogo.image=[UIImage imageNamed:@"ios7_fengmianlogo2.png"];
    
    if (!guanggao_image) {
        guanggao_image=[[AsyncImageView alloc]init];
        
    }
    // guanggao_image.frame=CGRectMake(0, 0, 320,iPhone5? 936/2:936/2);
    
    guanggao_image.alpha=0;
    NSString *string_img=[[NSUserDefaults standardUserDefaults]objectForKey:@"img"];
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [guanggao_image addGestureRecognizer:singleRecognizer];
    guanggao_image.delegate = self;
    NSLog(@"defaimg======%@",string_img);
    
    if (string_img.length!=0) {
        NSLog(@"长度不等于0");
        
        
    }else{
        
    }
    [bigimageview addSubview:guanggao_image];
    [bigimageview addSubview:iMagelogo];
    
    
    
    
    UIView *redview=[[UIView alloc]initWithFrame:CGRectMake(0, iPhone5?568/2-40:480/2-40, 320, 12)];
    redview.backgroundColor=[UIColor clearColor];
    [bigimageview addSubview:redview];
    img_TEST=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_loading61_12_4.png"]];
    img_TEST.center=CGPointMake(160, 6);
    [redview addSubview:img_TEST];
    NSTimer *theTimer;
    theTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(changepic) userInfo:nil repeats:YES];
    
    //[self usenewguanggao];
    
    [self NewShowMainVC];
    
    //    [self keepAlive:[[NSNumber alloc] initWithInt:100]];
    
    [self.window makeKeyAndVisible];
    
    
    
    //推送不烦你 apns
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"testpush" object:dic_push];
    
    //内部推送
    
    
    [application cancelAllLocalNotifications];
    [self createLocationNotificationWith:[NSArray arrayWithObjects:@"活动安排1",@"2014感受城市脉搏",nil] WithDate:[NSArray arrayWithObjects:@"2014-09-19 16:26:00",@"2014-09-19 16:09:00",nil]];
    
    // Required
    
    
    
    //百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"CMjcQLZ5Ww7DNm60aTaqB4s3"  generalDelegate:nil];
    
    if (!ret) {
        
        NSLog(@"manager start failed!");
    }
    
    
    return YES;
}
#pragma mark - 创建本地推送
-(void)createLocationNotificationWith:(NSArray *)array WithDate:(NSArray *)theDate
{
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"TheScheduleList" ofType:@"plist"];
    NSMutableDictionary * scheduleDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    NSArray * allKeys = [scheduleDic allKeys];
    
    for (int i = 0;i < allKeys.count;i++)
    {
        NSString * aDate = [allKeys objectAtIndex:i];
        NSString * aValue = [scheduleDic objectForKey:aDate];
        
        UILocalNotification *notification = [[[UILocalNotification alloc] init] autorelease];
        
        NSDate *pushDate = [zsnApi dateFromString:aDate];//[NSDate dateWithTimeIntervalSinceNow:10];//设置10秒之后
        NSDate * nowDate = [NSDate date];
        
        if ([nowDate timeIntervalSinceDate:pushDate] < 0)
        {
            if (notification != nil) {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone defaultTimeZone];
                // 设置重复间隔
                notification.repeatInterval = kCFCalendarUnitEra;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;//@"new-mail.caf";
                // 推送内容
                notification.alertBody = aValue;
                //显示在icon上的红色圈中的数子
                notification.applicationIconBadgeNumber = 1;
                //设置userinfo 方便在之后需要撤销的时候使用
                NSDictionary *info = [NSDictionary dictionaryWithObject:aValue forKey:@"key"];
                notification.userInfo = info;
                //添加推送到UIApplication
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
            }
        }
    }
}

-(void)changepic{
    
    flagofpage++;
    
    switch (flagofpage) {
        case 1:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_4.png"];
        }
            break;
        case 2:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_3.png"];
            
        }
            break;
        case 3:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_2.png"];
            
        }
            break;
        case 4:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_1.png"];
            
        }
            break;
            
        default:
            break;
    }
    
    if (flagofpage==4) {
        flagofpage=0;
    }
    
    
    
    
    
}


-(void)usenewguanggao{
    
    downloadtool *tool_=[[downloadtool alloc]init];
    tool_.tag=100;
    [tool_ setUrl_string:@"http://cmsweb.fblife.com/data/app.ad.txt"];
    tool_.delegate=self;
    [tool_ start];
    
    //    timer=[NSTimer scheduledTimerWithTimeInterval:15
    //                                           target:self
    //                                         selector:@selector(NewShowMainVC)
    //                                         userInfo:nil
    //                                          repeats:NO];
    //
    
    
}

-(void)handleImageLayout:(AsyncImageView *)tag
{
    
    
    NSLog(@"asyim====%@",tag);
    
    if (tag==nil) {
        
        
        
        [self usenewguanggao];
        
    }else
    {
        
        
        
        [img_TEST removeFromSuperview];
        guanggao_image.image=iPhone5?guanggao_image.image:[self getSubImage:CGRectMake(0, (568-480)*2, 640,guanggao_image.image.size.height)];
        
        guanggao_image.frame=CGRectMake(0, 0, guanggao_image.image.size.width/2, guanggao_image.image.size.height/2+2);
        
        NSLog(@"gaungdada -----  %f ----  %f",guanggao_image.image.size.width/2,guanggao_image.image.size.height/2+2);
        
        
        NSLog(@"appdelegate===仔仔到了图片");
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        guanggao_image.alpha=1;
        // iMagelogo.frame=CGRectMake(43/2,iPhone5? 413+44+40:413, 566/2, 85/2);
        [UIView commitAnimations];
        [self performSelector:@selector(NewShowMainVC) withObject:nil afterDelay:3];
    }
}


-(void)succesDownLoadWithImageView:(UIImageView *)imageView Image:(UIImage *)image{
    
    
    
}
-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    if (tool.tag==100) {
        
        @try {
            //  NSDictionary * dic = [data objectFromJSONData];
            
            NSDictionary *array_test=[data objectFromJSONData];
            NSLog(@"======dic== %@",array_test);
            
            
            if (array_test.count==0) {
                
                
                
                [self NewShowMainVC];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"img"];
                
                NSLog(@"没有找到图片");
                
            }else{
                
                NSDictionary *dic=[array_test objectForKey:@""];
                NSLog(@"dic== %@",dic);
                
                NSString *string_src=[NSString stringWithFormat:@"%@",[array_test objectForKey:@"imgsrc"]];
                
                NSLog(@"src==%@",string_src);
                [guanggao_image loadImageFromURL:string_src withPlaceholdImage:nil];
                
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    
    //这个是回来之后看看有没有新消息
    
    
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        if (tool==allnotificationtool)
        {
            NewsMessageNumber = 0;
            
            NSDictionary * alertnum_dic = [dic objectForKey:@"alertnum"];
            
            //  NSLog(@"未读消息 ------  %@",alertnum_dic);
            
            for (int i = 0;i <= 16;i++)
            {
                if (i == 6)
                {
                    if ([[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue]>0)
                    {
                        _leveyTabBarController.tabBar.tixing_imageView.hidden = NO;
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"fbnotification" object:[NSDictionary dictionary]];
                        
                    }
                }else
                {
                    if ([[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue]>0)
                    {
                        _leveyTabBarController.tabBar.tixing_imageView.hidden = NO;
                        
                        //                        self.leveyTabBarController.tabBar.tixing_label.hidden = NO;
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"fbnotification" object:[NSDictionary dictionary]];
                        
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





//- (void)update:(PRTweenPeriod*)period {
//
//    if ([period isKindOfClass:[PRTweenCGPointLerpPeriod class]]) {
//        guanggao_image.center = [(PRTweenCGPointLerpPeriod*)period tweenedCGPoint];
//    } else {
//        guanggao_image.frame = CGRectMake(0, period.tweenedValue, 320,iPhone5? 772/2:772/2);
//    }
//
//}


-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(guanggao_image.image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

-(void)downloadtoolError{
    
    
    NSLog(@"网络链接异常");
    [self NewShowMainVC];
    
}

-(void)showzhuview{
    [guanggao_image cancelDownload];
    guanggao_image.delegate=nil;
    
    
    
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    
    if (!rootVC || !bbsVC || !weiboVC || !mineVC || !moreVC || !_leveyTabBarController)
    {
        rootVC = [[RootViewController alloc] init];
        UINavigationController * naVC1 = [[UINavigationController alloc] initWithRootViewController:rootVC];
        
        
        bbsVC = [[BBSViewController alloc] init];
        UINavigationController * naVC2 = [[UINavigationController alloc] initWithRootViewController:bbsVC];
        
        
        
        weiboVC = [[NewWeiBoViewController alloc] init];
        UINavigationController * naVC3 = [[UINavigationController alloc] initWithRootViewController:weiboVC];
        
        
        mineVC = [[CarPortViewController alloc] init];
        UINavigationController * naVC4 = [[UINavigationController alloc] initWithRootViewController:mineVC];
        
        
        moreVC = [[PersonalmoreViewController alloc] init];
        UINavigationController * naVC5 = [[UINavigationController alloc] initWithRootViewController:moreVC];
        
        naVC1.delegate = (id)self;
        naVC2.delegate = (id)self;
        naVC3.delegate = (id)self;
        naVC4.delegate = (id)self;
        naVC5.delegate = (id)self;
        
        
        NSArray * array = [[NSArray alloc] initWithObjects:naVC1,naVC2,naVC3,naVC4,naVC5,nil];
        
        NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic setObject:[UIImage imageNamed:@"newsselected.png"] forKey:@"Default"];
        [imgDic setObject:[UIImage imageNamed:@"newsselected.png"] forKey:@"Highlighted"];
        [imgDic setObject:[UIImage imageNamed:@"newsselected.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic2 setObject:[UIImage imageNamed:@"bbsselected.png"] forKey:@"Default"];
        [imgDic2 setObject:[UIImage imageNamed:@"bbsselected.png"] forKey:@"Highlighted"];
        [imgDic2 setObject:[UIImage imageNamed:@"bbsselected.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic3 setObject:[UIImage imageNamed:@"fbselectios7.png"] forKey:@"Default"];
        [imgDic3 setObject:[UIImage imageNamed:@"fbselectios7.png"] forKey:@"Highlighted"];
        [imgDic3 setObject:[UIImage imageNamed:@"fbselectios7.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic4 setObject:[UIImage imageNamed:@"carportselected.png"] forKey:@"Default"];
        [imgDic4 setObject:[UIImage imageNamed:@"carportselected.png"] forKey:@"Highlighted"];
        [imgDic4 setObject:[UIImage imageNamed:@"carportselected.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic5 setObject:[UIImage imageNamed:@"personalselected.png"] forKey:@"Default"];
        [imgDic5 setObject:[UIImage imageNamed:@"personalselected.png"] forKey:@"Highlighted"];
        [imgDic5 setObject:[UIImage imageNamed:@"personalselected.png"] forKey:@"Seleted"];
        
        NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,imgDic5,nil];
        
        
        
        
        
        
        _leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:array imageArray:imgArr];
        [_leveyTabBarController setTabBarTransparent:YES];
        [_leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"ios7tabbar@2x.png"]];
        _leveyTabBarController.delegate = self;
        
        
        [guanggao_image removeFromSuperview];
        [iMagelogo removeFromSuperview];
        [bigimageview removeFromSuperview];
        
        guanggao_image=nil;
        iMagelogo=nil;
        bigimageview=nil;
        //  [_leveyTabBarController setSelectedIndex:4];
        
        self.window.rootViewController=_leveyTabBarController;
      
        
        
        
        
        
        
        //
        //        CGRect frame = CGRectMake(0, 0, 320, 49);
        //        UIView *v = [[UIView alloc] initWithFrame:frame];
        //        UIImage *img = [UIImage imageNamed:@"menu_bg.png"];
        //        UIColor *color = [[UIColor alloc] initWithPatternImage:img];
        //        v.backgroundColor = color;
        //        [tabbar.tabBar insertSubview:v atIndex:0];
        //        tabbar.tabBar.opaque = NO;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([viewController isKindOfClass:[RootViewController class]]||[viewController isKindOfClass:[BBSViewController class]]||[viewController isKindOfClass:[NewWeiBoViewController class]]||[viewController isKindOfClass:[CarPortViewController class]]||[viewController isKindOfClass:[PersonalmoreViewController class]])
	{
        [_leveyTabBarController hidesTabBar:NO animated:YES];
	}else{
        [_leveyTabBarController hidesTabBar:YES animated:NO];
        NSLog(@"1viewController=%@",viewController);
        
    }
    
    //[_leveyTabBarController hidesTabBar:YES animated:YES];
}


- (BOOL)tabBarController:(LeveyTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    static UIViewController *lastController = nil;
    //若上个view不为空
    if (lastController != nil)
    {
        //若该实例实现了viewWillDisappear方法，则调用
        if ([lastController respondsToSelector:@selector(viewWillDisappear:)])
        {
            [lastController viewWillDisappear:NO];
        }
    }
    //将当前要显示的view设置为lastController，在下次view切换调用本方法时，会执行viewWillDisappear
    lastController = viewController;
    
    [viewController viewWillAppear:NO];
    index = tabBarController.selectedIndex;
    return YES;
}
- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //    NSLog(@"aaaaadddddd ---  %d",tabBarController.selectedIndex);
    //    if (tabBarController.selectedIndex == 3)
    //    {
    //        BOOL authkey = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    //
    //        if (!authkey)
    //        {
    //            if (!logIn)
    //            {
    //                logIn = [[LogInViewController alloc] init];
    //
    //            }
    //            logIn.delegate = self;
    //            [_leveyTabBarController hidesTabBar:YES animated:YES];
    //            [viewController presentModalViewController:logIn animated:YES];
    //        }
    //    }
}








#pragma mark-广告image

-(void)handleSingleTapFrom{
    //    NSURL *url =[NSURL URLWithString:@"www.fblife.com"];
    //    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    //    UIWebView *awebview=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //    [awebview loadRequest:request];
    //    [self.window addSubview:awebview];
}
-(void)failToLogIn
{
    NSLog(@"这个方法没走么");
    [_leveyTabBarController hidesTabBar:NO animated:NO];
    //    _leveyTabBarController.selectedIndex = index;
    [_leveyTabBarController displayViewAtIndex:index];
}

-(void)successToLogIn
{
    [_leveyTabBarController hidesTabBar:NO animated:YES];
    _leveyTabBarController.selectedIndex = 3;
}

-(void)seccesDownLoad:(UIImage *)image{
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    
    
    
    
    
    
    NSLog(@"===token===%@======",deviceToken);
    
    NSString *string_pushtoken=[NSString stringWithFormat:@"%@",deviceToken];
    
    while ([string_pushtoken rangeOfString:@"<"].length||[string_pushtoken rangeOfString:@">"].length||[string_pushtoken rangeOfString:@" "].length) {
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@"<" withString:@""];
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@">" withString:@""];
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:string_pushtoken forKey:DEVICETOKEN];
    
    NSLog(@"mystring_token==%@",string_pushtoken);
    
    //更新token
    
    
    
    
    NSString *string_authcode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    if (string_authcode.length!=0) {
        NSString *string_updatetoken=[NSString stringWithFormat:@"http://bbs2.fblife.com/localapi/user_app_token.php?action=updatetoken&authcode=%@&token=%@&datatype=json",string_authcode,string_pushtoken ];
        
        NSLog(@"???????????????????????????=string_updatepushtoken==%@",string_pushtoken);
        ASIHTTPRequest *   request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:string_updatetoken]];
        
        __block ASIHTTPRequest * _requset = request;
        
        _requset.delegate = self;
        
        [_requset setCompletionBlock:^{
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            
            @try {
                if ([[dic objectForKey:@"errcode"] intValue] ==0)
                {
                    
                    NSLog(@"说明绑定成功了");
                    
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
    
    
    
    NSLog(@"__");
    
    
    
    
    // Required
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
    
    
    //    pushinfo===={
    //        aps =     {
    //            alert = "\U60a8\U6709[1]\U6761\U5f15\U7528\U56de\U590d\U901a\U77e5";
    //            badge = 2;
    //            sound = default;
    //            tid = 3004018;
    //            type = 21;
    //        };
    //    }
    
    NSDictionary *dic_pushinfo=userInfo;
    
    
    int type=[[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"type"] integerValue];
    
    if (type<20&&[[NSUserDefaults standardUserDefaults] boolForKey:USER_IN]) {
        
        
        
        
        
        _leveyTabBarController.tabBar.tixing_imageView.hidden = NO;
        
        
        NSLog(@"pushinfo====%@",userInfo);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"fbnotification" object:userInfo];
    }
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"notification -=-=-=-=-  %@",notification.userInfo);
    
    UIAlertView * myAlert = [[UIAlertView alloc] initWithTitle:[notification.userInfo objectForKey:@"key"] message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    
    [myAlert show];
    
    [application cancelLocalNotification:notification];
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //    userinfo=={
    //        content = "\U5317\U4eac\U73b0\U4ee3ix35\U660e\U5e74\U5c06\U4e2d\U671f\U6539\U6b3e \U642d2.4L\U76f4\U55b7\U53d1\U52a8\U673a
    //        \n";
    //        extras =     {
    //            newsid = "36016 ";
    //        };
    //    }
    
    
    
    
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newsid"];
    
    NSDictionary * userInfo = [notification userInfo];
    NSLog(@"userinfo==%@",userInfo);
    
    
    NSString *string_newsid=[[userInfo objectForKey:@"extras"] objectForKey:@"newsid"];
    NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
    
    if (string_newsid.length!=0&&![string_newsid isEqualToString:@"(null)"]) {
        [standarduser setObject:string_newsid forKey:@"newsid"];
        [standarduser synchronize];
        
    }
    [standarduser setObject:string_newsid forKey:@"version"];
    
    NSString *string_update=[[userInfo objectForKey:@"extras"] objectForKey:@"version"];
    
    [standarduser setObject:string_update forKey:@"version"];
    NSLog(@"stringupdate===%@",string_update);
    if (string_update.length>0) {
        NSString *content = [userInfo valueForKey:@"content"];
        [standarduser setObject:content forKey:@"content"];
    }
    [standarduser synchronize];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    //    [_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    //    UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"推送的消息" message:[NSString stringWithFormat:@"收到消息\ndate:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],content] delegate:nil cancelButtonTitle:@"去看看" otherButtonTitles:@"正在忙", nil];
    //    [alert_ show];
}


#pragma mark-强制刷新
#pragma mark-判断是否更新版本，以及是否更新缓存里面的数据
-(void)judgeversionandclean{
    
    NSUserDefaults *standuser=[NSUserDefaults standardUserDefaults];
    int i=10;
    [standuser setInteger:i forKey:@"judgeversionandclean"];
    [standuser synchronize];
    
    
    NSURL * fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/version.php?appversion=%@",NOW_VERSION]];
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:fullUrl];
    
    __block ASIHTTPRequest * _request = request;
    
    request.delegate = self;
    
    [_request setCompletionBlock:^{
        
        @try {
            NSDictionary * dic__ = [request.responseData objectFromJSONData];
            
            NSString * bbsInfo = [NSString stringWithFormat:@"%@",[dic__ objectForKey:@"bbsinfo"]];
            NSString *string_refresh=[NSString stringWithFormat:@"%@",[dic__ objectForKey:@"isrefresh"]];
            if ([string_refresh isEqualToString:@"0"]) {
                NSLog(@"判断了，走的是进行缓存");
                int i=10;
                [standuser setInteger:i forKey:@"judgeversionandclean"];
                [standuser synchronize];
                
            }else{
                
                int i=11;
                [standuser setInteger:i forKey:@"judgeversionandclean"];
                [standuser synchronize];
                for (int i=0;i < 6;i++)
                {
                    [FbFeed deleteAllByType:i+1];
                }
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bbsSelect"];
                
            }
            NSLog(@"dic===%@",dic__);
            
            NSLog(@"");
            if (![bbsInfo isEqualToString:NOW_VERSION])
            {
                int i=12;
                [standuser setInteger:i forKey:@"judgeversionandclean"];
                [standuser synchronize];
            }else
            {
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [_request setFailedBlock:^{
        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测失败,请检查您当前网络是否正常" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        //        [alert show];
    }];
    
    [request startAsynchronous];
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"chuqu le ?");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

static int temptest = 0;

static BOOL isSixTimes=YES;


static int numberof = 0;


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    if (isSixTimes) {
        
        [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
            
            
            numberof++;
            
            if (numberof>6) {
                isSixTimes=NO;
            }
            
            UIApplication *app = [UIApplication sharedApplication];
            __block    UIBackgroundTaskIdentifier szkTast;
            szkTast = [app beginBackgroundTaskWithExpirationHandler:
                       ^{
                           [app endBackgroundTask:szkTast];
                           szkTast = UIBackgroundTaskInvalid;
                       }];
        }];
        
        
        UIApplication *app = [UIApplication sharedApplication];
        __block    UIBackgroundTaskIdentifier szkTast;
        szkTast = [app beginBackgroundTaskWithExpirationHandler:
                   ^{
                       [app endBackgroundTask:szkTast];
                       szkTast = UIBackgroundTaskInvalid;
                   }];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            while (1)
            {
                //                NSLog(@"%d",temptest);
                sleep(1);
                temptest++;
            }
        });
        
        
        
    }
    
    
    
    
    
    
    
    
    //    szkTast = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
    //
    //
    //        [[UIApplication sharedApplication]  endBackgroundTask:szkTast];
    //
    //        szkTast = UIBackgroundTaskInvalid;
    //
    //        bgCount += 1;
    //
    //    }];
    //
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //
    //        while (1) {
    //
    //            if (szkTast == UIBackgroundTaskInvalid) {
    //
    //                break;
    //
    //            }
    //
    //            //运行的方法
    //
    //
    //            NSTimeInterval remainingTime = [UIApplication sharedApplication].backgroundTimeRemaining;
    //
    //            if (remainingTime < 10) {
    //
    //
    //                NSLog(@"sszz");
    //
    //                break;
    //
    //            }
    //
    //            NSLog(@"BackgroundTaskWithExpiration:%f",remainingTime);
    //
    //            sleep(1);
    //
    //        }
    //
    //
    //        [[UIApplication sharedApplication]  endBackgroundTask:szkTast];
    //
    //        szkTast = UIBackgroundTaskInvalid;
    //
    //        bgCount += 1;
    //
    //    });
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //    backgroundTask_ = [[UIApplication sharedApplication]     beginBackgroundTaskWithExpirationHandler:^{
    //
    //        [[UIApplication sharedApplication] endBackgroundTask:backgroundTask_];
    //        backgroundTask_ = UIBackgroundTaskInvalid;
    //    }];
    //
    //
    //
    //    NSLog(@"十分钟了");
    //    UIBackgroundTaskIdentifier taskID = 0;
    //
    //    taskID = [application beginBackgroundTaskWithExpirationHandler:^{
    //        //如果系统觉得我们还是运行了太久，将执行这个程序块，并停止运行应用程序
    //        [application endBackgroundTask:taskID];
    //    }];
    //
    //
    //
    //
    //
    
    
    
    //szk
    
    
    
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //
    center = [[CTCallCenter alloc ] init ];
    //
    //    self._center=center;
    
    
    
    center.callEventHandler = ^(CTCall *call )
    {
        
        NSLog (@"call:%@" , call .callState);
    };
    
    
    
    NSLog(@"ssss=====application====%@",application);
    
    NSLog(@"huilaile ");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    
    [MobClick setDelegate:self];
    
    [MobClick appLaunched];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


#pragma mark-获取通知总数
//-(void)AllNumberofNotification{
//    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkallmynotification) userInfo:nil repeats:YES];
//
//
//}
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
        
        //          NSLog(@"未读消息接口 ----   %@",[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",string_code ]);
        
        allnotificationtool.delegate=self;
        [allnotificationtool start];
    }
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
    
    // return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
#pragma mark-这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
    
    
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark--新改版，幺西

-(void)prepairShareView{
    
    
    self.halfBlackView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
}

-(void)NewShowMainVC{
    
    
    
    //    [guanggao_image cancelDownload];
    //    guanggao_image.delegate=nil;
    //
    //    [guanggao_image removeFromSuperview];
    //    [iMagelogo removeFromSuperview];
    [bigimageview removeFromSuperview];
    //
    //    guanggao_image=nil;
    //    iMagelogo=nil;
    //    bigimageview=nil;
    
    
    
    
    
    _navigationController = [[UINavigationController alloc] initWithRootViewController:[[ComprehensiveViewController alloc] init]];
    
    
    
    //    UINavigationController *ritht = [[UINavigationController alloc] initWithRootViewController:[[RightViewController alloc] init]];
    
    //
    
    RightViewController * rightVC = [[RightViewController alloc] init];
    
    
    LeftViewController *menuViewController = [[LeftViewController alloc] init];
    
    
    
    _RootVC=[[MMDrawerController alloc]initWithCenterViewController:_navigationController leftDrawerViewController:menuViewController rightDrawerViewController:rightVC];
    
    
    [_RootVC setMaximumRightDrawerWidth:288];
    [_RootVC setMaximumLeftDrawerWidth:287];
    _RootVC.shouldStretchDrawer = NO;
    [_RootVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [_RootVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    _RootVC.showsShadow = YES;
    
    
    _root_nav = [[UINavigationController alloc] initWithRootViewController:_RootVC];
    
    
    
    
    
    
    _root_nav.navigationBarHidden = YES;
    self.window.rootViewController = _root_nav;//sideMenuViewController;
    
    
    _pushViewController = [[FansViewController alloc] init];
    
    UINavigationController * pushNav = [[UINavigationController alloc] initWithRootViewController:_pushViewController];
    
    pushNav.view.frame = CGRectMake(320,0,320,iPhone5?568:480);
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"testpush" object:dic_push];

    
    //  [self.window.rootViewController.view addSubview:pushNav.view];
    
}


#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController");
}


#pragma mark - coredata相关

//托管对象
-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel!=nil) {
        return _managedObjectModel;
    }
    NSURL* modelURL=[[NSBundle mainBundle] URLForResource:@"AtlasSavedPraAndCollModel" withExtension:@"momd"];
    _managedObjectModel=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    //    _managedObjectModel=[[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    return _managedObjectModel;
}
//托管对象上下文
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext!=nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator* coordinator=[self persistentStoreCoordinator];
    if (coordinator!=nil) {
        _managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
//持久化存储协调器
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator!=nil) {
        return _persistentStoreCoordinator;
    }
    //    NSURL* storeURL=[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreaDataExample.CDBStore"];
    //    NSFileManager* fileManager=[NSFileManager defaultManager];
    //    if(![fileManager fileExistsAtPath:[storeURL path]])
    //    {
    //        NSURL* defaultStoreURL=[[NSBundle mainBundle] URLForResource:@"CoreDataExample" withExtension:@"CDBStore"];
    //        if (defaultStoreURL) {
    //            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
    //        }
    //    }
    NSString* docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL* storeURL=[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"AtlasSavedPraAndCollModel.sqlite"]];
    NSLog(@"path is %@",[docs stringByAppendingPathComponent:@"AtlasSavedPraAndCollModel.sqlite"]);
    NSError* error=nil;
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    return _persistentStoreCoordinator;
}



#pragma mark-延长后台时间



- (BOOL) isMultitaskingSupported{
    
    BOOL result = NO;
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
        
    {
        
        result = [[UIDevice currentDevice]  isMultitaskingSupported];
        
    }
    
    return result;
    
}

- (void)keepAlive:(NSNumber *)Num {
    
    backgroundTask_ = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
        
        [[UIApplication sharedApplication]  endBackgroundTask:backgroundTask_];
        
        backgroundTask_ = UIBackgroundTaskInvalid;
        
        bgCount += 1;
        
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        while (1) {
            
            if (backgroundTask_ == UIBackgroundTaskInvalid) {
                
                break;
                
            }
            
            //运行的方法
            
            
            NSTimeInterval remainingTime = [UIApplication sharedApplication].backgroundTimeRemaining;
            
            if (remainingTime < 10) {
                
                break;
                
            }
            
            //          NSLog(@"BackgroundTaskWithExpiration:%f",remainingTime);
            
            sleep(1);
            
        }
        
        
        [[UIApplication sharedApplication]  endBackgroundTask:backgroundTask_];
        
        backgroundTask_ = UIBackgroundTaskInvalid;
        
        bgCount += 1;
        
    });
    
}

//-(void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame{
//    NSLog(@"statubar.....=========%f",oldStatusBarFrame.origin.y);
//
//    NSLog(@"stat=====ubar.....=========%f", _leveyTabBarController.view.frame.origin.y);
//    NSLog(@"ssssss=====%f",_leveyTabBarController.tabBar.frame.origin.y);
//
////    if (MY_MACRO_NAME) {
//        if (_leveyTabBarController.view.frame.origin.y>0) {
//
////            _leveyTabBarController.tabBar.frame=CGRectMake(_leveyTabBarController.tabBar.frame.origin.x, _leveyTabBarController.tabBar.frame.origin.y-20, _leveyTabBarController.tabBar.frame.size.width, _leveyTabBarController.tabBar.frame.size.height);
//            _leveyTabBarController.view.frame=CGRectMake(0, 0, _leveyTabBarController.view.frame.size.width, _leveyTabBarController.view.frame.size.height);
//            
//        }else{
//            
////            _leveyTabBarController.tabBar.frame=CGRectMake(_leveyTabBarController.tabBar.frame.origin.x,iPhone5?431+88: 431, _leveyTabBarController.tabBar.frame.size.width, _leveyTabBarController.tabBar.frame.size.height);
////            
//        }
//
//        
////    }else{
////        
////        
////        
////    }
//
//    
//}


@end
