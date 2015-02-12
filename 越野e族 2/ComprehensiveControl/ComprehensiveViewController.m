//
//  ComprehensiveViewController.m
//  越野e族asass
//
//  Created by 史忠坤 on 14-6-30.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ComprehensiveViewController.h"

#import "UIImageView+LBBlurredImage.h"

#import "UIViewController+MMDrawerController.h"

#import "LeftViewController.h"

#import "RightViewController.h"

#import "ShowImagesViewController.h"//看图集

#import "CompreTableViewCell.h"

#import "SzkLoadData.h"

#import "PicShowViewController.h"

#import "RootViewController.h"//新闻首页

#import "SliderBBSViewController.h"//论坛首页

#import "NewMainViewModel.h"

#import "BBSfenduiViewController.h"

#import "GuanggaoViewController.h"//广告

#import "NewMainViewModel.h"//普通新闻数据的model

#import "ShowImagesViewController.h"

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

#import "GmapViewController.h"//地图

#import "GongGaoViewController.h"

///浮动层开始显示的时间
#define SHOW_TIME @"2014-09-30 02:00:00"
///浮动层消失的时间
#define HIDDEN_TIME @"2014-10-04 23:00:00"



@interface ComprehensiveViewController (){

    UIBarButtonItem * spaceButton;
    NSMutableArray *com_id_array;//幻灯的id
    NSMutableArray *com_type_array;//幻灯的type
    NSMutableArray *com_link_array;//幻灯的外链
    NSMutableArray *com_title_array;//幻灯的标题
    ///浮动框
    AwesomeMenu * awesomeMenu;
    
    ///存放所有活动内容及时间
    NSMutableDictionary * my_dictionary;
    
    ///计时器，如果没有获取到线上日程表一直获取
    NSTimer * timer;
    
    BOOL isShowGuangGao;
    
    bool isBegan;
    CGPoint start_point;
}

@end

@implementation ComprehensiveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        return img;
        
    }
    
    
    
}


/**
 *  判断版本号605673005
 */


-(void)panduanIsNewVersion{

    SzkLoadData *newload=[[SzkLoadData alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"605673005"];
    
   [newload SeturlStr:url mytest:^(NSDictionary *dicinfo, int errcode) {
       
       
       @try {
           NSArray *_newarray=[NSArray arrayWithObject:[dicinfo objectForKey:@"results"]];
           
           NSArray *firstdic=[_newarray objectAtIndex:0];
           
           NSDictionary *seconddic=[firstdic objectAtIndex:0];
           
           NSLog(@"dicnew==%@",seconddic);
           
           NSString *stringInfo=[NSString stringWithFormat:@"%@",[seconddic objectForKey:@"releaseNotes"]];
           NSString *nowline=[NSString stringWithFormat:@"%@",[seconddic objectForKey:@"version"]];
           
           NSLog(@"taidanteng==%@",nowline);
           // NSLog(@"线上版本是%@当前版本是%@",xianshangbanben,NOW_VERSION);
           
           if ([nowline isEqualToString:NOW_VERSION]) {
               
               NSLog(@"当前是最新版本");
               
           }else{
               
               
               
               UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:stringInfo delegate:self cancelButtonTitle:@"立即升级" otherButtonTitles:@"下次提示",nil];
               
               alert.delegate = self;
               
               alert.tag = 10000;
               [alert show];
               
               
           }
       }
       @catch (NSException *exception) {
           
       }
       @finally {
           
       }
      // NSLog(@"dicnew===%@",dicinfo);
       
     // NSString *xianshangbanben=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"results"] ];
       
      
       
       
       
   }];
    



}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag == 10000)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/yue-ye-yi-zu/id605673005?mt=8"]];
    }
}

#pragma mark-外部来了推送走这里

