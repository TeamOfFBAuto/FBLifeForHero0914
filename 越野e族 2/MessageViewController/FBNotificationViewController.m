//
//  FBNotificationViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-8-20.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import "FBNotificationViewController.h"
#import "NSString+JSMessagesView.h"
#import "UIView+AnimationOptionsForCurve.h"
#import "UIColor+JSMessagesView.h"
#import "MyChatViewCell.h"
#import "NewWeiBoDetailViewController.h"
#import "guanzhuViewController.h"
#import "NewMineViewController.h"
#import "WenJiViewController.h"
#import "ImagesViewController.h"
#import "bbsdetailViewController.h"

#define u_read_url @"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertlist&fromtype=b5eeec0b&authkey=%@&page=%d&numpage=20&fbtype=json"

#define read_url @"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertlistread&fromtype=b5eeec0b&authkey=%@&page=%d&numpage=20&fbtype=json"


@interface FBNotificationViewController ()

@end

@implementation FBNotificationViewController
@synthesize read_array = _read_array;
@synthesize uread_array = _uread_array;
@synthesize read_page = _read_page;
@synthesize uRead_page = _uRead_page;
@synthesize loadingView = _loadingView;
@synthesize myScrollView = _myScrollView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    isbbs=NO;
    bbs_array=[NSArray array];
    bbs_page=1;
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(248,248,248);
    
    _read_array = [[NSMutableArray alloc] init];
    
    _uread_array = [[NSMutableArray alloc] init];
    
    _read_page = 1;
    
    _uRead_page = 1;
    
    
//    self.navigationItem.title = @"系统通知";
//    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
//    _slsV=[[SliderSegmentView alloc]initWithFrame:CGRectMake(0,0,150,44)];
//    _slsV.delegate=self;
//    [_slsV NewloadContent:[NSArray arrayWithObjects:@"FB通知",@"论坛通知",nil]];
//    
//    UIView *view_title=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 170, 44)];
//    view_title.backgroundColor=[UIColor clearColor];
//    [view_title addSubview:_slsV];
//    self.navigationItem.titleView=_slsV;
    
    //        _slsV.backgroundColor=[UIColor orangeColor];
    
    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10, 8, 12, 21.5)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back.png"] forState:UIControlStateNormal];
//    
//    
//    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    space.width = MY_MACRO_NAME?-4:5;
//    
//    
//    
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    
//    self.navigationItem.leftBarButtonItems=@[space,back_item];
        
        
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    seg_view = [[SliderBBSTitleView alloc] initWithFrame:CGRectMake(0,0,190,44)];

    
    __weak typeof(self) bself = self;
    
    [seg_view setAllViewsWith:[NSArray arrayWithObjects:@"FB通知",@"论坛通知",nil] withBlock:^(int index) {
        
        [bself.myScrollView setContentOffset:CGPointMake(340*index,0) animated:YES];
        
    }];
    
    self.navigationItem.titleView = seg_view;
    
    
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,340, iPhone5?568-44-25:480-44-25)];
    
    _myScrollView.showsHorizontalScrollIndicator = NO;
    
    _myScrollView.showsVerticalScrollIndicator = NO;
    
    _myScrollView.delegate = self;
    
    _myScrollView.pagingEnabled = YES;
    
    _myScrollView.contentSize = CGSizeMake(680,0);
    
    [self.view addSubview:_myScrollView];
    
    
    
    
    fbnoti_tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-44-25:480-44-25)];
    
    fbnoti_tab.backgroundColor=RGBCOLOR(248,248,248);
    
    fbnoti_tab.delegate=self;
    
    fbnoti_tab.dataSource=self;
    
    fbnoti_tab.separatorColor=[UIColor clearColor];
    
    [_myScrollView addSubview:fbnoti_tab];
    
    
    bbs_tab=[[UITableView alloc]initWithFrame:CGRectMake(340, 0, 320, iPhone5?568-44-25:480-44-25)];
    
    bbs_tab.backgroundColor=RGBCOLOR(248,248,248);
    
    bbs_tab.delegate=self;
    
    bbs_tab.dataSource=self;
    
    bbs_tab.separatorColor=[UIColor clearColor];
    
    [_myScrollView addSubview:bbs_tab];
    
    
    if (!_loadingView)
    {
        _loadingView = [[LoadingIndicatorView alloc] initWithFrame:CGRectMake(0, 900, 320, 40)];
        
        fbnoti_tab.tableFooterView = _loadingView;
    }
    
    
    infoofnotification=[[NotificationInfo alloc]init];
    
    infoofnotification.delegate=self;
    
    if (!_isloadingIv)
    {
        _isloadingIv=[[loadingimview alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"正在加载"];
    }
    
    [[UIApplication sharedApplication].keyWindow
     addSubview:_isloadingIv];
    
    _isloadingIv.hidden=NO;
    
    [infoofnotification startloadnotificationwithpage:_read_page pagenumber:@"20" withUrl:read_url];
    
    
    [self Loadbbsdatawithpage:bbs_page];

	// Do any additional setup after loading the view.
}


