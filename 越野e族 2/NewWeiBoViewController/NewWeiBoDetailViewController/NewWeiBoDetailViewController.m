//
//  NewWeiBoDetailViewController.m
//  FbLife
//
//  Created by soulnear on 13-12-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NewWeiBoDetailViewController.h"
#import "bbsdetailViewController.h"
#import "WenJiViewController.h"
#import "newsdetailViewController.h"
#import "ImagesViewController.h"
#import "fbWebViewController.h"
#import "LogInViewController.h"
#import "NewMineViewController.h"
#import "loadingimview.h"


@interface NewWeiBoDetailViewController ()
{
    UIView * tableHeaderView;
    
    loadingimview * myAlertView;
}

@end

@implementation NewWeiBoDetailViewController
@synthesize info = _info;
@synthesize dataArray = _dataArray;
@synthesize photos = _photos;
@synthesize myTableView = _myTableView;


-(void)commentSuccessWihtTid:(NSString *)theTid IndexPath:(int)theIndexpath SelectView:(int)theselectview withForward:(BOOL)isForward
{
    
}

-(void)ForwardingSuccessWihtTid:(NSString *)theTid IndexPath:(int)theIndexpath SelectView:(int)theselectview WithComment:(BOOL)isComment
{
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(void)ForwardingSuccess
{
    pageCount =1;
    
    self.info.forwards = [NSString stringWithFormat:@"%d",1+[self.info.forwards integerValue]];
    
    [self initHttpRequest];
}


-(void)commentSuccess
{
    pageCount = 1;
    
    self.info.replys = [NSString stringWithFormat:@"%d",1+[self.info.replys integerValue]];
    
    [self initHttpRequest];
}


-(void)initHttpRequest
{
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString* fullURL = [NSString stringWithFormat:URL_WEIBO_DETAIL,self.info.tid,authkey,pageCount];
    
    NSLog(@"微博详情请求的url ---  %@",fullURL);
    
    detail_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullURL]];
    
    detail_request.shouldAttemptPersistentConnection = NO;
    
    [detail_request setDelegate:self];
    
    [detail_request startAsynchronous];
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    @try {
        
        myAlertView.hidden = YES;
        
        NSDictionary * data_dic = [request.responseData objectFromJSONData];
        
        if (pageCount == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        
        NSString *errcode = [data_dic objectForKey:@"errcode"];
        
        if ([@"0" isEqualToString:errcode])
        {
            NSDictionary* weibomain = [data_dic objectForKey:@"weibomain"];
            
            if ([weibomain isEqual:[NSNull null]])
            {
                //如果没有微博的话
                NSLog(@"------------没有微博信息---------------");
            }else
            {
                _feed = [[zsnApi conversionFBContent:weibomain isSave:NO WithType:0] objectAtIndex:0];
            }
            
            //解析评论信息
            NSDictionary* userinfo = [data_dic objectForKey:@"weiboinfo"];
            
            if ([userinfo isEqual:[NSNull null]])
            {
                [tabelFootView stopLoading:1];
                tabelFootView.normalLabel.text = @"还没有人评论过";
                
                _myTableView.tableFooterView = tishi_view;
                
                //如果没有微博的话
                NSLog(@"------------此微博没有评论信息---------------");
            }else
            {
                [tabelFootView stopLoading:1];
                tabelFootView.normalLabel.text = @"";
                
                _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0)];
                
                UIImageView * image_view = (UIImageView *)[tableHeaderView viewWithTag:417];
                
                image_view.image = [UIImage imageNamed:@"weibo_detail_line-1.png"];
                
                
                NSArray *keys;
                int i, count;
                id key, value;
                keys = [userinfo allKeys];
                
                //给keys排序降序
                NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
                NSArray *arr1 = [keys sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
                
                count = [arr1 count];
                
                
                for (i = 0; i < count; i++)
                {
                    ReplysFeed *obj = [[ReplysFeed alloc] init];
                    key = [arr1 objectAtIndex: i];
                    value = [userinfo objectForKey: key];
                    
                    [obj setTid:[value objectForKey:@"tid"]];
                    [obj setUid:[value objectForKey:@"uid"]];
                    [obj setUsername:[value objectForKey:@"username"]];
                    [obj setContent:[zsnApi FBImageChange:[value objectForKey:@"content"]]];
                    [obj setContent:[self exChangeFbString:obj.content]];
                    
                    [obj setImageid:[value objectForKey:@"imageid"]];
                    [obj setReplys:[value objectForKey:@"replys"]];
                    [obj setForwards:[value objectForKey:@"forwards"]];
                    [obj setRoottid:[value objectForKey:@"roottid"]];
                    [obj setTotid:[value objectForKey:@"totid"]];
                    [obj setTouid:[value objectForKey:@"touid"]];
                    [obj setTousername:[value objectForKey:@"tousername"]];
                    [obj setDateline:[personal timestamp:[value objectForKey:@"dateline"]]];
                    [obj setFrom:[value objectForKey:@"from"]];
                    [obj setSort:[value objectForKey:@"sort"]];
                    [obj setSortid:[value objectForKey:@"sortid"]];
                    [obj setImageSmall:[value objectForKey:@"image_small"]];
                    [obj setImageOriginal:[value objectForKey:@"image_original"]];
                    [obj setFaceSmall:[value objectForKey:@"face_small"]];
                    [obj setFaceOriginal:[value objectForKey:@"face_original"]];
                    
                    [self.dataArray addObject:obj];
                }
            }
        }
        
        [self.myTableView reloadData];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}