-(void) showOutput:(NSNotification *)note
{
    NSLog(@"%@",note);
    
//    
//    UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"waibu" message:[NSString stringWithFormat:@"%@",note] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alertV show];
   
    
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
            
        case 30:
        {
            
            
        
            
            NSString *string_tid=[NSString stringWithFormat:@"%@",[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"nid"]];
            [self pushNewsdetailWithnid:string_tid];
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    NSLog(@"==note==%@",dic_pushinfo);
    
}

-(void)pushNewsdetailWithnid:(NSString *)string_nid{

    newsdetailViewController *detail=[[newsdetailViewController alloc]init];
    detail.string_Id=string_nid;
    [self.navigationController pushViewController:detail animated:YES];
    awesomeMenu.hidden = YES;


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

    [super viewDidLoad];
    
    isShowGuangGao=YES;
    
    [self turnToguanggao];
    
    
    
    
    self.navigationController.navigationBarHidden=YES;

/**/
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;


    //判断新版本
    
    
    [self panduanIsNewVersion];
  NSLog(@"shizhongkun转化成MD5加密后的字符串为=%@",[self md5:@"shizhongkun"])  ;
    
    
    isloadsuccess = YES;
    
    numberofpage=1;
    //点击了广告
    
   // [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
    
    
    
    normalinfoAllArray=[NSMutableArray array];
    
    [self prepairNavigationBar];
    
    [[NSNotificationCenter defaultCenter]
     
     addObserver:self selector:@selector(ssTurntoFbWebview:) name:@"TouchGuanggao" object:nil];
    
    
    //refreshcompre
    
    [[NSNotificationCenter defaultCenter]
     
     addObserver:self selector:@selector(jiaSshuaxin) name:@"refreshcompre" object:nil];//点击了广告
    
    

    
    
    
    

    
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    huandengDic=[NSDictionary dictionary];
    
    [self layoutSubViewsOfload];
    
    [self loadHuandeng];
    [self loadNomalData];
    
    NSDate * now = [NSDate date];
    NSDate * end_time = [zsnApi dateFromString:HIDDEN_TIME];
    
    if ([now timeIntervalSinceDate:end_time] < 0)
    {
        [self loadActivityData];
        [self loadNewsData];
        timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(checkTheNetWork) userInfo:nil repeats:YES];
    }
    
    
    ////添加左右滑动到侧边栏手势
    /*create the Pan Gesture Recognizer*/
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    
    //外部来了推送之后，会走这里
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showOutput:) name:@"testpush" object:nil];
}

-(void)handlePanGestures:(UIPanGestureRecognizer *)paramSender{
    
    CGPoint current_point = [paramSender locationInView:self.view.superview];
    
    if (!isBegan && current_point.x >0)
    {
        start_point = current_point;
        isBegan = YES;
    }
    
    if (paramSender.state == UIGestureRecognizerStateChanged && start_point.x != 0) {
        if (start_point.x - current_point.x > 50) {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
        
        if (start_point.x - current_point.x < -50) {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        }
    }
    
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        isBegan = NO;
        start_point = CGPointZero;
    }
    
}



-(void)layoutSubViewsOfload{
    nomore=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 30)];
    nomore.text=@"没有更多数据";
    nomore.textAlignment=NSTextAlignmentCenter;
    nomore.font=[UIFont systemFontOfSize:13];
    nomore.textColor=[UIColor lightGrayColor];
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
    loadview.backgroundColor=[UIColor clearColor];
    
    
    mainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    mainTabView.delegate=self;
    mainTabView.dataSource=self;
    mainTabView.backgroundColor=[UIColor whiteColor];
    mainTabView.separatorColor=[UIColor clearColor];
    [self.view addSubview:mainTabView];
    
    
    UIView *placeview=[[UIView alloc]initWithFrame:mainTabView.frame];
    placeview.tag=234;
    //   placeview.backgroundColor=RGBCOLOR(222, 222, 222);
    UIImageView *imgcenterlogo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_newsbeijing.png"]];
    imgcenterlogo.center=CGPointMake(mainTabView.frame.size.width/2, mainTabView.frame.size.height/2-20);
    [placeview addSubview:imgcenterlogo];
    placeview.hidden=NO;
    [mainTabView addSubview:placeview];
    
    
    
    
    
    
    if (_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-mainTabView.bounds.size.height, DEVICE_WIDTH, mainTabView.bounds.size.height)];
        view.delegate = self;
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    [mainTabView addSubview:_refreshHeaderView];
    


}
#pragma mark-从广告页面回来刷新一下

-(void)jiaSshuaxin{
    
    self.navigationController.navigationBarHidden=NO;
    
    
    [UIView animateWithDuration:0.6 animations:^{
        mainTabView.contentOffset=CGPointMake(0, -60);
        
        mainTabView.contentOffset=CGPointMake(0, 0);
        
        
    } completion:^(BOOL finished) {
        
        
        
    }
     ];
    
    
    if (normalinfoAllArray.count==0||huandengDic.count==0) {
        
        [self loadHuandeng];
        
        [self loadNomalData];
    }
}


