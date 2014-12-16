//
//  NewMineViewController.m
//  FbLife
//
//  Created by soulnear on 13-12-11.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NewMineViewController.h"
#import "fbWebViewController.h"

@interface NewMineViewController ()
{
    
}

@end

@implementation NewMineViewController
@synthesize uid = _uid;
@synthesize per_info = _per_info;
@synthesize myTableView = _myTableView;
@synthesize top_view = _top_view;
@synthesize data_array = _data_array;
@synthesize zixin_array = _zixin_array;
@synthesize photos = _photos;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


-(void)getShangJiaNews
{
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString * fullUrl = [NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=service&code=getservice&uid=%@&fromtype=b5eeec0b&authkey=%@&page=1&ps=4&fbtype=json",self.uid,authkey];
    
    if (shangjia_new_request)
    {
        [shangjia_new_request cancel];
        shangjia_new_request.delegate = nil;
        shangjia_new_request = nil;
    }
    
    shangjia_new_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    
    shangjia_new_request.shouldAttemptPersistentConnection = NO;
    
    __block typeof(shangjia_new_request) request = shangjia_new_request;
    
    
    [request setCompletionBlock:^{
        @try {
            NSDictionary * dic = [shangjia_new_request.responseData objectFromJSONData];
            
            NSString * errcode = [dic objectForKey:@"errcode"];
            
            if ([errcode intValue] == 0)
            {
                NSDictionary * data = [dic objectForKey:@"data"];
                
                NSArray * array = [data allValues];
                
                
                for (NSDictionary * dic1 in array)
                {
                    ShangJiaNewsInfo * info = [[ShangJiaNewsInfo alloc] initWithDic:dic1];
                    
                    [_zixin_array addObject:info];
                }
                
                
                [self shangjiaDataView];
                
                [_myTableView reloadData];
            }

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [request setFailedBlock:^{
        _replaceAlertView.hidden = NO;
        [_replaceAlertView hide];
    }];
    
    
    [shangjia_new_request startAsynchronous];
}

-(void)initHttpWeiBoContent
{
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString * fullURL=[NSString stringWithFormat:FB_WEIBOMYLIST_URL,authkey,pageCount,self.uid];
    
    NSLog(@"个人界面微博信息url----%@",fullURL);
    
    if (request_weibo)
    {
        [request_weibo cancel];
        request_weibo.delegate = nil;
        request_weibo = nil;
    }
    
    
    request_weibo = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullURL]];
    
    __block typeof(request_weibo) request = request_weibo;
    
    [request setCompletionBlock:^{
        @try {
            NSDictionary * dic = [request_weibo.responseData objectFromJSONData];
            
            NSString * errcode = [dic objectForKey:@"errcode"];
            
            [loadview stopLoading:1];
            
            if ([errcode intValue] == 0)
            {
                NSDictionary * weiboinfo = [dic objectForKey:@"weiboinfo"];
                
                
                if (pageCount != 1)
                {
                    if ([weiboinfo isEqual:[NSNull null]])
                    {
                        loadview.normalLabel.text = @"没有更多了";
                        return;
                    }
                }else
                {
                    [_data_array removeAllObjects];
                }
                
                
                if ([weiboinfo isEqual:[NSNull null]])
                {
                    loadview.normalLabel.text = @"没有更多了";
                    //如果没有微博的话
                    NSLog(@"------------没有微博信息---------------");
                }else
                {
                    
                    [self.data_array addObjectsFromArray:[zsnApi conversionFBContent:weiboinfo isSave:NO WithType:0]];
                    
                    [_myTableView reloadData];
                }
            }

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [request setFailedBlock:^{
        _replaceAlertView.hidden = NO;
        [_replaceAlertView hide];
    }];
    
    
    [request_weibo startAsynchronous];
}



-(void)initHttpRequest
{
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString * fullURL= [NSString stringWithFormat:URL_USERMESSAGE,_uid,authkey];
    
    NSLog(@"个人信息请求的url = %@",fullURL);
    
    
    if (request_mine)
    {
        [request_mine cancel];
        request_mine.delegate = nil;
        request_mine = nil;
    }
    
    request_mine = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullURL]];
    
    request_mine.shouldAttemptPersistentConnection = NO;
    

    __block typeof(request_mine) request = request_mine;
    
    
    [request setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request_mine.responseData objectFromJSONData];
            
            if ([[dic objectForKey:@"errcode"] intValue] != 0)
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据请求失败,请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                [alert show];
                return;
            }
            
            NSDictionary * dictionary = [[[dic objectForKey:@"data"] allValues] objectAtIndex:0];
            
            NSString * user_uid = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"uid"]];
            
            
            if ([user_uid isEqualToString:@"(null)"] || user_uid.length == 0 || [user_uid isEqualToString:@"0"] || [user_uid isEqualToString:@""])
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该用户未开通FB" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                alert.tag = 111111;
                [alert show];
                
                return;
            }
            
            _per_info = [[PersonInfo alloc] initWithDictionary:dictionary];
            
            
            _top_view.info = _per_info;
            
            if ([_per_info.is_shangjia isEqualToString:@"1"])
            {
                self.title = @"企业主页";
                
                [self getShangJiaNews];
                
                [_top_view setAllViewWithPerson:_per_info type:1];
            }else
            {
                self.title = @"个人主页";
                
                [_top_view setAllViewWithPerson:_per_info type:1];
            }
            
            
            if ([_per_info.isbuddy intValue] == 1)
            {
                attention_flg = YES;
            }else if([_per_info.isbuddy intValue] == 0)
            {
                attention_flg = NO;
            }
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    
    [request setFailedBlock:^{
        
        _replaceAlertView.hidden = NO;
        [_replaceAlertView hide];
        
    }];
    
    
    
    [request_mine startAsynchronous];
}