-(NSString *)exChangeFbString:(NSString *)theString
{
    while ([theString rangeOfString:@"<a id="].length)
    {
        theString = [zsnApi exchangeString:theString];
    }
    
    return theString;
}



-(void)backH:(UIButton *)sender
{
    [detail_request cancel];
    
    detail_request.delegate = nil;
    
    detail_request = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"NewWeiBoDetailViewController"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"NewWeiBoDetailViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    self.photos = [[NSMutableArray alloc] init];
    
    pageCount = 1;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        //iOS 5 new UINavigationBar custom background
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = MY_MACRO_NAME?-4:5;
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,31/2,32/2)];
//    
//    [button_back addTarget:self action:@selector(backH:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [button_back setImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    
//    self.navigationItem.leftBarButtonItems=@[negativeSpacer,back_item];
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    _dataArray = [[NSMutableArray alloc] init];
    
    
    [self initHttpRequest];
    
    
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-20-44-44) style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    if (IOS_VERSION>=7.0)
    {
        self.myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:self.myTableView];
    
    
    tabelFootView = [[LoadingIndicatorView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,40)];
    
    [tabelFootView startLoading];
    
    self.myTableView.tableFooterView = tabelFootView;
    
    
    
    
    
    weibo_content_view = [self returnWeiBocontentView];
    
    tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,weibo_content_view.frame.size.height+40)];
    
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * line_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,tableHeaderView.frame.size.height-4,DEVICE_WIDTH,4)];
    
    line_imageView.tag = 417;
    
    line_imageView.image = [UIImage imageNamed:@"weibo_detai_line.png"];
    
    [tableHeaderView addSubview:line_imageView];
    
    [tableHeaderView addSubview:weibo_content_view];
    
    _myTableView.sectionHeaderHeight = tableHeaderView.frame.size.height;
    
    _myTableView.tableHeaderView = tableHeaderView;
    
    
    
    tishi_view = [[UIView alloc] initWithFrame:CGRectMake(0,tableHeaderView.frame.size.height,DEVICE_WIDTH,200)];
    
    tishi_view.backgroundColor = [UIColor whiteColor];
    
    
    //    if (MY_MACRO_NAME)
    //    {
    //        UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0.5)];
    //        lineview.backgroundColor = RGBCOLOR(189,189,189);
    //
    //        [tishi_view addSubview:lineview];
    //    }
    
    
    UIImageView * wu_imageView = [[UIImageView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH-121/2)/2,114/2,121/2,114/2)];
    
    wu_imageView.image = [UIImage imageNamed:@"weibo_detail_wurenpinglun.png"];
    
    [tishi_view addSubview:wu_imageView];
    
    
    UILabel * wu_label = [[UILabel alloc] initWithFrame:CGRectMake(0,114+12,DEVICE_WIDTH,20)];
    
    wu_label.backgroundColor = [UIColor clearColor];
    
    wu_label.text = @"还没有人评论";
    
    wu_label.textAlignment = NSTextAlignmentCenter;
    
    wu_label.textColor = RGBCOLOR(193,193,193);
    
    wu_label.font = [UIFont systemFontOfSize:14];
    
    [tishi_view addSubview:wu_label];
    
    
    
    DetailBottomView * bottom_view = [[DetailBottomView alloc] initWithFrame:CGRectMake(0,DEVICE_HEIGHT-64-44,DEVICE_WIDTH,44)];
    
    bottom_view.delegate = self;
    
    bottom_view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bottom_view];
    
    
    
    myAlertView = [[loadingimview alloc] initWithFrame:CGRectMake(0,0,150,100) labelString:@"正在加载"];
    
    myAlertView.center = CGPointMake(DEVICE_WIDTH/2,DEVICE_HEIGHT/2-64);
    
    myAlertView.hidden = YES;

    [self.view addSubview:myAlertView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if (indexPath.row == 0)
    //    {
    //        if (!weibo_content_view)
    //        {
    //            weibo_content_view = [self returnWeiBocontentView];
    //        }
    //
    //        return weibo_content_view.frame.size.height + 35;
    //    }else
    //    {
    ReplysFeed * info = [self.dataArray objectAtIndex:indexPath.row];
    
    if (!test_label)
    {
        test_label = [[RTLabel alloc] initWithFrame:CGRectMake(55,35,DEVICE_WIDTH-65,10)];
        test_label.lineSpacing = 3;
        test_label.lineBreakMode = NSLineBreakByCharWrapping;
        test_label.font = [UIFont systemFontOfSize:15];
    }
    
    test_label.text = info.content;
    
    CGSize optimumSize = [test_label optimumSize];
    
    return optimumSize.height + 30 + 20;
    //    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier2 = @"cell2";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
    }
    
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    
    
    _Head_ImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(10,10,CELL_TOUXIANG,CELL_TOUXIANG)];
    
    _Head_ImageView.userInteractionEnabled = YES;
    
    _Head_ImageView.layer.masksToBounds = NO;
    
    _Head_ImageView.layer.shadowOffset = CGSizeMake(0.3,0.3);
    
    _Head_ImageView.layer.shadowRadius = 1;
    
    _Head_ImageView.layer.shadowOpacity = 0.2;
    
    _Head_ImageView.backgroundColor = [UIColor redColor];
    
    _Head_ImageView.tag = 100+indexPath.row;
    
    [cell.contentView addSubview:_Head_ImageView];
    
    UITapGestureRecognizer * head_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
    
    [_Head_ImageView addGestureRecognizer:head_tap];
    
    
    _UserName_Label = [[UILabel alloc] initWithFrame:CGRectMake(55,8,200,20)];
    _UserName_Label.backgroundColor = [UIColor clearColor];
    _UserName_Label.font = [UIFont boldSystemFontOfSize:13];
    _UserName_Label.textColor = RGBCOLOR(90,107,151);
    _UserName_Label.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:_UserName_Label];
    
    
    _DateLine_Label = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-70,8,60,20)];
    _DateLine_Label.backgroundColor = [UIColor clearColor];
    _DateLine_Label.font = [UIFont systemFontOfSize:12];
    _DateLine_Label.textColor = RGBCOLOR(142,142,142);
    _DateLine_Label.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:_DateLine_Label];
    
    
    content_label = [[RTLabel alloc] initWithFrame:CGRectMake(55,35,DEVICE_WIDTH-65,10)];
    
    content_label.lineBreakMode = NSLineBreakByCharWrapping;
    
    content_label.lineSpacing = 3;
    
    content_label.delegate = self;
    
    content_label.textColor = RGBCOLOR(49,49,49);
    
    content_label.backgroundColor = [UIColor clearColor];
    
    content_label.font = [UIFont systemFontOfSize:15];
    
    [cell.contentView addSubview:content_label];
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if (self.dataArray.count > 0)
    {
        cell.backgroundColor = RGBCOLOR(247,247,247);
        
        cell.contentView.backgroundColor = RGBCOLOR(247,247,247);
        
        ReplysFeed * info = [self.dataArray objectAtIndex:indexPath.row];
        
        [_Head_ImageView loadImageFromURL:info.faceOriginal withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
        
        _UserName_Label.text = info.username;
        
        _DateLine_Label.text = info.dateline;
        
        content_label.text = info.content;
        
        CGSize optimumSize = [content_label optimumSize];
        
        CGRect rect = [content_label frame];
        
        rect.size.height = optimumSize.height+10;
        
        content_label.frame = rect;
    }
    
    return cell;
}