#pragma mark - 判断是否显示浮动框,英雄会专题
#pragma mark - 判断是否显示浮动框(英雄会期间展示)
-(void)isShowAwesomeMenu
{
    
    if (awesomeMenu)
    {
        awesomeMenu.hidden = NO;
        [awesomeMenu setBackgroundColor:[UIColor clearColor]];
        return;
    }
    
    NSDate * now = [NSDate date];
    NSDate * begin_time = [zsnApi dateFromString:SHOW_TIME];
    NSDate * end_time = [zsnApi dateFromString:HIDDEN_TIME];
    
    
    if ([now timeIntervalSinceDate:begin_time] < 0)
    {
        return;
    }
        
    if ([now timeIntervalSinceDate:begin_time] > 0 && [now timeIntervalSinceDate:end_time]<0)
    {
        
        NSArray * images_array = [NSArray arrayWithObjects:@"AwesomeMenu_gonggao",@"AwesomeMenu_ditu",@"AwesomeMenu_zhinan",@"AwesomeMenu_wenjuan",@"AwesomeMenu_weibo",nil];
         NSMutableArray *menus = [NSMutableArray array];
        for (int i = 0;i < images_array.count;i++)
        {
            UIImage * image = [UIImage imageNamed:[images_array objectAtIndex:(images_array.count - 1) - i]];
            AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:image
                                                                   highlightedImage:nil
                                                                       ContentImage:nil
                                                            highlightedContentImage:nil];
            
            [menus addObject:starMenuItem1];
        }
        
        AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"AwesomeMenu_addbutton"]
                                                           highlightedImage:nil
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
        
        awesomeMenu = [[AwesomeMenu alloc] initWithFrame:self.navigationController.view.bounds startItem:startItem optionMenus:menus];
        awesomeMenu.delegate = self;
        awesomeMenu.menuWholeAngle = 5*M_PI/6;
        awesomeMenu.farRadius = 110.0f;
        awesomeMenu.endRadius = 100.0f;
        awesomeMenu.nearRadius = 90.0f;
        awesomeMenu.animationDuration = 0.4f;
        awesomeMenu.rotateAddButton = NO;
        awesomeMenu.startPoint = CGPointMake(DEVICE_WIDTH,DEVICE_HEIGHT-48);
        [self.navigationController.view addSubview:awesomeMenu];
        
    }
}

#pragma mark - AWeSomeMenuDelegate
#pragma mark - 点击的第几个
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    [awesomeMenu setBackgroundColor:[UIColor clearColor]];
    if (idx == 3) {//跳转到离线地图
        //添加离线地图包资源 并显示地图
        GmapViewController *mapvc = [[GmapViewController alloc]init];
        [self.navigationController pushViewController:mapvc animated:YES];
    }else if (idx == 2)//跳到指南界面
    {
        GongGaoViewController * gongGao = [[GongGaoViewController alloc] init];
        gongGao.html_name = @"guide";
        [self.navigationController pushViewController:gongGao animated:YES];
    }else if (idx == 4)//跳到公告界面
    {
        GongGaoViewController * gongGao = [[GongGaoViewController alloc] init];
        gongGao.html_name = @"index";
        [self.navigationController pushViewController:gongGao animated:YES];
    }else if (idx == 0)//跳转到发表微博界面
    {
        
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        if (!isLogIn)
        {
            LogInViewController * logIn = [LogInViewController sharedManager];
            [self presentViewController:logIn animated:YES completion:NULL];
            return;
        }
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushToWeiBoController) name:@"refreshmydata" object:nil];
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController * pickerC = [[UIImagePickerController alloc] init];
            pickerC.delegate = self;
            pickerC.allowsEditing = NO;
            pickerC.sourceType = sourceType;
            [self presentViewController:pickerC animated:YES completion:nil];
        }
        else
        {
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        }
    }else if (idx == 1)//跳转到问卷调查界面
    {
        fbWebViewController * webView = [[fbWebViewController alloc] init];
        webView.urlstring = @"http://www.wenjuan.com/s/yMJN7z";
        [self.navigationController pushViewController:webView animated:YES];
    }
}
#pragma mark - 关闭
- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
}
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
    awesomeMenu.backgroundColor = [UIColor clearColor];
}
#pragma mark - 打开
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
    
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    awesomeMenu.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}

#pragma mark - 网络测试计时器
-(void)checkTheNetWork
{
    NSString * path = [self returnPath];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
//    {
//        [timer invalidate];
//    }else
//    {
//        NSString * netWork = [Reachability checkNetWork];
//        if (![netWork isEqualToString:@"NONetWork"])
//        {
//            [self loadActivityData];
//        }
//    }
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [user objectForKey:@"gonggaoNewsData"];
    
    NSString * netWork = [Reachability checkNetWork];
    if (![netWork isEqualToString:@"NONetWork"])
    {
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [self loadActivityData];
        }
        
        if ([[dic objectForKey:@"newslist"] isKindOfClass:[NSNull class]])
        {
            [self loadNewsData];
        }
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [timer invalidate];
    }
}

#pragma mark - 读取公告里边的新闻数据
-(void)loadNewsData
{
    NSURL * url = [NSURL URLWithString:@"http://cmsweb.fblife.com/web.php?c=hero2014&a=getappnews&classid=353"];
    
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:url];
    request.timeOutSeconds = 30;
    
    __block typeof(request)wrequest = request;
    
    [wrequest setCompletionBlock:^{
        
        NSDictionary * allDic = [request.responseString objectFromJSONString];
        
        if (![[allDic objectForKey:@"newslist"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:allDic forKey:@"gonggaoNewsData"];
        }
    }];
    
    [wrequest setFailedBlock:^{
        
    }];
    
    [request startAsynchronous];
}