//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    _replaceAlertView.hidden = NO;
//    [_replaceAlertView hide];
//}
//
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    if (request.tag == 999)
//    {
//        NSDictionary * dic = [request.responseData objectFromJSONData];
//        
//        if ([[dic objectForKey:@"errcode"] intValue] != 0)
//        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据请求失败,请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//            [alert show];
//            return;
//        }
//        
//        NSDictionary * dictionary = [[[dic objectForKey:@"data"] allValues] objectAtIndex:0];
//        
//        NSString * user_uid = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"uid"]];
//        
//        
//        if ([user_uid isEqualToString:@"(null)"] || user_uid.length == 0 || [user_uid isEqualToString:@"0"] || [user_uid isEqualToString:@""])
//        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该用户未开通FB" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//            alert.tag = 111111;
//            [alert show];
//            
//            return;
//        }
//        
//        _per_info = [[PersonInfo alloc] initWithDictionary:dictionary];
//        
//        
//        _top_view.info = _per_info;
//        
//        if ([_per_info.is_shangjia isEqualToString:@"1"])
//        {
//            self.title = @"企业主页";
//            
//            [self getShangJiaNews];
//            
//            [_top_view setAllViewWithPerson:_per_info type:1];
//        }else
//        {
//            self.title = @"个人主页";
//            
//            [_top_view setAllViewWithPerson:_per_info type:1];
//        }
//        
//        
//        if ([_per_info.isbuddy intValue] == 1)
//        {
//            attention_flg = YES;
//        }else if([_per_info.isbuddy intValue] == 0)
//        {
//            attention_flg = NO;
//        }
//        
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
//        [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//    }else if(request.tag == 1000)
//    {
//        NSDictionary * dic = [request.responseData objectFromJSONData];
//        
//        NSString * errcode = [dic objectForKey:@"errcode"];
//        
//        if ([errcode intValue] == 0)
//        {
//            NSDictionary * data = [dic objectForKey:@"data"];
//            
//            NSArray * array = [data allValues];
//            
//            
//            for (NSDictionary * dic1 in array)
//            {
//                ShangJiaNewsInfo * info = [[ShangJiaNewsInfo alloc] initWithDic:dic1];
//                
//                [_zixin_array addObject:info];
//            }
//            
//            
//            [self shangjiaDataView];
//            
//            [_myTableView reloadData];
//        }
//    }else if (request.tag == 1001)
//    {
//        NSDictionary * dic = [request.responseData objectFromJSONData];
//        
//        NSString * errcode = [dic objectForKey:@"errcode"];
//        
//        [loadview stopLoading:1];
//        
//        if ([errcode intValue] == 0)
//        {
//            NSDictionary * weiboinfo = [dic objectForKey:@"weiboinfo"];
//            
//            
//            if (pageCount != 1)
//            {
//                if ([weiboinfo isEqual:[NSNull null]])
//                {
//                    loadview.normalLabel.text = @"没有更多了";
//                    return;
//                }
//            }else
//            {
//                [_data_array removeAllObjects];
//            }
//            
//            
//            if ([weiboinfo isEqual:[NSNull null]])
//            {
//                loadview.normalLabel.text = @"没有更多了";
//                //如果没有微博的话
//                NSLog(@"------------没有微博信息---------------");
//            }else
//            {
//                
//                [self.data_array addObjectsFromArray:[zsnApi conversionFBContent:weiboinfo isSave:NO WithType:0]];
//                
//                [_myTableView reloadData];
//            }
//        }
//    }
//}