-(UIView *)returnWeiBocontentView
{
    
    UIView * weibo_view = [[UIView alloc] init];
    
    weibo_view.backgroundColor = [UIColor clearColor];
    
    
    AsyncImageView * headerView = [[AsyncImageView alloc] initWithFrame:CGRectMake(10,10,CELL_TOUXIANG,CELL_TOUXIANG)];
    
    headerView.userInteractionEnabled = YES;
    
    headerView.layer.masksToBounds = NO;
    
    headerView.layer.shadowOffset = CGSizeMake(0.3,0.3);
    
    headerView.layer.shadowRadius = 1;
    
    headerView.layer.shadowOpacity = 0.2;
    
    headerView.backgroundColor = [UIColor redColor];
    
    [weibo_view addSubview:headerView];
    UITapGestureRecognizer * head_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myheadTap:)];
    [headerView addGestureRecognizer:head_tap];
    
    
    UILabel * userName = [[UILabel alloc] initWithFrame:CGRectMake(55,8,200,20)];
    userName.backgroundColor = [UIColor clearColor];
    userName.font = [UIFont boldSystemFontOfSize:15];
    userName.textColor = RGBCOLOR(89,106,149);
    userName.textAlignment = NSTextAlignmentLeft;
    [weibo_view addSubview:userName];
    
    [headerView loadImageFromURL:self.info.face_original_url withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
    
    userName.text = self.info.userName;
    
    
    
    float total_height = 0;
    
    //0:微博  2:文集  3:图集  4:论坛帖子转发微博  5:论坛分享 6:新闻评论 8:新闻分享  10:资源分享
    
    UIImageView * _reply_background_view;
    
    CGRect reply_frame = CGRectMake(55,0,DEVICE_WIDTH-65,0);
    
    if (self.info.rootFlg)
    {
        _reply_background_view = [[UIImageView alloc] initWithFrame:reply_frame];
        
        _reply_background_view.userInteractionEnabled = YES;
        
        [weibo_view addSubview:_reply_background_view];
    }
    
    
    WeiBoSpecialView *  _content_view_special = [[WeiBoSpecialView alloc] initWithFrame:CGRectMake(55,35,DEVICE_WIDTH-65,100)];
    
    _content_view_special.line_space = 5;
    
    _content_view_special.content_font = 16;
    
    _content_view_special.delegate = self;
    
    [weibo_view addSubview:_content_view_special];
    
    CGRect rect = [_content_view_special frame];
    
    rect.size.height = [_content_view_special setAllViewWithFeed:self.info isReply:NO];
    
    _content_view_special.frame = rect;
    
    total_height = rect.size.height + 30;
    
    reply_frame.origin.y = rect.size.height + 35 + 3;
    
    
    if (self.info.rootFlg)
    {
        WeiBoSpecialView * _content_reply_special = [[WeiBoSpecialView alloc] initWithFrame:CGRectMake(8,10,DEVICE_WIDTH-65-16,0)];
        
        _content_reply_special.line_space = 3;
        
        _content_reply_special.content_font = 16;
        
        _content_reply_special.delegate = self;
        
        [_reply_background_view addSubview:_content_reply_special];
        
        CGRect rect = [_content_reply_special frame];
        
        rect.size.height = [_content_reply_special setAllViewWithFeed:self.info isReply:YES];
        
        _content_reply_special.frame = rect;
        
        reply_frame.size.height = rect.size.height + 20;
        
        total_height = total_height + rect.size.height + 20 + 10;
        
        
        _reply_background_view.frame = reply_frame;
        
        _reply_background_view.image = [[UIImage imageNamed:@"newWeiBoBackGroundImage.png"] stretchableImageWithLeftCapWidth:130 topCapHeight:7];
    }
    
    
    UILabel * _from_label = [[UILabel alloc] initWithFrame:CGRectMake(55,total_height + 10,100,20)];
    
    _from_label.textColor = RGBCOLOR(142,142,142);
    
    _from_label.text = self.info.from;
    
    _from_label.textAlignment = NSTextAlignmentLeft;
    
    _from_label.font = [UIFont systemFontOfSize:12];
    
    _from_label.backgroundColor = [UIColor clearColor];
    
    [weibo_view addSubview:_from_label];
    
    
    
    UIButton * _pinglun_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _pinglun_button.frame = CGRectMake(DEVICE_WIDTH-40,total_height + 10,40,20);
    [_pinglun_button setTitle:self.info.replys forState:UIControlStateNormal];
    
    _pinglun_button.backgroundColor = [UIColor clearColor];
    [_pinglun_button setImage:[UIImage imageNamed:@"weibo_detail_talk.png"] forState:UIControlStateNormal];
    [_pinglun_button setTitleColor:RGBCOLOR(89,106,149) forState:UIControlStateNormal];
    _pinglun_button.titleLabel.font = [UIFont systemFontOfSize:13];
    [_pinglun_button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
    [_pinglun_button setImageEdgeInsets:UIEdgeInsetsMake(2,0,0,15)];
    _pinglun_button.userInteractionEnabled = NO;
    [weibo_view addSubview:_pinglun_button];
    
    
    UIButton * _zhuanfa_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _zhuanfa_button.frame = CGRectMake(DEVICE_WIDTH-80,total_height+10,40,20);
    [_zhuanfa_button setTitle:self.info.forwards forState:UIControlStateNormal];
    _zhuanfa_button.backgroundColor = [UIColor clearColor];
    [_zhuanfa_button setImage:[UIImage imageNamed:@"zhuanfa-xiao.png"] forState:UIControlStateNormal];
    [_zhuanfa_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _zhuanfa_button.titleLabel.font = [UIFont systemFontOfSize:13];
    [_zhuanfa_button setImageEdgeInsets:UIEdgeInsetsMake(0,0,1,15)];
    [_zhuanfa_button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
    _zhuanfa_button.userInteractionEnabled = NO;
    [weibo_view addSubview:_zhuanfa_button];
    
    weibo_view.frame = CGRectMake(0,0,DEVICE_WIDTH,total_height);
    
    
    return weibo_view;
}

-(void)myheadTap:(UITapGestureRecognizer *)sender
{
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    
    mine.uid = self.info.uid;
    
    [self.navigationController pushViewController:mine animated:YES];
}

-(void)headTap:(UITapGestureRecognizer *)sender
{
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    
    ReplysFeed * feeds = [self.dataArray objectAtIndex:sender.view.tag-100];
    
    mine.uid = feeds.uid;
    
    [self.navigationController pushViewController:mine animated:YES];
}


#pragma mark-RTLabelDelegate

-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    NSString * theUrl = [url absoluteString];
    
    if ([theUrl rangeOfString:@"http://"].length || [theUrl rangeOfString:@"https://"].length)
    {
        [self showClickUrl:theUrl WithFBFeed:self.info];
    }else
    {
        if (([theUrl rangeOfString:@"atSomeone@"].length || [theUrl rangeOfString:@"fb://PhotoDetail/id="].length))
        {
            [self showAtSomeBody:theUrl WithFBFeed:self.info];
        }else
        {
            [self clickUrlToShowWeiBoDetailWithInfo:self.info WithUrl:theUrl isRe:0];
        }
    }
}


#pragma mark-weiboSpecialViewDelegate

-(void)SpecialPlayVideoWithReply:(BOOL)isRe
{
    fbWebViewController * web = [[fbWebViewController alloc]init];
    
    web.urlstring = isRe?self.info.rolink:self.info.olink;
    
    [self.navigationController pushViewController:web animated:YES];
}


-(void)SpecialClickUrl:(NSString *)theUrl WithIsRe:(BOOL)isreply
{
    if ([theUrl rangeOfString:@"http://"].length || [theUrl rangeOfString:@"https://"].length)
    {
        [self showClickUrl:theUrl WithFBFeed:self.info];
    }else
    {
        if (([theUrl rangeOfString:@"atSomeone@"].length || [theUrl rangeOfString:@"fb://PhotoDetail/id="].length))
        {
            [self showAtSomeBody:theUrl WithFBFeed:self.info];
        }else
        {
            [self clickUrlToShowWeiBoDetailWithInfo:self.info WithUrl:theUrl isRe:isreply];
        }
    }
}


-(void)SpecialClickPictures:(int)index WithIsRe:(BOOL)isRe
{
    NSString * sort = isRe?self.info.rsort:self.info.sort;
    [_photos removeAllObjects];
    
    if ([sort isEqualToString:@"3"])
    {
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        if (!isLogIn)
        {
            LogInViewController * logIn = [LogInViewController sharedManager];
            [self presentViewController:logIn animated:YES completion:nil];
            return;
        }
    }
    
    
    NSString * image_string = isRe?self.info.rimage_original_url_m:self.info.image_original_url_m;
    
    NSArray * array = [image_string componentsSeparatedByString:@"|"];
    
    for (NSString * string in array)
    {
        NSString * url_string = [string stringByReplacingOccurrencesOfString:@"_s." withString:@"_b."];
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:url_string]]];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    
    browser.title_string = self.info.photo_title;
    
    [browser setInitialPageIndex:index];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self presentViewController:browser animated:YES completion:nil];
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
            
            LogInViewController * logIn = [LogInViewController sharedManager];
            
            [self presentViewController:logIn animated:YES completion:nil];
        }
        
        
    }else if ([string intValue] == 2)
    {
        
        WenJiViewController * wenji = [[WenJiViewController alloc] init];
        
        wenji.bId = sortId;
        
        [self setHidesBottomBarWhenPushed:YES];
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        
        [self.navigationController pushViewController:wenji animated:YES];
        
        [self setHidesBottomBarWhenPushed:NO];
    }
    //    else
    //    {
    //        NewWeiBoDetailViewController * detail = [[NewWeiBoDetailViewController alloc] init];
    //
    //        detail.info = info;
    //
    //        [self setHidesBottomBarWhenPushed:YES];
    //
    //        [self.leveyTabBarController hidesTabBar:YES animated:YES];
    //
    //        [self.navigationController pushViewController:detail animated:YES];
    //
    //        [self setHidesBottomBarWhenPushed:NO];
    //    }
}

-(void)showClickUrl:(NSString *)theUrl WithFBFeed:(FbFeed *)info;
{
    fbWebViewController *fbweb=[[fbWebViewController alloc]init];
    
    fbweb.urlstring = theUrl;
    
    [self.navigationController pushViewController:fbweb animated:YES];
}

-(void)showAtSomeBody:(NSString *)theUrl WithFBFeed:(FbFeed *)info
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


#pragma mark-DetailBottomViewDelegate

-(void)buttonClickWithIndex:(int)index
{
    switch (index) {
        case 0:
        {
            myAlertView.hidden = NO;
            [self initHttpRequest];
        }
            break;
        case 1:
        {
            ForwardingViewController *  forward1 = [[ForwardingViewController alloc] init];
            forward1.delegate = self;
            forward1.info = self.info;
            [self presentViewController:forward1 animated:YES completion:nil];
        }
            break;
        case 2:
        {
            NewWeiBoCommentViewController *  comment1 = [[NewWeiBoCommentViewController alloc] init];
            comment1.delegate = self;
            comment1.info = self.info;
            [self presentViewController:comment1 animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end