#pragma mark - 获取沙盒plist文件路径
-(NSString *)returnPath
{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"schedueList.plist"];
    return filename;
}

#pragma mark - 获取大会活动日程安排数据
-(void)loadActivityData
{
    NSString *filename=[self returnPath];
    
    NSString * netWork = [Reachability checkNetWork];
    if ([netWork isEqualToString:@"NONetWork"])
    {
        NSFileManager * manager = [NSFileManager defaultManager];
        
        if (![manager fileExistsAtPath:filename])
        {
            NSString * path = [[NSBundle mainBundle] pathForResource:@"TheScheduleList" ofType:@"plist"];
            ///本地活动日程数据
            NSMutableDictionary * localScheduleDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
            [self createLocationNotificationWith:localScheduleDic];
            return;
        }else
        {
            NSString * path = [[NSBundle mainBundle] pathForResource:@"TheScheduleList" ofType:@"plist"];
            ///本地活动日程数据
            NSMutableDictionary * localScheduleDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
            NSMutableDictionary * docDic = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
            [docDic addEntriesFromDictionary:localScheduleDic];
            [self createLocationNotificationWith:docDic];
        }
    }
    
    NSString * fullUrl = @"http://cmsweb.fblife.com/remoteapi/hero2014_app.php";
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    request.timeOutSeconds = 30;
    __block typeof(request) brequest = request;
    __weak typeof(self)bself = self;
    [brequest setCompletionBlock:^{
        if (!my_dictionary)
        {
            my_dictionary = [NSMutableDictionary dictionary];
        }
        
        NSDictionary * allDic = [request.responseString objectFromJSONString];
        if ([[allDic objectForKey:@"isopen"] intValue] == 1)
        {
            NSString * updatetime = [[NSUserDefaults standardUserDefaults] objectForKey:@"updatetime"];
            NSString * now_updatetime = [NSString stringWithFormat:@"%@",[allDic objectForKey:@"updatetime"]];
            
            if (![updatetime isEqualToString:now_updatetime])
            {
                NSDictionary * array = [allDic objectForKey:@"content"];
                if ([array isKindOfClass:[NSDictionary class]])
                {
                    my_dictionary = [NSMutableDictionary dictionaryWithDictionary:[allDic objectForKey:@"content"]];
                    NSString * path = [[NSBundle mainBundle] pathForResource:@"TheScheduleList" ofType:@"plist"];
                    ///本地活动日程数据
                    NSMutableDictionary * localScheduleDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
                    [my_dictionary addEntriesFromDictionary:localScheduleDic];
                    
                    
                    [bself createLocationNotificationWith:my_dictionary];
                }
                
                //输入写入
                [my_dictionary writeToFile:filename atomically:YES];
                
                [[NSUserDefaults standardUserDefaults] setObject:now_updatetime forKey:@"updatetime"];
            }else
            {
                NSFileManager * manager = [NSFileManager defaultManager];
                if (![manager fileExistsAtPath:filename])
                {
                    [my_dictionary writeToFile:filename atomically:YES];
                }
            }
        }
    }];
    
    [brequest setFailedBlock:^{
        
    }];
    
    [request startAsynchronous];
}
#pragma mark - 创建本地推送
-(void)createLocationNotificationWith:(NSMutableDictionary *)scheduleDic
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSArray * allKeys = [scheduleDic allKeys];
    for (int i = 0;i < allKeys.count;i++)
    {
        NSString * aDate = [allKeys objectAtIndex:i];
        NSString * aValue = [scheduleDic objectForKey:aDate];
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        NSLog(@"adate -=-=-   %@",aDate);
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
//                notification.applicationIconBadgeNumber = 1;
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

#pragma mark - 发表微博相关
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - 跳转到微博界面
-(void)PushToWeiBoController
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PushToWeiBoController" object:nil];
    NewWeiBoViewController * weiBoVC = [[NewWeiBoViewController alloc] init];
    weiBoVC.isGoBack = YES;
    [self.navigationController pushViewController:weiBoVC animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * newImage = [zsnApi scaleToSizeWithImage:image1 size:CGSizeMake(720,960)];
    __weak typeof(self) bself = self;
    NSMutableArray * allImageUrl = [NSMutableArray array];
//    NSMutableArray * allAssesters = [NSMutableArray array];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:newImage.CGImage orientation:(ALAssetOrientation)newImage.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error )
     {
         //here is your URL : assetURL
         
         NSString * string = [assetURL absoluteString];
         
         [allImageUrl addObject:string];
         
         [picker dismissViewControllerAnimated:YES completion:^{
             WriteBlogViewController * witeBlog = [[WriteBlogViewController alloc] init];
             witeBlog.myAllimgUrl = allImageUrl;
             witeBlog.theText = @"#2014英雄会#";
             [bself presentViewController:witeBlog animated:YES completion:NULL];
         }];
     }];
}