-(void)backH:(UIButton *)sender
{
    [_replaceAlertView removeFromSuperview];
    [request_mine cancel];
    request_mine.delegate = nil;
    request_mine = nil;
    [request_weibo cancel];
    request_weibo.delegate = nil;
    request_weibo = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 商家视图
-(void)shangjiaDataView
{
    float total_height = 0;
    
    if (!shangjia_detail_view)
    {
        shangjia_detail_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,472)];
    }else
    {
        for (UIView * view in shangjia_detail_view.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    float image_width = [zsnApi returnAutoWidthWith:145.5];
    float image_height = [zsnApi returnAutoHeightWith:96.5 WithWidth:145.5];
    
    if (_zixin_array.count > 0 && _zixin_array.count <=2)
    {
        total_height = image_height+11.5;
    }else if (_zixin_array.count > 2)
    {
        total_height = image_height*2+11.5;
    }
    
    for (int i = 0;i < 2;i++)
    {
        for (int j = 0;j < 2;j++)
        {
            int cout = j+i*2;
            
            if (_zixin_array.count > cout)
            {
                ShangJiaNewsInfo * info = [_zixin_array objectAtIndex:cout];
                
                AsyncImageView * imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(23/2 + (image_width+5.5)*j,23/2 + (image_height+5.5)*i,image_width,image_height)];
                
                imageView.userInteractionEnabled = YES;
                
                imageView.tag = 100000+j+i*2;
                
                [imageView loadImageFromURL:info.photo withPlaceholdImage:nil];
                
                [shangjia_detail_view addSubview:imageView];
                
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
                [imageView addGestureRecognizer:tap];
                
                
                
                UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,imageView.frame.size.height - 43/2,imageView.frame.size.width,43/2)];
                
                view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
                
                [imageView addSubview:view];
                
                
                UILabel * shangjia_title_label = [[UILabel alloc] initWithFrame:view.bounds];
                
                shangjia_title_label.text = info.title;
                
                shangjia_title_label.backgroundColor = [UIColor clearColor];
                
                shangjia_title_label.textAlignment = NSTextAlignmentCenter;
                
                shangjia_title_label.textColor = [UIColor whiteColor];
                
                shangjia_title_label.font = [UIFont systemFontOfSize:13];
                
                [view addSubview:shangjia_title_label];
            }
        }
    }
    
    
    if (_per_info.service_simpcontent.length > 0)
    {
        float height = 0;
        
        CGRect image_frmae = CGRectMake(23/2,total_height+23/2,DEVICE_WIDTH-23,205/2);
        
        UIImageView * jianjie_imageview = [[UIImageView alloc] initWithFrame:image_frmae];
        
        jianjie_imageview.userInteractionEnabled = YES;
        
        [shangjia_detail_view addSubview:jianjie_imageview];
        
        
        UITapGestureRecognizer * jianjie_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jianJieTap)];
        
        [jianjie_imageview addGestureRecognizer:jianjie_tap];
        
        
        
        UILabel * name_label = [[UILabel alloc] initWithFrame:CGRectMake(5,10,DEVICE_WIDTH-23-10,20)];
        
        name_label.text = _per_info.service_shopname;
        
        name_label.textColor = RGBCOLOR(69,80,139);
        
        name_label.backgroundColor = [UIColor clearColor];
        
        name_label.textAlignment = NSTextAlignmentLeft;
        
        [jianjie_imageview addSubview:name_label];
        
        
        RTLabel * jianjie_label = [[RTLabel alloc] initWithFrame:CGRectMake(5,35,DEVICE_WIDTH-23-10,10)];
        
        jianjie_label.lineBreakMode = NSLineBreakByCharWrapping;
        
        jianjie_label.lineSpacing = 3;
        
        jianjie_label.textColor = RGBCOLOR(25,25,25);
        
        jianjie_label.font = [UIFont systemFontOfSize:15];
        
        
        jianjie_label.text = [NSString stringWithFormat:@"%@... [更多]",_per_info.service_simpcontent];
        
        CGSize optimumSize = [jianjie_label optimumSize];
        
        height = optimumSize.height;
        
        jianjie_label.frame = CGRectMake(5,30,DEVICE_WIDTH-23-10,height);
        
        jianjie_label.text = [NSString stringWithFormat:@"%@...",_per_info.service_simpcontent];
        [jianjie_imageview addSubview:jianjie_label];
        
        
        
        UILabel * test_label = [[UILabel alloc] initWithFrame:jianjie_label.frame];
        
        CGPoint point = [personal LinesWidth:[NSString stringWithFormat:@"%@...",_per_info.service_simpcontent] Label:test_label font:[UIFont systemFontOfSize:15]];
        
        UIButton * gengduo_button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        gengduo_button.frame = CGRectMake(point.x,jianjie_label.frame.origin.y + optimumSize.height-20,50,20);
        
        [gengduo_button setTitle:@"[更多]" forState:UIControlStateNormal];
        
        gengduo_button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [gengduo_button setTitleColor:RGBCOLOR(76,84,114) forState:UIControlStateNormal];
        
        [gengduo_button addTarget:self action:@selector(jianJieTap) forControlEvents:UIControlEventTouchUpInside];
        
        [jianjie_imageview addSubview:gengduo_button];
        
        
        image_frmae.size.height = height + 30 + 10;
        
        jianjie_imageview.frame = image_frmae;
        
        jianjie_imageview.image = [[UIImage imageNamed:@"jianjiebackimage.png"] stretchableImageWithLeftCapWidth:130 topCapHeight:7];
        
        
        total_height = total_height + image_frmae.size.height + 23/2;
    }
    
    
    
    if (_per_info.service_address.length > 0)
    {
        CGRect address_frame = CGRectMake(23/2,total_height+23/2,DEVICE_WIDTH-23,10);
        
        UIImageView * address_back_imageview = [[UIImageView alloc] initWithFrame:address_frame];
        
        [shangjia_detail_view addSubview:address_back_imageview];
        
        
        UIImageView * ditu_image = [[UIImageView alloc] initWithFrame:CGRectMake(8,8,101/2,101/2)];
        
        ditu_image.userInteractionEnabled = YES;
        
        ditu_image.image = [UIImage imageNamed:@"earth_logo.png"];
        
        ditu_image.backgroundColor = [UIColor grayColor];
        
        [address_back_imageview addSubview:ditu_image];
        
        
        UITapGestureRecognizer * ditu_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDiTu:)];
        
        [ditu_image addGestureRecognizer:ditu_tap];
        
        
        
        UILabel * dizhi = [[UILabel alloc] initWithFrame:CGRectMake(18+101/2,10,221,20)];
        
        dizhi.text = @"公司地址:";
        
        dizhi.backgroundColor = [UIColor clearColor];
        
        dizhi.textColor = RGBCOLOR(70,86,132);
        
        dizhi.textAlignment = NSTextAlignmentLeft;
        
        [address_back_imageview addSubview:dizhi];
        
        
        RTLabel * dizhi_label = [[RTLabel alloc]initWithFrame:CGRectMake(18+101/2,35,221,10)];
        
        dizhi_label.lineBreakMode = NSLineBreakByCharWrapping;
        
        dizhi_label.lineSpacing = 3;
        
        dizhi_label.textColor = RGBCOLOR(50,50,50);
        
        dizhi_label.font = [UIFont systemFontOfSize:15];
        
        dizhi_label.text = _per_info.service_address;
        
        [address_back_imageview addSubview:dizhi_label];
        
        CGSize optimumSize = [dizhi_label optimumSize];
        
        dizhi_label.frame = CGRectMake(18+101/2,35,221,optimumSize.height);
        
        address_frame.size.height = optimumSize.height + 45 > 66.5?optimumSize.height + 45:66.5;
        
        total_height = total_height + 23/2 + address_frame.size.height;
        
        address_back_imageview.frame = address_frame;
        
        address_back_imageview.image = [[UIImage imageNamed:@"jianjiebackimage.png"] stretchableImageWithLeftCapWidth:130 topCapHeight:7];
    }
    
    
    
    if (_per_info.service_telphone.length > 0)
    {
        UIImageView * phone_imageview = [[UIImageView alloc] initWithFrame:CGRectMake(23/2,total_height+23/2,DEVICE_WIDTH-23,40)];
        
        phone_imageview.userInteractionEnabled = YES;
        
        phone_imageview.image = [UIImage imageNamed:@"jianjiebackimage.png"];
        
        [shangjia_detail_view addSubview:phone_imageview];
        
        UITapGestureRecognizer * phone_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneTap:)];
        
        [phone_imageview addGestureRecognizer:phone_tap];
        
        
        
        UIImageView * dianhua_tubiao = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,23,23)];
        
        dianhua_tubiao.center = CGPointMake(8+23/2,phone_imageview.frame.size.height/2);
        
        dianhua_tubiao.backgroundColor = [UIColor grayColor];
        
        dianhua_tubiao.layer.masksToBounds = YES;
        
        dianhua_tubiao.layer.cornerRadius = 2;
        
        dianhua_tubiao.image = [UIImage imageNamed:@"telephoto.png"];
        
        [phone_imageview addSubview:dianhua_tubiao];
        
        
        
        UILabel * gongsidianhua = [[UILabel alloc] initWithFrame:CGRectMake(40,5,80,30)];
        
        gongsidianhua.textColor = RGBCOLOR(70,86,132);
        
        gongsidianhua.text = @"公司电话:";
        
        gongsidianhua.backgroundColor = [UIColor clearColor];
        
        gongsidianhua.textAlignment = NSTextAlignmentLeft;
        
        gongsidianhua.backgroundColor = [UIColor clearColor];
        
        [phone_imageview addSubview:gongsidianhua];
        
        
        
        
        
        UILabel * telephone_content_label = [[UILabel alloc] initWithFrame:CGRectMake(120,5,140,30)];
        
        telephone_content_label.text = _per_info.service_telphone;
        
        telephone_content_label.textAlignment = NSTextAlignmentLeft;
        
        telephone_content_label.textColor = RGBCOLOR(49,49,49);
        
        [phone_imageview  addSubview:telephone_content_label];
        
        telephone_content_label.backgroundColor = [UIColor clearColor];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callSomeBody:)];
        
        [telephone_content_label addGestureRecognizer:tap];
        
        
        total_height = total_height + 40 + 10;
        
    }
    
    
    shangjia_detail_view.frame = CGRectMake(0,0,DEVICE_WIDTH,total_height+10);
    
    show_shangjia_jianjie = total_height?YES:NO;
}