#pragma mark-选择看论坛的通知还是自留地的通知
-(void)searchreaultbythetype:(NSString *)type{
    
    if ([type isEqualToString:@"bk"]) {
        isbbs=NO;
        NSLog(@"点击的是FB的通知");
        self.view=fbnoti_tab;
        
        
    }else{
        isbbs=YES;
        self.view=bbs_tab;
        
        NSLog(@"点击的是论坛的通知");

    }
    
}

#pragma mark-获取bbs的数据

-(void)Loadbbsdatawithpage:(int)pagesofbbs
{
    if (pagesofbbs==1) {
    }
    
    
    NSString *string_authcode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    if (string_authcode.length!=0) {
        NSString *string_updatetoken=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/msgnotice.php?authcode=%@&type=0&page=%d&formattype=json",string_authcode,pagesofbbs ];
        
        NSLog(@"???????????????????????????=string_updatepushtoken==%@",string_updatetoken);
        ASIHTTPRequest *   request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:string_updatetoken]];
        
        __block ASIHTTPRequest * _requset = request;
        
        _requset.delegate = self;
        
        [_requset setCompletionBlock:^{
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            /**
             *   "bbsinfo": [
             {
             "tid": "3161951",
             "page": "2",
             "dateline": "02-19 11:28:27",
             "type": "1",
             "authorimg": "http://avatar.fblife.com/000/24/31/14_avatar_small.jpg",
             "message": "越野大笨牛回复了您的帖子，去看看"
             },
             */
            @try {
                
                
                NSLog(@"bbs通知列表通知===%@",dic);
                
                
                bbs_array=[dic objectForKey:@"bbsinfo"];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                if (bbs_array.count>0) {
                    [bbs_tab reloadData];
                }
                
            }
            
            
            
        }];
        
        [_requset setFailedBlock:^{
            
            
            [request cancel];
            
        }];
        
        [_requset startAsynchronous];
        
    }
    
    

}

/**
 *
 *
 *  @param  <# description#>
 *
 *  @return <#return value description#>
 */