#pragma mark-跳到fb页面
-(void)ssTurntoFbWebview:(NSNotification*)sender{
    
    
    
    isShowGuangGao=NO;
    fbWebViewController *fbweb=[[fbWebViewController alloc]init];
    fbweb.urlstring=[NSString stringWithFormat:@"%@",[sender.userInfo objectForKey:@"link"]];
    [fbweb viewWillAppear:YES];
    
    [self.navigationController pushViewController:fbweb animated:YES];

    NSLog(@"sender.object===%@",sender.userInfo);


}

#pragma mark--先加广告

-(void)turnToguanggao{
  

//    UIWindow *mywindow=   [[UIApplication sharedApplication]keyWindow];
//    
//    
//    UIView *aview=[[UIView alloc]initWithFrame:mywindow.bounds];
//    
//    aview.backgroundColor=[UIColor whiteColor];
//    
//    [mywindow addSubview:aview];
    
    
    GuanggaoViewController *_guanggaoVC=[[GuanggaoViewController alloc]init];
    [self.navigationController.view addSubview:_guanggaoVC.view];

    [self presentViewController:_guanggaoVC animated:NO completion:NULL];
    

}

#pragma mark-准备uinavigationbar

-(void)prepairNavigationBar{

    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
//        
//               [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
        
        [[UINavigationBar appearance]setShadowImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake(DEVICE_WIDTH, 10)]];
        
    }
    
    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, (44-33/2)/2, 36/2, 33/2)];
    
    [button_back addTarget:self action:@selector(leftDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"homenewz36_33.png"] forState:UIControlStateNormal];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(leftDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    self.navigationItem.leftBarButtonItem=back_item;
    
  UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?37: 25, (44-39/2)/2, 41/2, 39/2)];
    
    
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [button_comment setBackgroundImage:[UIImage imageNamed:@"menewz37_36.png"] forState:UIControlStateNormal];
    
  UIButton *  rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightView addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button_comment];
    rightView.backgroundColor=[UIColor clearColor];
    
    
    
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    self.navigationItem.rightBarButtonItem=comment_item;
//[UIImage imageNamed:@"fblifelogo102_38_.png"];
    
    UIImageView *imgLogo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logonewz113_46.png"]];
    
    self.navigationItem.titleView=imgLogo;



}
-(void)loadView{
    [super loadView];
    




}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    
    NSLog(@"xxxxxxxxxxxxxx===%d",isShowGuangGao);
    
    self.navigationController.navigationBarHidden=isShowGuangGao;
    
    
    
    if (isShowGuangGao) {
        isShowGuangGao=NO;
    }
    
    
    
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:YES];
    
    
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [self isShowAwesomeMenu];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    awesomeMenu.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    

}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:YES];
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
}



#pragma mark-准备幻灯的数据