-(void)callSomeBody:(UITapGestureRecognizer *)button
{
    NSString * telephoneNum = [_per_info.service_telphone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telephoneNum]]];
}



-(void)doDiTu:(UITapGestureRecognizer *)sender
{
    FBMapViewController * map = [[FBMapViewController alloc] init];
    
    map.info = _per_info;
    
    [self.navigationController pushViewController:map animated:YES];
}


-(void)clickTap:(UITapGestureRecognizer *)sender
{
    ShangJiaNewsInfo * info = [_zixin_array objectAtIndex:(sender.view.tag-100000)];
    
    fbWebViewController * fbWeb = [[fbWebViewController alloc] init];
    
    fbWeb.urlstring = info.link;
    
    [self.navigationController pushViewController:fbWeb animated:YES];
}



-(void)animationStar
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:NS_DOING];
    [hud setActivity:NO];
    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
}

-(void)animationEnd:(BOOL)isFlg
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:isFlg?@"添加成功":@"取消成功"];
    [hud setActivity:NO];
    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
}


#pragma mark-NewUserMessageTopDelegate


-(void)sendMessageClick
{
    MessageInfo * info = [[MessageInfo alloc] init];
    
    info.to_username = _per_info.username;
    
    info.othername = _per_info.username;
    
    info.to_uid = _per_info.uid;
    
    info.from_username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    
    info.from_uid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
    
    MyChatViewController * chat = [[MyChatViewController alloc] init];
    
    chat.info = info;
    
    [self.navigationController pushViewController:chat animated:YES];
}

