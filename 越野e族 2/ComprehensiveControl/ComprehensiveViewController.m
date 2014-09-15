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

///浮动层开始显示的时间
#define SHOW_TIME @"2014-09-11 19:10:00"
///浮动层消失的时间
#define HIDDEN_TIME @"2014-10-10 19:10:00"



@interface ComprehensiveViewController (){

    UIBarButtonItem * spaceButton;
    
    NSMutableArray *com_id_array;//幻灯的id
    NSMutableArray *com_type_array;//幻灯的type
    NSMutableArray *com_link_array;//幻灯的外链
    NSMutableArray *com_title_array;//幻灯的标题

    AwesomeMenu * awesomeMenu;
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




- (void)viewDidLoad
{
    [super viewDidLoad];
    

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
    
    

    
    
    
    
    [self turnToguanggao];

    
    self.view.backgroundColor=[UIColor whiteColor];
    
    huandengDic=[NSDictionary dictionary];
    
    [self loadHuandeng];
    [self loadNomalData];
    
    
    
    [self isShowAwesomeMenu];
}

#pragma mark-从广告页面回来刷新一下

-(void)jiaSshuaxin{
    
    
    
    
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


#pragma mark - 判断是否显示浮动框
-(void)isShowAwesomeMenu
{
    
    
    
    
    NSDate * now = [NSDate date];
    NSDate * begin_time = [zsnApi dateFromString:SHOW_TIME];
    NSDate * end_time = [zsnApi dateFromString:HIDDEN_TIME];
    
    
    if ([now timeIntervalSinceDate:begin_time] > 0 && [now timeIntervalSinceDate:end_time]<0)
    {
        UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
        UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
        UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
        
        AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        
        NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, nil];
        
        AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                               ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                    highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
        
        awesomeMenu = [[AwesomeMenu alloc] initWithFrame:self.navigationController.view.bounds startItem:startItem optionMenus:menus];
        awesomeMenu.delegate = self;
        
        awesomeMenu.menuWholeAngle = -M_PI_2;
        awesomeMenu.farRadius = 110.0f;
        awesomeMenu.endRadius = 100.0f;
        awesomeMenu.nearRadius = 90.0f;
        awesomeMenu.animationDuration = 0.4f;
        awesomeMenu.startPoint = CGPointMake(280,iPhone5?500.0:412.0);
        [self.navigationController.view addSubview:awesomeMenu];
    }
}


#pragma mark - AWeSomeMenuDelegate
#pragma mark - 点击的第几个
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    if (idx == 4) {//跳转到离线地图
        //添加离线地图包资源 并显示地图
        GmapViewController *mapvc = [[GmapViewController alloc]init];
        [self.navigationController pushViewController:mapvc animated:YES];
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


#pragma mark-跳到fb页面
-(void)ssTurntoFbWebview:(NSNotification*)sender{
    
    
    
    
    
    fbWebViewController *fbweb=[[fbWebViewController alloc]init];
    fbweb.urlstring=[NSString stringWithFormat:@"%@",[sender.userInfo objectForKey:@"link"]];
    [fbweb viewWillAppear:YES];
    
    [self.navigationController pushViewController:fbweb animated:YES];

    NSLog(@"sender.object===%@",sender.userInfo);


}

#pragma mark--先加广告

-(void)turnToguanggao{


    GuanggaoViewController *_guanggaoVC=[[GuanggaoViewController alloc]init];
    [[UIApplication sharedApplication] setStatusBarHidden:NO ];

    [self presentViewController:_guanggaoVC animated:NO completion:NULL];

}

#pragma mark-准备uinavigationbar

-(void)prepairNavigationBar{

    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
//        
//               [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
        
        [[UINavigationBar appearance]setShadowImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 10)]];
        
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
    
    nomore=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    nomore.text=@"没有更多数据";
    nomore.textAlignment=NSTextAlignmentCenter;
    nomore.font=[UIFont systemFontOfSize:13];
    nomore.textColor=[UIColor lightGrayColor];
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, 320, 40)];
    loadview.backgroundColor=[UIColor clearColor];

    
    mainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64)];
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
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-mainTabView.bounds.size.height, 320, mainTabView.bounds.size.height)];
        view.delegate = self;
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    [mainTabView addSubview:_refreshHeaderView];
    
    



}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:YES];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
//    self.navigationController.navigationBarHidden=YES;
    awesomeMenu.hidden = NO;
    [awesomeMenu setBackgroundColor:[UIColor clearColor]];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    awesomeMenu.hidden = YES;
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
        bannerView = [[NewHuandengView alloc] initWithFrame:CGRectMake(0, 64, 320, 191+13) delegate:self imageItems:itemArray isAuto:YES];
        [bannerView scrollToIndex:0];
        
 
        
    }
    
    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 191+13+64)];
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