-(void)loadHuandeng{
    
    __weak typeof(self) wself =self;

    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    NSString *str_search=[NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=newsslide&classname=zuixin&type=json"];
    
    [loaddata SeturlStr:str_search mytest:^(NSDictionary *dicinfo, int errcode) {
        
        
        
        
        
        NSLog(@"新版幻灯的数据dicinfo===%@",dicinfo);
        
        if (errcode==0) {
            
            [wself refreshHuandengWithDic:dicinfo];
            
            
        }else{
        //网络有问题
            
            if (isHaveNetWork) {
                sleep(0.3);
                
                [wself loadHuandeng];
            }
            
           
        
        }
        
    }];
                          
                          
                          
                          
                          
    
    NSLog(@"幻灯的接口是这个。。=%@",str_search);


}

-(void)refreshHuandengWithDic:(NSDictionary *)dic{
    
    
    
    huandengDic=[NSDictionary dictionary];
    huandengDic=dic;
    
   
    
    mainTabView.tableHeaderView= [self getHeaderViewWithDic:huandengDic] ;
    
   // [mainTabView reloadData];



}


#pragma mark-准备下面的数据

-(void)loadNomalData{
    
    
    
    
    __weak typeof(self) wself =self;
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    NSString *str_search=[NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=getappindex&page=%d&type=json&pagesize=10",numberofpage];
    
    [loaddata SeturlStr:str_search mytest:^(NSDictionary *dicinfo, int errcode) {
        
        NSLog(@"新版普通的数据dicinfo===%@",dicinfo);
        
        if (errcode==0) {
            
            [wself refreshNormalWithDic:dicinfo];
            
            
        }else{
            //网络有问题
            if (isHaveNetWork) {
                sleep(0.3);
                [wself loadNomalData];
            }
           
        }
        
    }];
    
    NSLog(@"新版普通的的接口是这个。。=%@",str_search);
    

}

-(void)refreshNormalWithDic:(NSDictionary *)dicc{
    
    [[self.view viewWithTag:234] removeFromSuperview];

    
    
  NSArray *  tempnormalinfoAllArray=[NSArray arrayWithArray:[dicc objectForKey:@"app"]];
     [loadview stopLoading:1];
    if (numberofpage==1) {
        [normalinfoAllArray removeAllObjects];
    }
    
    for (NSDictionary *tsdic in tempnormalinfoAllArray) {
        [normalinfoAllArray addObject:tsdic];
    }
    
    
    if (tempnormalinfoAllArray.count>0&&tempnormalinfoAllArray.count>=10) {
        
        mainTabView.tableFooterView=loadview;
        isloadsuccess=YES;

    }else if(tempnormalinfoAllArray.count<10&&tempnormalinfoAllArray.count>0){
        
        mainTabView.tableFooterView=nomore;
        isloadsuccess=NO;

        
    }else if(tempnormalinfoAllArray.count==0&&normalinfoAllArray.count >0){
        isloadsuccess=NO;

        mainTabView.tableFooterView=nomore;
        
        
    }else if(tempnormalinfoAllArray.count==0&&normalinfoAllArray.count ==0){
        
        NSLog(@"没有数据");
        isloadsuccess=YES;
    }

    
    
    [mainTabView reloadData];



}


#pragma mark-自定义导航栏的代理
-(void)NavigationbuttonWithtag:(int)tag{
    if (tag==100) {
        [self leftDrawerButtonPress];
        
        
    }else{
        [self rightDrawerButtonPress];
    
    }
       }


#pragma mark--幻灯的View

-(UIView *)getHeaderViewWithDic:(NSDictionary*)headerDic {
    
    
    
    NSLog(@"最新的幻灯的数据===%@",huandengDic);
    
    
    /**
     *   id = 119049;
     link = "http://drive.fblife.com/html/20140722/119049.html";
     photo = "http://cmsweb.fblife.com/attachments/20140722/14060219878454.gif";
     stitle = "2015\U6b3e\U798f\U7279\U5f81\U670d\U8005\U524d\U77bb";
     title = "\U7f8e\U5f0f\U5168\U5c3a\U5bf8SUV 2015\U6b3e\U798f\U7279\U5f81\U670d\U8005\U524d\U77bb";
     type = 1;

     */
    
    
    com_id_array=[NSMutableArray array];
    com_link_array=[NSMutableArray array];
    com_type_array=[NSMutableArray array];
    com_title_array=[NSMutableArray array];
    

    
    self.commentarray=[NSMutableArray arrayWithArray:[headerDic objectForKey:@"news"]];
    
    if (self.commentarray.count>0) {
        NSMutableArray *imgarray=[NSMutableArray array];
        
        for ( int i=0; i<[self.commentarray count]; i++) {
            
            NSDictionary *dic_ofcomment=[self.commentarray objectAtIndex:i];
            NSString *strimg=[dic_ofcomment objectForKey:@"photo"];
            [imgarray addObject:strimg];
            
            
            NSString *str_rec_title=[dic_ofcomment objectForKey:@"title"];
            [com_title_array addObject:str_rec_title];
            /*           id = 82920;
             link = "http://drive.fblife.com/html/20131226/82920.html";
             photo = "http://cmsweb.fblife.com/attachments/20131226/1388027183.jpg";
             title = "\U57ce\U5e02\U8de8\U754c\U5148\U950b \U6807\U81f42008\U8bd5\U9a7e\U4f53\U9a8c";
             type = 1;*/
            
            NSString *str_link=[dic_ofcomment objectForKey:@"link"];
            [com_link_array addObject:str_link];
            NSString *str_type=[dic_ofcomment objectForKey:@"type"];
            [com_type_array addObject:str_type];
            NSString *str__id=[dic_ofcomment objectForKey:@"id"];
            [com_id_array addObject:str__id];
            
            
        }
        int length = self.commentarray.count;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0 ; i < length; i++)
        {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSString stringWithFormat:@"%@",[com_title_array objectAtIndex:i]],@"title" ,
                                  [NSString stringWithFormat:@"%@",[imgarray objectAtIndex:i]],@"image",[NSString stringWithFormat:@"%@",[com_link_array objectAtIndex:i]],@"link",
                                  [NSString stringWithFormat:@"%@",[com_type_array objectAtIndex:i]],@"type",[NSString stringWithFormat:@"%@",[com_id_array objectAtIndex:i]],@"idoftype",nil];
            [tempArray addObject:dict];
        }
        
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
        if (length > 1)
        {
            NSDictionary *dict = [tempArray objectAtIndex:length-1];
            SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1] ;
            [itemArray addObject:item];
        }
        for (int i = 0; i < length; i++)
        {
            NSDictionary *dict = [tempArray objectAtIndex:i];
            SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i] ;
            [itemArray addObject:item];
            
        }
        //添加第一张图 用于循环
        if (length >1)
        {
            NSDictionary *dict = [tempArray objectAtIndex:0];
            SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:length];
            [itemArray addObject:item];
        }
        bannerView = [[NewHuandengView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, (191+13)*DEVICE_WIDTH/320) delegate:self imageItems:itemArray isAuto:YES];
        [bannerView scrollToIndex:0];
        
 
        
    }
    
    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, (191+13)*DEVICE_WIDTH/320+64)];
    HeaderView.backgroundColor=[UIColor whiteColor];
    [HeaderView addSubview:bannerView];
    
    return bannerView;
    
}