-(void)attentionClick
{
    attention_flg = ! attention_flg;
    
    [self animationStar];
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString* fullURL= [NSString stringWithFormat:attention_flg?URL_GUANZHU:URL_QUXIAOGUANZHU,_per_info.uid,authkey];
    NSLog(@"3请求的url ==  %@",fullURL);
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    [_requset setCompletionBlock:^{
        NSDictionary * dic = [request.responseData objectFromJSONData];
        NSString * string = [dic objectForKey:@"data"];
        
        if (([string isEqualToString:@"取消成功"] && !attention_flg) || ([string isEqualToString:@"添加成功"] && attention_flg))
        {
            [self animationEnd:attention_flg];
            //            [topview setButtonHidden:attention_flg];
        }else
        {
            UIAlertView * alet = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关注失败,请检查您当前网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            [alet show];
        }
    }];
    
    [_requset setFailedBlock:^{
        UIAlertView * alet = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关注失败,请检查您当前网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alet show];
    }];
    
    [request startAsynchronous];
}




-(void)clickButtonWithIndex:(int)index
{
    switch (index)
    {
        case 0://详细资料
        {
            mydetailViewController * detail = [[mydetailViewController alloc] init];
            
            detail.info = _per_info;
            
            if ([_per_info.is_shangjia isEqualToString:@"1"])
            {
                detail.isShangJia = YES;
            }else
            {
                detail.isShangJia = NO;
            }
            
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
        case 1://资讯
        {
            MerchantsInfoViewController * merchantsInfo = [[MerchantsInfoViewController alloc] init];
            
            merchantsInfo.uid = _per_info.uid;
            
            [self.navigationController pushViewController:merchantsInfo animated:YES];
        }
            break;
        case 2://微博
        {
            
        }
            break;
        case 3://论坛
        {
            if ([_per_info.service_fid isEqual:[NSNull null]] || _per_info.service_fid.length == 0 || [_per_info.service_fid isEqualToString:@"(null)"])
            {
                
            }else
            {
                BBSfenduiViewController * bbs = [[BBSfenduiViewController alloc] init];
                
                bbs.string_id = _per_info.service_fid;
                
                [self.navigationController pushViewController:bbs animated:YES];
            }
        }
            break;
        case 4://地图
        {
            FBMapViewController * map = [[FBMapViewController alloc] init];
            
            map.info = _per_info;
            
            [self.navigationController pushViewController:map animated:YES];
        }
            break;
        case 5://关注
        {
            guanzhuViewController * guan=[[guanzhuViewController alloc]init];
            
            guan.theTitle = @"关注";
            
            guan.theUid = _per_info.uid;
            
            [self.navigationController pushViewController:guan animated:YES];
        }
            break;
        case 6://粉丝
        {
            guanzhuViewController * guan=[[guanzhuViewController alloc]init];
            guan.theTitle = @"粉丝";
            guan.theUid = _per_info.uid;
            [self.navigationController pushViewController:guan animated:YES];
        }
            break;
        case 7://文集
        {
            
        }
            break;
        case 8://画廊
        {
            
        }
            break;
        case 9://圈子
        {
            
        }
            break;
        case 10://二维码
        {
            QrcodeViewController * qrcode = [[QrcodeViewController alloc] init];
            
            qrcode.headImage = _top_view.header_imageview.image;
            
            qrcode.uid = _per_info.uid;
            
            qrcode.nameString = _per_info.username;
            
            [self.navigationController pushViewController:qrcode animated:YES];
        }
            break;
            
        default:
            break;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"NewMineViewController"];
    
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"NewMineViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * back_viewww = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,120)];
    
    back_viewww.backgroundColor = RGBCOLOR(40, 43, 53);
    
    [self.view addSubview:back_viewww];
    
    
    pageCount = 1;
    
    _data_array = [[NSMutableArray alloc] init];
    
    _zixin_array = [[NSMutableArray alloc] init];
    
    _photos = [[NSMutableArray alloc] init];
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        //iOS 5 new UINavigationBar custom background
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    
//    UIBarButtonItem * spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    spaceBar.width = MY_MACRO_NAME?-4:5;
//    
//    
//    UIButton * back_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    back_button.frame = CGRectMake(0,0,12,21.5);
//    
//    [back_button setImage:[UIImage imageNamed:@"ios7_back.png"] forState:UIControlStateNormal];
//    
//    [back_button addTarget:self action:@selector(backH:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.leftBarButtonItems = @[spaceBar,[[UIBarButtonItem alloc] initWithCustomView:back_button]];
//    
//    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    [self initHttpRequest];
    [self initHttpWeiBoContent];
    
    if (!loadview)
    {
        loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
    }
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-20-44) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.backgroundColor = [UIColor clearColor];//RGBCOLOR(40, 43, 53);
    
    if (IOS_VERSION >= 7.0)
    {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:_myTableView];
    
    [loadview startLoading];
    
    _myTableView.tableFooterView = loadview;
    
    
    _top_view = [[NewUserMessageTop alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,201)];
    
    _top_view.delegate = self;
    
    _top_view.backgroundColor = [UIColor whiteColor];//RGBCOLOR(245,245,245);
    
    _myTableView.tableHeaderView = _top_view;
    
    
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
    
}