#pragma mark-tableview的代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==fbnoti_tab) {
        if (_uread_array.count > 0)
        {
            if (uReadOver)
            {
                return 2;
            }else
            {
                return 1;
            }
        }else
        {
            return 1;
        }

    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==fbnoti_tab) {
        if (section == 0)
        {
            if (_uread_array.count > 0)
            {
                return _uread_array.count;
            }else
            {
                return _read_array.count;
            }
        }else
        {
            return _read_array.count;
        }

    }else{
        return bbs_array.count;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==bbs_tab) {
        return 0;
    }else{
        return 24;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==bbs_tab) {
        return nil;
    }else{
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 24)];
        label.backgroundColor=RGBCOLOR(240, 240, 240);
        [label setFont:[UIFont systemFontOfSize:15]];
        
        label.textColor=[UIColor blackColor];
        
        if (section == 0)
        {
            if (_uread_array.count > 0)
            {
                label.text= @"  未读通知";
            }else
            {
                label.text= @"  已读通知";
            }
        }else
        {
            label.text= @"  已读通知";
        }
        
        return label;

    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stringcell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stringcell];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell];
    }else
    {
        for (UIView *view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    NSDictionary *dic;
    
    if (tableView==fbnoti_tab) {
        if (indexPath.section == 0)
        {
            if (_uread_array.count > 0)
            {
                dic = [_uread_array objectAtIndex:indexPath.row];
            }else
            {
                dic = [_read_array objectAtIndex:indexPath.row];
            }
        }else
        {
            dic = [_read_array objectAtIndex:indexPath.row];
        }
        
        
        
        timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,5,120,16)];
        
        timestampLabel.textAlignment = NSTextAlignmentCenter;
        
        timestampLabel.backgroundColor = [UIColor clearColor];
        
        timestampLabel.layer.cornerRadius = 8;
        
        timestampLabel.font=[UIFont systemFontOfSize:13];
        
        timestampLabel.backgroundColor = RGBCOLOR(245,245,245);
        
        timestampLabel.textAlignment = NSTextAlignmentCenter;
        
        timestampLabel.textColor = RGBCOLOR(125,123,124);
        timestampLabel.text=[zsnApi timechange1:[NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]]];
        [cell.contentView addSubview:timestampLabel];
        
        _headImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(5,30,40,40)];
        
        [_headImageView loadImageFromURL:[NSString stringWithFormat:@"%@",[dic objectForKey:@"face_original"]] withPlaceholdImage:[UIImage imageNamed:@"touxiang"]];
        [cell.contentView addSubview:_headImageView];
        
        labelcontent=[[UILabel alloc]init];
        
        NSString *string_contenttext=[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        labelcontent.text=string_contenttext;
        labelcontent.numberOfLines=0;
        labelcontent.font=[UIFont systemFontOfSize:17];
        CGSize constraintSize = CGSizeMake(220, MAXFLOAT);
        CGSize labelSize = [string_contenttext sizeWithFont:labelcontent.font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        labelcontent.frame=CGRectMake(67, 38, 220, labelSize.height);
        labelcontent.backgroundColor=[UIColor clearColor];
        labelcontent.textColor=RGBCOLOR(24,24,24);
        
        
        _background_imageView = [[UIImageView alloc] init];
        
        _background_imageView.userInteractionEnabled = YES;
        
        UIImage *image=[UIImage imageNamed:@"talk2.png"];
        
        _background_imageView.image = [image stretchableImageWithLeftCapWidth:22.f topCapHeight:22.f];
        
        _background_imageView.frame=CGRectMake(52, 33, 240, labelSize.height+10);
        
        [cell.contentView addSubview:_background_imageView];
        [cell.contentView addSubview:labelcontent];
        

    }else{
        
        NSLog(@"bbsarray===%@",bbs_array);
        
        
        
        dic=[bbs_array objectAtIndex:indexPath.row];
        
        NSLog(@"dic====%@",dic);
        
        /**
         *   "bbsinfo": [
         {
         "tid": "3161951",
         "page": "2",
         "dateline": "02-19 11:28:27",
         "type": "1",
         "authorimg": "http://avatar.fblife.com/000/24/31/14_avatar_small.jpg",
         "message": "越野大笨牛回复了您的帖子，去看看"
         },
         */

        timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,5,120,16)];
        
        timestampLabel.textAlignment = NSTextAlignmentCenter;
        
        timestampLabel.backgroundColor = [UIColor clearColor];
        
        timestampLabel.layer.cornerRadius = 8;
        
        timestampLabel.font=[UIFont systemFontOfSize:13];
        
        timestampLabel.backgroundColor = RGBCOLOR(245,245,245);
        
        timestampLabel.textAlignment = NSTextAlignmentCenter;
        
        timestampLabel.textColor = RGBCOLOR(125,123,124);
        timestampLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateline"]];
        [cell.contentView addSubview:timestampLabel];
        
        _headImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(5,30,40,40)];
        
        [_headImageView loadImageFromURL:[NSString stringWithFormat:@"%@",[dic objectForKey:@"authorimg"]] withPlaceholdImage:[UIImage imageNamed:@"touxiang.png"]];
        [cell.contentView addSubview:_headImageView];
        
        labelcontent=[[UILabel alloc]init];
        
        NSString *string_contenttext=[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]];
        labelcontent.text=string_contenttext;
        labelcontent.numberOfLines=0;
        labelcontent.font=[UIFont systemFontOfSize:17];
        CGSize constraintSize = CGSizeMake(220, MAXFLOAT);
        CGSize labelSize = [string_contenttext sizeWithFont:labelcontent.font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        labelcontent.frame=CGRectMake(67, 38, 220, labelSize.height);
        labelcontent.backgroundColor=[UIColor clearColor];
        labelcontent.textColor=RGBCOLOR(24,24,24);
        
        
        _background_imageView = [[UIImageView alloc] init];
        
        _background_imageView.userInteractionEnabled = YES;
        
        UIImage *image=[UIImage imageNamed:@"talk2.png"];
        
        _background_imageView.image = [image stretchableImageWithLeftCapWidth:22.f topCapHeight:22.f];
        
        _background_imageView.frame=CGRectMake(52, 33, 240, labelSize.height+10);
        
        [cell.contentView addSubview:_background_imageView];
        [cell.contentView addSubview:labelcontent];
        
    }
    
    cell.backgroundColor = RGBCOLOR(248,248,248);
    
    cell.contentView.backgroundColor = RGBCOLOR(248,248,248);
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic;
    
    
    if (tableView==fbnoti_tab) {
        if (indexPath.section == 0)
        {
            if (_uread_array.count>0)
            {
                dic=[_uread_array objectAtIndex:indexPath.row];
            }else
            {
                dic=[_read_array objectAtIndex:indexPath.row];
            }
        }else
        {
            dic=[_read_array objectAtIndex:indexPath.row];
        }
        
        
        int type=[[NSString stringWithFormat:@"%@",[dic objectForKey:@"oatype"]] intValue];
        
        NSString *string_tid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"actid"]];
        
        if (type==2 || type==7)
        {//文集
            
            WenJiViewController * wenji = [[WenJiViewController alloc] init];
            
            wenji.bId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            
            [self.navigationController pushViewController:wenji animated:YES];
            
        }else if (type==3)
        {//画廊
            
            ImagesViewController * images = [[ImagesViewController alloc] init];
            
            images.tid = string_tid;
            
            [self.navigationController pushViewController:images animated:YES];
            
        }else if (type==4||type==5)
        {//微博
            
            NewWeiBoDetailViewController *detail=[[NewWeiBoDetailViewController alloc]init];
            
            FbFeed * obj = [[FbFeed alloc]init];
            
            obj.tid = string_tid;
            
            NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
            NSString * fullURL= [NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=weibocomment&tid=%@&fromtype=b5eeec0b&authkey=%@&page=1&fbtype=json",string_tid,authkey];
            
            
            NSLog(@"1请求的url = %@",fullURL);
            ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
            
            __block ASIHTTPRequest * _requset = request;
            
            _requset.delegate = self;
            
            [_requset setCompletionBlock:^{
                
                @try {
                    NSDictionary * dic = [request.responseData objectFromJSONData];
                    NSLog(@"个人信息 -=-=  %@",dic);
                    
                    
                    if ([[dic objectForKey:@"weibomain"] isEqual:[NSNull null]] || [[dic objectForKey:@"weibomain"] isEqual:@"<null>"])
                    {
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该篇微博不存在" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                        [alert show];
                        
                        return;
                    }
                    
                    
                    NSDictionary * value = [dic objectForKey:@"weibomain"];
                    
                    
                    if ([[dic objectForKey:@"errcode"] intValue] ==0)
                    {
                        //解析微博内容
                        [obj setTid:[value objectForKey:FB_TID]];
                        [obj setUid:[value objectForKey:FB_UID]];
                        [obj setUserName:[value objectForKey:FB_USERNAME]];
                        [obj setContent: [zsnApi imgreplace:[value objectForKey:FB_CONTENT]]];
                        
                        if ([[value objectForKey:FB_IMAGEID] isEqualToString:@"0"])
                        {
                            [obj setNsImageFlg:@"0"];
                        }else
                        {
                            [obj setNsImageFlg:@"1"];
                        }
                        
                        
                        obj.image_original_url_m = [value objectForKey:@"image_original_m"];
                        
                        obj.image_small_url_m = [value objectForKey:@"image_small_m"];
                        
                        //                [obj setImage_original_url_m:[value objectForKey:@"image_original_m"]];
                        
                        //                [obj setImage_small_url_m:[value objectForKey:@"image_small_m"]];
                        
                        //是否有图片
                        if ([obj imageFlg])
                        {
                            [obj setImage_original_url:[value objectForKey:FB_IMAGE_ORIGINAL]];
                            [obj setImage_small_url:[value objectForKey:FB_IMAGE_SMALL]];
                        }
                        
                        [obj setFrom:[zsnApi exchangeFrom:[value objectForKey:FB_FROM]]];
                        [obj setNsType:[value objectForKey:FB_TYPE]];
                        obj.sort = [value objectForKey:FB_SORT];
                        obj.sortId = [value objectForKey:FB_SORTID];
                        [obj setJing_lng:[value objectForKey:FB_JING_LNG]];
                        [obj setWei_lat:[value objectForKey:FB_WEI_LAT]];
                        [obj setLocality:[value objectForKey:FB_LOCALITY]];
                        [obj setFace_original_url:[value objectForKey:FB_FACE_ORIGINAL]];
                        [obj setFace_small_url:[value objectForKey:FB_FACE_SMALL]];
                        [obj setNsRootFlg:[value objectForKey:FB_ROOTTID]];
                        [obj setDateline:[value objectForKey:FB_DATELINE]];//[personal timestamp:[value objectForKey:FB_DATELINE]]];
                        [obj setReplys:[value objectForKey:FB_REPLYS]];
                        [obj setForwards:[value objectForKey:FB_FORWARDS]];
                        [obj setRootFlg:NO];
                        
                        //解析其他类型
                        
                        if (([obj.sort isEqualToString:@"6"] || [obj.sort isEqualToString:@"7"])&&[obj.type isEqualToString:@"first"])
                        {
                            //解析新闻评论
                            NSDictionary *exjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                            
                            Extension * ex=[[Extension alloc]initWithJson:exjson];
                            
                            [obj setExten:ex];
                            
                            [obj setContent:[NSString stringWithFormat:@"我对新闻<a href=\"fb.news://PhotoDetail/id=%@/sort=%@\">%@</a>发表了评论:%@",obj.sortId,obj.sort,ex.title,obj.content]];
                            
                            
                        }else if([obj.sort isEqualToString:@"3"]&&[obj.type isEqualToString:@"first"])
                        {
                            //解析图集
                            NSDictionary *photojson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
                            
                            PhotoFeed * photo=[[PhotoFeed alloc]initWithJson:photojson];
                            
                            [obj setPhoto:photo];
                            
                            [obj setContent:[NSString stringWithFormat:@"我在图集<a href=\"fb://PhotoDetail/%@\">%@</a>上传了新图片",photo.aid,photo.title]];
                            
                            [obj setImageFlg:YES];
                            
                            [obj setImage_small_url_m: photo.image_string];
                            
                            [obj setImage_original_url_m:photo.image_string];
                            
                        }else if([obj.sort isEqualToString:@"2"]&&[obj.type isEqualToString:@"first"])
                        {
                            //解析文集
                            NSDictionary *blogjson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
                            
                            BlogFeed * blog=[[BlogFeed alloc]initWithJson:blogjson];
                            
                            [obj setBlog:blog];
                            
                            //   href=\"fb://BlogDetail/%@\"
                            [obj setContent:[NSString stringWithFormat:@"我发表文集<a href=\"fb://BlogDetail/%@\">%@</a>:%@",blog.blogid,blog.title,blog.content]];
                            
                            [obj setImageFlg:blog.photoFlg];
                            
                            if (blog.photoFlg)
                            {
                                [obj setImage_small_url_m:blog.photo];
                                [obj setImage_original_url_m:blog.photo];
                            }
                            
                            
                        }else if([obj.sort isEqualToString:@"4"]&&[obj.type isEqualToString:@"first"])
                        {
                            //论坛帖子转发为微博
                            NSDictionary * newsForwoadjson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
                            
                            FbNewsFeed * fbnews= [[FbNewsFeed alloc] initWithJson:newsForwoadjson];
                            
                            [obj setFbNews:fbnews];
                            
                            [obj setContent:[NSString stringWithFormat:@"转发论坛帖子<a href=\"fb://tieziDetail/%@/%@/%@/%@\">%@</a>:%@",fbnews.bbsid,fbnews.bbsid,@"999",@"999",fbnews.title,fbnews.content]];
                            
                            
                            NSLog(@"tid --  %@  --  content ---  %@",obj.tid,obj.content);
                            
                            
                            [obj setImageFlg:fbnews.photoFlg];
                            
                            if (fbnews.photoFlg)
                            {
                                [obj setImage_small_url_m:fbnews.photo];// [NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                                [obj setImage_original_url_m:fbnews.photo];// [NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                                
                            }
                            
                            
                            
                        }else if([obj.sort isEqualToString:@"5"]&&[obj.type isEqualToString:@"first"])
                        {
                            //论坛分享
                            NSDictionary *newsSendjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                            Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                            [obj setExten:ex];
                            [obj setRootFlg:YES];
                            NSLog(@"论坛分享的内容 -----  %@",ex.forum_content);
                            [obj setRcontent:  [NSString stringWithFormat:@"%@:<a href=\"fb://BlogDetail/%@\">%@</a>:%@",ex.author,ex.authorid,ex.title,ex.forum_content]];
                            [obj setRsort:@"5"];
                            [obj setRsortId:ex.authorid];
                            [obj setRimageFlg:ex.photoFlg];
                            [obj setRimage_small_url_m:ex.photo];
                            [obj setRimage_original_url_m:ex.photo];
                        }else if ([obj.sort isEqualToString:@"8"]&&[obj.type isEqualToString:@"first"])
                        {
                            NSDictionary *exjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                            Extension * ex=[[Extension alloc]initWithJson:exjson];
                            [obj setExten:ex];
                            [obj setContent:[NSString stringWithFormat:@"分享新闻<a href=\"fb://PhotoDetail/%@\">%@</a>:%@",ex.authorid,ex.title,obj.content]];
                        }else if([obj.sort isEqualToString:@"10"]&&[obj.type isEqualToString:@"first"])
                        {
                            //资源分享
                            NSDictionary *newsSendjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                            Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                            [obj setExten:ex];
                            [obj setRootFlg:YES];
                            NSLog(@"论坛分享的内容 -----  %@",ex.forum_content);
                            [obj setRcontent:[zsnApi ShareResourceContent:ex.forum_content]];
                            [obj setRsort:@"10"];
                            [obj setRsortId:ex.authorid];
                            [obj setRimageFlg:ex.photoFlg];
                            [obj setRimage_small_url_m:ex.photo];
                            [obj setRimage_original_url_m:ex.photo];
                        }
                        
                        
                        
                        while ([obj.content rangeOfString:@"&nbsp;"].length)
                        {
                            obj.content = [obj.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                        }
                        
                        
                        
                        NSMutableString * tempString = [NSMutableString stringWithFormat:@"%@",obj.content];
                        
                        if ([tempString rangeOfString:@"<a>#"].length)
                        {
                            NSString * insertString = [NSString stringWithFormat:@" href=\"fb://BlogDetail/%@\"",obj.tid];
                            [tempString insertString:insertString atIndex:[obj.content rangeOfString:@"<a>#"].location+2];
                            obj.content = [NSString stringWithString:tempString];
                        }
                        
                        
                        NSLog(@"aaaaaaaa -----  %@",obj.content);
                        
                        while ([obj.content rangeOfString:@"<a id="].length)
                        {
                            obj.content = [zsnApi exchangeString:obj.content];
                        }
                        
                        
                        
                        //解析转发内容
                        if (![[value objectForKey:@"roottid"] isEqualToString:@"0"] )
                        {
                            [obj setRootFlg:YES];
                            
                            NSDictionary * followinfo= [value objectForKey:@"followinfo"];
                            
                            if (followinfo==nil)
                            {
                                //原微博已删除
                                [obj setRcontent:NS_WEIBO_DEL];
                            }else
                            {
                                //解析转发的微博内容
                                [obj setRtid:[followinfo objectForKey:FB_TID]];
                                [obj setRuid:[followinfo objectForKey:FB_UID]];
                                [obj setRuserName:[followinfo objectForKey:FB_USERNAME]];
                                
                                [obj setRcontent:[ NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:%@",obj.ruserName,[zsnApi imgreplace:[followinfo objectForKey:FB_CONTENT]]]];
                                
                                if ([[followinfo objectForKey:FB_IMAGEID] isEqualToString:@"0"])
                                {
                                    [obj setRNsImageFlg:@"0"];
                                }else
                                {
                                    [obj setRNsImageFlg:@"1"];
                                }
                                
                                
                                obj.rimage_original_url_m = [followinfo objectForKey:@"image_original_m"];
                                
                                obj.rimage_small_url_m = [followinfo objectForKey:@"image_small_m"];
                                
                                
                                if ([obj rimageFlg])
                                {
                                    [obj setRimage_original_url:[followinfo objectForKey:FB_IMAGE_ORIGINAL]];
                                    [obj setRimage_small_url:[followinfo objectForKey:FB_IMAGE_SMALL]];
                                }
                                [obj setRfrom:[followinfo objectForKey:FB_FROM]];
                                [obj setRNsType:[followinfo objectForKey:FB_TYPE]];
                                obj.rsort = [followinfo objectForKey:FB_SORT];
                                obj.rsortId = [followinfo objectForKey:FB_SORTID];
                                [obj setRjing_lng:[followinfo objectForKey:FB_JING_LNG]];
                                [obj setRwei_lat:[followinfo objectForKey:FB_WEI_LAT]];
                                [obj setRlocality:[followinfo objectForKey:FB_LOCALITY]];
                                [obj setRface_original_url:[followinfo objectForKey:FB_FACE_ORIGINAL]];
                                [obj setRface_small_url:[followinfo objectForKey:FB_FACE_SMALL]];
                                [obj setRNsRootFlg:[followinfo objectForKey:FB_ROOTTID]];
                                [obj setRdateline:[followinfo objectForKey:FB_DATELINE]];
                                [obj setRreplys:[followinfo objectForKey:FB_REPLYS]];
                                [obj setRforwards:[followinfo objectForKey:FB_FORWARDS]];
                                //解析其他类型
                                if ([obj.rsort isEqualToString:@"6"]&&[obj.rtype isEqualToString:@"first"])
                                {
                                    //解析新闻评论
                                    NSDictionary *exjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                                    Extension * ex=[[Extension alloc]initWithJson:exjson];
                                    [obj setRexten:ex];
                                    [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:我对新闻<a href=\"fb://PhotoDetail/%@\">%@</a>发表了评论:%@",obj.ruserName,obj.ruserName,ex.title,obj.rcontent]];
                                }else if([obj.rsort isEqualToString:@"3"]&&[obj.rtype isEqualToString:@"first"])
                                {
                                    //解析图集
                                    NSDictionary *photojson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                                    PhotoFeed * photo=[[PhotoFeed alloc]initWithJson:photojson];
                                    [obj setRphoto:photo];
                                    [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:我在图集<a href=\"fb://PhotoDetail/%@\">%@</a>上传了新图片",obj.ruserName,photo.aid,photo.title]];
                                    [obj setRimageFlg:YES];
                                    [obj setRimage_small_url_m: [photo.image objectAtIndex:0]];
                                    [obj setRimage_original_url_m:[photo.image objectAtIndex:0]];
                                }else if([obj.rsort isEqualToString:@"2"]&&[obj.rtype isEqualToString:@"first"])
                                {
                                    //解析文集
                                    NSDictionary *blogjson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                                    BlogFeed * blog=[[BlogFeed alloc]initWithJson:blogjson];
                                    [obj setRblog:blog];
                                    [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:我发表文集<a href=\"fb://BlogDetail/%@\">%@</a>:%@",obj.ruserName,blog.blogid,blog.title,blog.content]];
                                    [obj setRimageFlg:blog.photoFlg];
                                    if (blog.photoFlg) {
                                        [obj setRimage_small_url_m:blog.photo];
                                        [obj setRimage_original_url_m:blog.photo];
                                    }
                                }else if([obj.rsort isEqualToString:@"4"]&&[obj.rtype isEqualToString:@"first"])
                                {
                                    //论坛帖子转发为微博
                                    NSDictionary *newsForwoadjson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                                    FbNewsFeed * fbnews=[[FbNewsFeed alloc]initWithJson:newsForwoadjson];
                                    [obj setRfbNews:fbnews];
                                    [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:转发论坛帖子<a href=\"fb://tieziDetail/%@/%@/%@/%@/%@\">%@</a>:%@",obj.ruserName,fbnews.bbsid,   [fbnews.title stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],fbnews.bbsid,@"999",@"999",fbnews.title,fbnews.content]];
                                    
                                    [obj setRimageFlg:fbnews.photoFlg];
                                    if (fbnews.photoFlg) {
                                        
                                        [obj setRimage_small_url_m:fbnews.photo];//[NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                                        
                                        [obj setRimage_original_url_m:fbnews.photo];//[NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                                    }
                                }else if([obj.rsort isEqualToString:@"5"]&&[obj.rtype isEqualToString:@"first"])
                                {
                                    //论坛分享
                                    
                                    NSDictionary *newsSendjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                                    Extension * ex=[[Extension alloc]initWithJson:newsSendjson];
                                    [obj setRexten:ex];
                                    [obj setRcontent:  [NSString stringWithFormat:@"%@ %@:<a>%@</a>:%@",obj.rcontent,ex.author, ex.title,ex.forum_content]];
                                    [obj setRimageFlg:ex.photoFlg];
                                    [obj setRimage_small_url_m:ex.photo];
                                    [obj setRimage_original_url_m:ex.photo];
                                }else if ([obj.rsort isEqualToString:@"8"]&&[obj.rtype isEqualToString:@"first"])
                                {
                                    NSDictionary *exjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                                    Extension * ex=[[Extension alloc]initWithJson:exjson];
                                    [obj setExten:ex];
                                    [obj setContent:[NSString stringWithFormat:@"分享新闻<a href=\"fb://PhotoDetail/%@\">%@</a>:%@",ex.authorid,ex.title,obj.content]];
                                }else if([obj.rsort isEqualToString:@"10"]&&[obj.rtype isEqualToString:@"first"])
                                {
                                    //资源分享
                                    NSDictionary *newsSendjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                                    Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                                    [obj setExten:ex];
                                    [obj setRootFlg:YES];
                                    NSLog(@"论坛分享的内容 -----  %@",ex.forum_content);
                                    [obj setRcontent:[zsnApi ShareResourceContent:ex.forum_content]];
                                    [obj setRsort:@"10"];
                                    [obj setRsortId:ex.authorid];
                                    [obj setRimageFlg:ex.photoFlg];
                                    [obj setRimage_small_url_m:ex.photo];
                                    [obj setRimage_original_url_m:ex.photo];
                                }
                            }
                        }
                        
                        
                        while ([obj.rcontent rangeOfString:@"&nbsp;"].length)
                        {
                            obj.rcontent = [obj.rcontent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                        }
                        
                        
                        
                        NSMutableString * RtempString = [NSMutableString stringWithFormat:@"%@",obj.rcontent];
                        
                        if ([RtempString rangeOfString:@"<a>#"].length)
                        {
                            NSString * insertString = [NSString stringWithFormat:@" href=\"fb://BlogDetail/%@\"",obj.rtid];
                            [RtempString insertString:insertString atIndex:[obj.rcontent rangeOfString:@"<a>#"].location+2];
                            obj.rcontent = [NSString stringWithString:RtempString];
                        }
                        
                        
                        NSLog(@"rrrrrrrrrr -----  %@",obj.rcontent);
                        
                        while ([obj.rcontent rangeOfString:@"<a id="].length)
                        {
                            obj.rcontent = [zsnApi exchangeString:obj.rcontent];
                        }
                        
                        
                        detail.info=obj;
                        
                        NSLog(@"fbno==detail.info.tid=%@",detail.info.tid);
                        [self.navigationController pushViewController:detail animated:YES];
                        
                        // info.face_original_url=[NSString stringWithFormat:@"%@",[dic objectForKey:@""]];
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
            
        }else if (type==9)
        {//加好友
            NewMineViewController * people = [[NewMineViewController alloc] init];
            
            people.uid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"actid"]];
            
            [self.navigationController pushViewController:people animated:YES];
        }
    }else{
        
        dic=[bbs_array objectAtIndex:indexPath.row];
        
        bbsdetailViewController *_detail=[[bbsdetailViewController alloc]init];
        _detail.bbsdetail_tid=[dic objectForKey:@"tid"];
        
        [self.navigationController pushViewController:_detail animated:YES];
        
        
        NSLog(@"点击的bbs的第%d行",indexPath.row);
    }

    
  }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic;
    
    if (tableView==fbnoti_tab) {
        if (indexPath.section==0)
        {
            if (_uread_array.count>0)
            {
                dic=[_uread_array objectAtIndex:indexPath.row];
            }else
            {
                dic=[_read_array objectAtIndex:indexPath.row];
            }
        }
        if (indexPath.section==1)
        {
            dic=[_read_array objectAtIndex:indexPath.row];
            
        }
        NSString *string_contenttext=[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        CGSize constraintSize = CGSizeMake(220, MAXFLOAT);
        CGSize labelSize = [string_contenttext sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        
        if (_read_array.count > 0 && _uread_array.count > 0)
        {
            
            if (indexPath.section == 0)
            {
                return labelSize.height+60;
            }else
            {
                return labelSize.height+50;
            }
            
            
        }else
        {
            return labelSize.height+50;
        }

        
    }else{
        
            dic=[bbs_array objectAtIndex:indexPath.row];
            
        NSString *string_contenttext=[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]];
        CGSize constraintSize = CGSizeMake(220, MAXFLOAT);
        CGSize labelSize = [string_contenttext sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        
  
            return labelSize.height+60;
        }
        
    
    
}



#pragma mark-model的代理
-(void)finishloadNotificationInfo:(NSArray *)arrayinfo errcode:(NSString *)string_codeerror errordata:(NSString *)errorinfodata withUrl:(NSString *)theUrl
{
    [_loadingView stopLoading:1];
    _isloadingIv.hidden=YES;
    
    [_isloadingIv removeFromSuperview];
    
    _isloadingIv=nil;
    
    
    
    if ([theUrl isEqualToString:u_read_url])
    {
        if (_uread_array.count < 20)
        {
            isLoadReadData = YES;
            uReadOver = YES;
        }
        
        if (arrayinfo.count > 0)
        {
            if (arrayinfo.count>0)
            {
                [_uread_array addObjectsFromArray:arrayinfo];
            }
        }
        
        [fbnoti_tab reloadData];
    }else
    {
        if (arrayinfo.count > 0)
        {
            if (arrayinfo.count>0)
            {
                [_read_array addObjectsFromArray:arrayinfo];
                
                if (_read_page == 1)
                {
                    [infoofnotification startloadnotificationwithpage:_uRead_page pagenumber:@"20" withUrl:u_read_url];
                }else
                {
                    [fbnoti_tab reloadData];
                }
            }
        }
    }
}
-(void)failedtoloaddata
{
    [_loadingView stopLoading:1];
}


#pragma mark-scrollViewDelegate


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //判断选择 精选推荐 还是 全部版块
    if (scrollView == _myScrollView)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        // 根据当前的x坐标和页宽度计算出当前页数
        int current_page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        [seg_view MyButtonStateWithIndex:current_page];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    

    if(fbnoti_tab.contentOffset.y > (fbnoti_tab.contentSize.height - fbnoti_tab.frame.size.height+40) && fbnoti_tab.contentOffset.y > 0 && scrollView==fbnoti_tab)
    {
        if ([_loadingView.normalLabel.text isEqualToString:@"加载中..."])
        {
            return;
        }
        
        [_loadingView startLoading];
        
        
        NSString *string_authkey=[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD];
        
        if (morearray)
        {
            morearray=nil;
        }
        morearray=[[NSMutableArray alloc]init];
        
        if (uReadOver)
        {
            if (_read_page == 1)
            {
                [fbnoti_tab reloadData];
                
                _read_page++;
            }else
            {
                [self loadmorewithurl:[NSString stringWithFormat:read_url,string_authkey,_read_page]];
                
                _read_page++;
            }
        }else
        {
            _uRead_page++;
            
            [self loadmorewithurl:[NSString stringWithFormat:u_read_url,string_authkey,_uRead_page]];
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"FBNotificationViewController"];
}



-(void)viewWillDisappear:(BOOL)animated
{
    _isloadingIv.hidden=YES;
    [_isloadingIv removeFromSuperview];
    _isloadingIv=nil;
    
    [MobClick endEvent:@"FBNotificationViewController"];
    
    
}
-(void)backto
{
    [infoofnotification stoploadnotification];
    infoofnotification.delegate=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadmorewithurl:(NSString *)theurl{
    
    NSLog(@"mmmurl===%@",theurl);
    if (!loadmoretool) {
        loadmoretool=[[downloadtool alloc]init];
        
    }
    [loadmoretool setUrl_string:theurl];
    
    loadmoretool.delegate=self;
    
    [loadmoretool start];
    
    
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        NSLog(@"dic==%@",dic);
        
        NSString *string_error=[NSString stringWithFormat:@"%@",[dic objectForKey:@"errcode"]];
        if ([string_error isEqualToString:@"0"])
        {
            NSString *string_test=[NSString stringWithFormat:@"%@",[dic objectForKey:@"alertlist"]];
            
            if ([string_test isEqualToString:@"<null>"])
            {
                [_loadingView removeFromSuperview];
                _loadingView=nil;
                
                label_nonedata=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
                label_nonedata.text=@"没有更多数据";
                label_nonedata.textColor=[UIColor grayColor];
                label_nonedata.textAlignment=UITextAlignmentCenter;
                label_nonedata.font=[UIFont systemFontOfSize:14];
                fbnoti_tab.tableFooterView=label_nonedata;
                
            }else
            {
                morearray=[dic objectForKey:@"alertlist"];
                [_loadingView stopLoading:1];
                isLoadReadData=!isLoadReadData;
                [_read_array addObjectsFromArray:morearray];
                [fbnoti_tab reloadData];
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
    
}
-(void)downloadtoolError{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