#pragma mark-SGFocusImageItem的代理
- (void)testfoucusImageFrame:(NewHuandengView *)imageFrame didSelectItem:(SGFocusImageItem *)item
{





    NSLog(@"%s \n click===>%@",__FUNCTION__,item.title);


    if (com_id_array.count>0) {

        int type;
        NSString *string_link_;
        @try {
            type=[item.type intValue];
            
            
            
            
            NSLog(@"item.type====%d",type);
            
            

            string_link_=item.link;

        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
            return;

        }@finally {
            switch (type) {
                    
                    
                    
                case 1:
                {

                    NSLog(@"到新闻的");
                    
                    newsdetailViewController *_newsdetailVC=[[newsdetailViewController alloc]initWithID:item.idoftype];
                    
                    [self.navigationController pushViewController:_newsdetailVC animated:YES];
                
                    

                }
                    break;

                case 2:{
                    NSLog(@"到论坛的");
                    bbsdetailViewController *_detaibbslVC=[[bbsdetailViewController alloc]init];
                    
                    _detaibbslVC.bbsdetail_tid=item.idoftype;
                    
                    [self.navigationController pushViewController:_detaibbslVC animated:YES];
                    

                }
                    break;
                case 3:{

                    fbWebViewController *_fbVc=[[fbWebViewController alloc]init];\
                    
                    _fbVc.urlstring=item.link;
                    
                    [self.navigationController pushViewController:_fbVc animated:YES];
                    
                    NSLog(@"外链的");

                }

                default:
                    break;
            }


        }



    }

}

-(void)testfoucusImageFrame:(NewHuandengView *)imageFrame currentItem:(int)index{
    
//    NSLog(@"index===%d",index);
    

}

#pragma mark-uitableviewdelegate datasource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return normalinfoAllArray.count;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 1;
    
    /**
     * 1.幻灯，2,推的文章。3图集。4不清楚啊
     */

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    
        NSDictionary *dictemp=[normalinfoAllArray objectAtIndex:indexPath.row];
        
        if ([[dictemp objectForKey:@"type"] integerValue]==2) {
            
            static NSString *stringnormalidentifier=@"normal";
            
            CompreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stringnormalidentifier];

            
            if (!cell) {
                cell=[[CompreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringnormalidentifier type:CompreTableViewCellStyleText];
            }

            __weak typeof(self) wself=self;
            
            [cell normalsetDic:dictemp cellStyle:CompreTableViewCellStylePictures thecellbloc:^(NSString *thebuttontype,NSDictionary *dic,NSString * theWhateverid) {
                
                
                
                
                [wself turntoOtherVCwithtype:thebuttontype thedic:dic theid:theWhateverid];
            }];
            
            UIView *selectback=[[UIView alloc]initWithFrame:cell.frame];
            selectback.backgroundColor=RGBCOLOR(242, 242, 242);
            cell.selectedBackgroundView=selectback;
            return cell;

            
        }else{
            
            
            static NSString *stringnormalidentifiers=@"normaltext";
            
            CompreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stringnormalidentifiers];
            

            if (!cell) {
                cell=[[CompreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringnormalidentifiers type:CompreTableViewCellStyleText];
            }

            
            
            __weak typeof(self) wself=self;

            
            [cell normalsetDic:dictemp cellStyle:CompreTableViewCellStyleText thecellbloc:^(NSString *thebuttontype,NSDictionary *dic,NSString * theWhateverid) {
                
                
                [wself turntoOtherVCwithtype:thebuttontype thedic:dic theid:theWhateverid];

                
            }];
        
            
            
            UIView *selectback=[[UIView alloc]initWithFrame:cell.frame];
            selectback.backgroundColor=RGBCOLOR(242, 242, 242);
            cell.selectedBackgroundView=selectback;
            

            return cell;

        }
        
    }
 