#pragma mark-UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(_myTableView.contentOffset.y > (_myTableView.contentSize.height - _myTableView.frame.size.height+40) && _myTableView.contentOffset.y > 0 && scrollView == _myTableView)
    {
        if ([loadview.normalLabel.text isEqualToString:@"加载中..."])
        {
            return;
        }
        
        [loadview startLoading];
        
        pageCount++;
        
        [self initHttpWeiBoContent];
    }
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
////    offset = MIN(offset,100);
//    scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
//}




#pragma mark-UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (show_shangjia_jianjie?1:0)+self.data_array.count;
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!test_cell)
    {
        test_cell = [[NewWeiBoCustomCell alloc] init];
    }
    
    if (show_shangjia_jianjie)
    {
        if (indexPath.row == 0)
        {
            return shangjia_detail_view.frame.size.height + 10;
        }else
        {
            
            FbFeed * info = [self.data_array objectAtIndex:indexPath.row-1];
            return [test_cell returnCellHeightWith:info WithType:1] + 20;
        }
    }else
    {
        FbFeed * info = [self.data_array objectAtIndex:indexPath.row];
        return [test_cell returnCellHeightWith:info WithType:1] + 20;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (show_shangjia_jianjie && indexPath.row == 0)
    {
        static NSString * cell1 = @"shangjia";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.contentView addSubview:shangjia_detail_view];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    }else
    {
        static NSString * identifier = @"identifier";
        
        NewWeiBoCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[NewWeiBoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.delegate = self;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FbFeed * info = [self.data_array objectAtIndex:show_shangjia_jianjie?indexPath.row-1:indexPath.row];
        
        [cell setAllViewWithType:1];
        
        [cell setInfo:info withReplysHeight:[tableView rectForRowAtIndexPath:indexPath].size.height WithType:1];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (show_shangjia_jianjie && indexPath.row == 0)
    {
        
    }else
    {
        FbFeed * info = [self.data_array objectAtIndex:show_shangjia_jianjie?indexPath.row-1:indexPath.row];
        
        NewWeiBoDetailViewController * detail = [[NewWeiBoDetailViewController alloc] init];
        
        detail.info = info;
        
        [self.navigationController pushViewController:detail animated:YES];
    }
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


-(void)deleteing
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:@"正在删除"];
    [hud setActivity:YES];
    [hud show];
}



#pragma mark-评论转发成功

-(void)ForwardingSuccessWihtTid:(NSString *)theTid IndexPath:(int)theIndexpath SelectView:(int)theselectview WithComment:(BOOL)isComment
{
    FbFeed * _feed;
    
    
    _feed = [self.data_array objectAtIndex:theIndexpath];
    
    _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
    
    if (isComment)
    {
        _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
    }
    
    
    [self.data_array replaceObjectAtIndex:theIndexpath withObject:_feed];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
    
    NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView cellForRowAtIndexPath:indexPath];
    
    [cell setReplys:_feed.replys ForWards:_feed.forwards];
}


-(void)commentSuccessWihtTid:(NSString *)theTid IndexPath:(int)theIndexpath SelectView:(int)theselectview withForward:(BOOL)isForward
{
    FbFeed * _feed;

    _feed = [self.data_array objectAtIndex:theIndexpath];
    
    _feed.replys = [NSString stringWithFormat:@"%d",[_feed.replys intValue]+1];
    
    if (isForward)
    {
        _feed.forwards = [NSString stringWithFormat:@"%d",[_feed.forwards intValue]+1];
    }
    
    [self.data_array replaceObjectAtIndex:theIndexpath withObject:_feed];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:theIndexpath inSection:0];
    
    NewWeiBoCustomCell * cell = (NewWeiBoCustomCell *)[_myTableView cellForRowAtIndexPath:indexPath];
    
    [cell setReplys:_feed.replys ForWards:_feed.forwards];
}



#pragma mark-NewWeiBoCustomCellDelegate

-(void)showOriginalWeiBoContent:(NSString *)theTid
{
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=content&tid=%@&fromtype=b5eeec0b&authkey=%@&page=1&fbtype=json",theTid,authkey];
    
    NSLog(@"1请求的url = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
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
    NSIndexPath * theIndexpath;
    
   theIndexpath = [_myTableView indexPathForCell:theCell];
    
    ForwardingViewController * forward = [[ForwardingViewController alloc] init];
    forward.info = info;
    forward.delegate = self;
    forward.theIndexPath = theIndexpath.row;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self presentModalViewController:forward animated:YES];
}