//}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    NSDictionary *temPnormalDic=[normalinfoAllArray objectAtIndex:indexPath.row];
    
    NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
    [_newmodel NewMainViewModelSetdic:temPnormalDic];
    
    

    switch ([[temPnormalDic objectForKey:@"type"] integerValue]) {
            
            //（1新闻，2图集，3论坛，4商城)
        case 1:
        {
            newsdetailViewController *_newsdetailVC=[[newsdetailViewController alloc]initWithID:_newmodel.tid];
            
            [self.navigationController pushViewController:_newsdetailVC animated:YES];
            
            
            
        
        }
            break;
        case 2:
        {
            NSLog(@"和少男对接");
            
            ShowImagesViewController * showImages = [[ShowImagesViewController alloc] init];
            
            showImages.id_atlas = _newmodel.tid;
            
            showImages.currentPage = 0;
            
            [self.navigationController pushViewController:showImages animated:YES];
            
            
        }
            break;
        case 3:
        {
            NSLog(@"到论坛的");
            bbsdetailViewController *_detaibbslVC=[[bbsdetailViewController alloc]init];
            
            _detaibbslVC.bbsdetail_tid=_newmodel.tid;
            
            [self.navigationController pushViewController:_detaibbslVC animated:YES];
            
        }
            break;
        case 4:
        {
            
        }
            break;
            
            
        default:
            break;
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
        
        
        NSDictionary *temPnormalDic=[normalinfoAllArray objectAtIndex:indexPath.row];

        
            
            
            
            if ([[temPnormalDic objectForKey:@"type"] integerValue]==2) {
                return    [CompreTableViewCell getHeightwithtype:CompreTableViewCellStylePictures];
                
                
                
            }else{
                
                return    [CompreTableViewCell getHeightwithtype:CompreTableViewCellStyleText];
                
            }
            
            

}

//NSString *thebuttontype,NSDictionary *dic,NSString * theWhateverid





#pragma mark--处理各种跳转

-(void)turntoOtherVCwithtype:(NSString *)thebuttontype thedic:(NSDictionary *)mydic theid:(NSString *)theWhateverid{
    //（1新闻，2图集，3论坛，4商城
    
    NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
    [_newmodel NewMainViewModelSetdic:mydic];
    
    if ([thebuttontype isEqualToString:@"big"]) {
        //点击的是大的button
        
        switch ([_newmodel.type intValue]) {
            case 1:
            {
                
                RootViewController *rootV=[[RootViewController alloc]init];
                
                [self.navigationController pushViewController:rootV animated:YES];
                
                
            }
                break;
            case 2:
            {
                PicShowViewController *TestVC=[[PicShowViewController alloc]init];
                
                
                [self.navigationController pushViewController:TestVC animated:YES];
                
                
            }
                break;
            case 3:
            {
                SliderBBSViewController *_bbsVC=[SliderBBSViewController shareManager];
                
                _bbsVC.seg_current_page = 1;
                
                [self.navigationController pushViewController:_bbsVC animated:YES];
                
            }
                break;
            case 4:
            {
                
                
                
            }
                break;
                
            default:
                break;
        }
        
        
        
        
    }else if([thebuttontype isEqualToString:@"small"]) {
    
    
    
        switch ([_newmodel.type intValue]) {
            case 1:
            {
                
                RootViewController *rootV=[[RootViewController alloc]init];
                rootV.str_dijige=_newmodel.shownum;
                
                
                
                NSLog(@"self.diji===%@",rootV.str_dijige);

                [self.navigationController pushViewController:rootV animated:YES];
                
                
                
                
                
                
            }
                break;
            case 2:
            {
                PicShowViewController *TestVC=[[PicShowViewController alloc]init];
                
                
                [self.navigationController pushViewController:TestVC animated:YES];
                
                
            }
                break;
            case 3:
            {
                BBSfenduiViewController *_bbsVC=[[BBSfenduiViewController alloc]init];\
                
                _bbsVC.string_id=_newmodel.bbsfid;
                
                [self.navigationController pushViewController:_bbsVC animated:YES];
            }
                break;
            case 4:
            {
                
                
                
            }
                break;
                
            default:
                break;
        }
        
        

    
    
    
    }
    
    
 
 
    
    
    

    
 //   NSLog(@"xxxx==%@",mydic);
//    


}


#pragma mark - Button Handlers
-(void)leftDrawerButtonPress{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

   [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    
  }



#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mainTabView];
    
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    
    
    
	
    //	[self refreshwithrag:self.tag];
    //    [self.delegate refreshmydatawithtag:self.tag];
    numberofpage=1;

    [self loadNomalData];
    [self loadHuandeng];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //要判断当前是哪一个，有mainTabView/imagesc/twoscrow/sec2
    if (scrollView==mainTabView) {
        
      //  NSLog(@"table.y===%f",mainTabView.contentOffset.y);
        
   
        
        
        
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
        if(mainTabView.contentOffset.y > (mainTabView.contentSize.height - mainTabView.frame.size.height+40)&&isloadsuccess==YES&&normalinfoAllArray.count>=10) {
            
            
            [loadview startLoading];
            numberofpage++;
            isloadsuccess=!isloadsuccess;
            [self loadNomalData];
        }
        
    }
    
    
    
    
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
	return [NSDate date]; // should return date data source was last changed
}



#pragma mark - dealloc


-(void)dealloc
{
    
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