-(void)presentToCommentControllerWithInfo:(FbFeed *)info WithCell:(NewWeiBoCustomCell *)theCell
{
    NSIndexPath * theIndexpath;
    
    theIndexpath = [_myTableView indexPathForCell:theCell];
    
    NewWeiBoCommentViewController * forward = [[NewWeiBoCommentViewController alloc] init];
    forward.info = info;
    forward.delegate = self;
    forward.tid = info.tid;
    forward.theIndexPath = theIndexpath.row;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self presentModalViewController:forward animated:YES];
}





-(void)showVideoWithUrl:(NSString *)theUrl
{
    fbWebViewController * web = [[fbWebViewController alloc] init];
    
    web.urlstring = theUrl;
        
    [self.navigationController pushViewController:web animated:YES];
}

-(void)deleteSomeWeiBoContent:(NewWeiBoCustomCell *)cell
{
    [self deleteing];
    
    NSIndexPath * indexPath = [_myTableView indexPathForCell:cell];
    
    FbFeed * fbfeed = [self.data_array objectAtIndex:show_shangjia_jianjie?indexPath.row-1:indexPath.row];
    
    NSString * string = [NSString stringWithFormat:FB_DELETEWEIBO_URL,fbfeed.tid,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    
    NSURL * fullUrl = [NSURL URLWithString:string];
    
    NSLog(@"删除微博Url ==   %@",fullUrl);
    
    ASIHTTPRequest * request1 = [ASIHTTPRequest requestWithURL:fullUrl];
    
    request1.shouldAttemptPersistentConnection = NO;
    
    __block ASIHTTPRequest * _request = request1;
    
    
    [_request setCompletionBlock:^{
        
        @try {
            [hud hide];
            
            NSDictionary * dic = [request1.responseData objectFromJSONData];
            
            NSLog(@"删除内容 -----  %@",dic);
            
            if ([[dic objectForKey:@"errcode"] intValue] !=0)
            {
                _replaceAlertView.hidden=NO;
                [_replaceAlertView hide];
            }else
            {
                [self.data_array removeObjectAtIndex:show_shangjia_jianjie?indexPath.row-1:indexPath.row];
                
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                
                [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath1] withRowAnimation:UITableViewRowAnimationRight];
                
                [_myTableView reloadData];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally {
            
        }
    }];
    
    
    [_request setFailedBlock:^{
        [hud hide];
        _replaceAlertView.hidden=NO;
        [_replaceAlertView hide];
    }];
    
    [request1 startAsynchronous];
}


-(void)clickHeadImage:(NSString *)uid
{
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    
    mine.uid = uid;
    
    [self.navigationController pushViewController:mine animated:YES];
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
        ImagesViewController * images = [[ImagesViewController alloc] init];
        images.tid = isRe?info.rphoto.aid:info.photo.aid;
        
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:images animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
        
    }else if ([string intValue] == 2)
    {
        WenJiViewController * wenji = [[WenJiViewController alloc] init];
        
        wenji.bId = sortId;
        
        [self setHidesBottomBarWhenPushed:YES];
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        
        [self.navigationController pushViewController:wenji animated:YES];
        
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

-(void)showImage:(FbFeed *)info isReply:(BOOL)isRe WithIndex:(int)index
{
    [_photos removeAllObjects];
    
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
    
    if (titleString.length == 0 || [titleString isEqual:[NSNull null]] || [titleString isEqualToString:@"(null)"])
    {
        titleString = @"";
    }
    
    
    browser.title_string = titleString;
    
    [browser setInitialPageIndex:index];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self presentModalViewController:browser animated:YES];
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


-(void)phoneTap:(UITapGestureRecognizer *)sender
{
    NSString * telephoneNum = [self.per_info.service_telphone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telephoneNum]]];
}


-(void)jianJieTap
{
    mydetailViewController * detail = [[mydetailViewController alloc] init];
    
    detail.info = _per_info;
    
    if ([_per_info.is_shangjia isEqualToString:@"1"])
    {
        detail.isShangJia = YES;
    }else
    {
        detail.isShangJia = NO;
    }
    
    [self.navigationController pushViewController:detail animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end












