//
//  mydetailViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-2-28.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "mydetailViewController.h"
#import "JSONKit.h"
#import <MapKit/MapKit.h>
@interface mydetailViewController (){
    ASIHTTPRequest *_request;
    UILabel *headerview;
}


@end

@implementation mydetailViewController
@synthesize info = _info;
@synthesize isShangJia = _isShangJia;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)getData
{
    NSString * string_sex = self.info.gender;
    
    if ([string_sex isEqualToString:@"0"])
    {
        string_sex=@"未知";
    }else if([string_sex isEqualToString:@"1"])
    {
        string_sex=@"男";
        
    }else
    {
        string_sex=@"女";
    }
    
    NSString *string_location=self.info.city;
    if ([string_location isEqualToString:@""])
    {
        string_location=@"未知";
    }
    
    array_receive  = [[NSMutableArray alloc] initWithObjects:self.info.username,string_sex,string_location,self.info.fans_count,self.info.follow_count,self.info.blog_count,self.info.album_count,self.info.circle_createcount,self.info.email,nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"mydetailViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"mydetailViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
//    UIColor * cc = [UIColor blackColor];
//
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        //iOS 5 new UINavigationBar custom background
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    UIBarButtonItem * spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    spaceBar.width = MY_MACRO_NAME?-4:5;
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,12,21.5)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    self.navigationItem.leftBarButtonItems=@[spaceBar,back_item];
    
    
    if (!self.isShangJia)
    {
        [self getData];
        
        self.navigationItem.title=@"详细资料";
        
        UIView *view_header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        headerview =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320, 20)];
        headerview.font=[UIFont systemFontOfSize:15];
        headerview.textColor = RGBCOLOR(94,94,94);
        headerview.backgroundColor=[UIColor clearColor];
        headerview.text=@"基本信息";
        [view_header addSubview:headerview];
        
        
        
        detail_tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?iphone5fram:iphone4fram) style:UITableViewStylePlain];
        detail_tab.backgroundView = nil;
        //    detail_tab.separatorColor = RGBCOLOR(226,226,226);
        detail_tab.backgroundColor=[UIColor whiteColor];//RGBCOLOR(248,248,248);
        self.view=detail_tab;
        detail_tab.tableHeaderView=view_header;
        detail_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        detail_tab.delegate=self;
        detail_tab.dataSource=self;
        
        array_all=[[NSMutableArray alloc]init];
        
        NSArray *array_1=[[NSArray alloc]initWithObjects:@"昵称", @"性别",@"所在地",nil];
        NSArray *array_2=[[NSArray alloc]initWithObjects:@"粉丝",@"关注",@"文集",@"画廊",@"圈子",@"邮箱",nil];
        [array_all addObject:array_1];
        [array_all addObject:array_2];
        
    }else
    {
        self.navigationItem.title=@"企业主业";
        
        [self setQiYeView];
    }
}


-(void)setQiYeView
{
    //名称简介
    
    userLatitude = 0;
    userlongitude = 0;
    
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:scrollView];
    
    
    float height = 0;
    
    CGRect jianjie_frame = CGRectMake(23/2,25/2,297,10);
    
    UIImageView * jianjie_view = [[UIImageView alloc] initWithFrame:jianjie_frame];
    
    jianjie_view.userInteractionEnabled = YES;
    [scrollView addSubview:jianjie_view];
    
    
    UILabel * name_label = [[UILabel alloc] initWithFrame:CGRectMake(5,10,594/2-10,20)];
    
    name_label.text = self.info.service_shopname;
    
    name_label.backgroundColor = [UIColor clearColor];
    
    name_label.textColor = RGBCOLOR(70,86,132);
    
    name_label.textAlignment = NSTextAlignmentLeft;
    
    [jianjie_view addSubview:name_label];
    
    
    RTLabel * jianjie_label = [[RTLabel alloc] initWithFrame:CGRectMake(5,30,594/2-10,10)];
    
    jianjie_label.lineBreakMode = NSLineBreakByCharWrapping;
    
    jianjie_label.lineSpacing = 3;
    
    jianjie_label.backgroundColor = [UIColor clearColor];
    
    jianjie_label.font = [UIFont systemFontOfSize:15];
    
    jianjie_label.text = self.info.service_content;
    
    CGSize optimumSize = [jianjie_label optimumSize];
    
    height = optimumSize.height;
    
    jianjie_label.frame = CGRectMake(5,30,594/2-10,height);
    
    [jianjie_view addSubview:jianjie_label];
    
    jianjie_frame.size.height = height + 30 + 10;
    
    jianjie_view.frame = jianjie_frame;
    
    jianjie_view.image = [[UIImage imageNamed:@"jianjiebackimage.png"] stretchableImageWithLeftCapWidth:130 topCapHeight:7];
    
    
    //地图
    
    
    CGRect ditu_back_frame = CGRectMake(23/2,jianjie_frame.origin.y+jianjie_frame.size.height+21/2,297,10);
    
    UIImageView * ditu_back = [[UIImageView alloc] initWithFrame:ditu_back_frame];
    ditu_back.userInteractionEnabled = YES;
    [scrollView addSubview:ditu_back];
    
    
    
    myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(5,8,287,94)];
    
    myMapView.mapType=MKMapTypeStandard;
    
    myMapView.delegate=self;
    
    myMapView.showsUserLocation=NO;
    
    [ditu_back addSubview:myMapView];
    
    
    UITapGestureRecognizer * map_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowMapView:)];
    
    [myMapView addGestureRecognizer:map_tap];
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
    region.span=span;
    region.center=CLLocationCoordinate2DMake([self.info.service_lat doubleValue],[self.info.service_lng doubleValue]);//[userLocation coordinate];
    
    [myMapView setRegion:region animated:YES];
    
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = region.center;
    [ann setTitle:self.info.service_shopname];
    [ann setSubtitle:self.info.service_address];
    //触发viewForAnnotation
    [myMapView addAnnotation:ann];
    
    
    
    UILabel * gongsidizhi = [[UILabel alloc] initWithFrame:CGRectMake(5,112,80,20)];
    
    gongsidizhi.text = @"公司地址:";
    
    gongsidizhi.textColor = RGBCOLOR(71,86,132);
    
    gongsidizhi.font = [UIFont systemFontOfSize:16];
    
    gongsidizhi.backgroundColor = [UIColor clearColor];
    
    gongsidizhi.textAlignment = NSTextAlignmentLeft;
    
    [ditu_back addSubview:gongsidizhi];
    
    
    CGRect dizhi_label_frame = CGRectMake(80,113,210,10);
    
    RTLabel * dizhi_label = [[RTLabel alloc] initWithFrame:dizhi_label_frame];
    
    dizhi_label.lineBreakMode = NSLineBreakByCharWrapping;
    
    dizhi_label.font = [UIFont systemFontOfSize:15];
    
    dizhi_label.text = self.info.service_address;
    
    [ditu_back addSubview:dizhi_label];
    
    
    CGSize optimumSize11 = [dizhi_label optimumSize];
    dizhi_label_frame.size.height = optimumSize11.height;
    dizhi_label.frame = dizhi_label_frame;
    
    
    ditu_back_frame.size.height = dizhi_label_frame.origin.y + optimumSize11.height + 10;
    
    ditu_back.frame = ditu_back_frame;
    
    ditu_back.image = [[UIImage imageNamed:@"jianjiebackimage.png"] stretchableImageWithLeftCapWidth:130 topCapHeight:7];
    
    
    
    UIImageView * phone_imageview = [[UIImageView alloc] initWithFrame:CGRectMake(23/2,ditu_back_frame.origin.y+ditu_back_frame.size.height+23/2,594/2,40)];
    phone_imageview.userInteractionEnabled = YES;
    phone_imageview.image = [UIImage imageNamed:@"jianjiebackimage.png"];
    
    [scrollView addSubview:phone_imageview];
    
    
    UIImageView * dianhua_tubiao = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,23,23)];
    
    dianhua_tubiao.center = CGPointMake(8+23/2,phone_imageview.frame.size.height/2);
    
    dianhua_tubiao.backgroundColor = [UIColor grayColor];
    
    dianhua_tubiao.layer.cornerRadius = 2;
    
    dianhua_tubiao.image = [UIImage imageNamed:@"telephoto.png"];
    
    [phone_imageview addSubview:dianhua_tubiao];
    
    
    
    UILabel * gongsidianhua = [[UILabel alloc] initWithFrame:CGRectMake(40,5,80,30)];
    
    gongsidianhua.textColor = RGBCOLOR(70,86,132);
    
    gongsidianhua.text = @"公司电话:";
    
    gongsidianhua.backgroundColor = [UIColor clearColor];
    
    gongsidianhua.textAlignment = NSTextAlignmentLeft;
    
    [phone_imageview addSubview:gongsidianhua];
    
    
    UILabel * telephone_content_label = [[UILabel alloc] initWithFrame:CGRectMake(120,5,140,30)];
    
    telephone_content_label.text = self.info.service_telphone;
    
    telephone_content_label.textAlignment = NSTextAlignmentLeft;
    
    telephone_content_label.textColor = [UIColor blackColor];
    
    telephone_content_label.backgroundColor = [UIColor clearColor];
    
    [phone_imageview  addSubview:telephone_content_label];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callSomeBody:)];
    
    [telephone_content_label addGestureRecognizer:tap];
    
    
    scrollView.contentSize = CGSizeMake(0,phone_imageview.frame.origin.y+phone_imageview.frame.size.height+80);
    
}


-(void)callSomeBody:(UITapGestureRecognizer *)button
{
    NSString * telephoneNum = [self.info.service_telphone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telephoneNum]]];
}


#pragma mark-返回上一级
-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark-发送请求网络数据，接收网络数据
-(void)senddetailrequest
{
    if (!_request)
    {
        _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:@"http://fb.fblife.com/openapi/index.php?mod=getuser&code=base&uid=363376&linkfrom=fbMember&fbtype=json"]];
    }
    _request.delegate=self;
    [_request startAsynchronous];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary*dic_=[[NSDictionary alloc]init];
    
    NSData *data=[request responseData];
    NSString *string_=[request responseString];
    NSLog(@"string_==%@",string_);
    dic_=[data objectFromJSONData];
    NSLog(@"dic==%@",dic_);
    
    NSDictionary *dic_detail=(NSDictionary *)[[dic_ objectForKey:@"data"]objectForKey:@"363376"];
    
    
    NSString *string_username=(NSString *)[dic_detail objectForKey:@"username"];
    
    NSString *string_sex=(NSString *)[dic_detail objectForKey:@"gender"];
    
    if ([string_sex isEqualToString:@"0"]) {
        string_sex=@"未知";
    }else if([string_sex isEqualToString:@"1"]){
        string_sex=@"男";
        
    }else{
        string_sex=@"女";
    }
    NSString *string_location=[dic_detail objectForKey:@"city"];
    if ([string_location isEqualToString:@""]) {
        string_location=@"未知";
    }
    NSString *string_jianjie=[dic_detail objectForKey:@"aboutme"];
    if ([string_jianjie isEqualToString:@""]) {
        string_jianjie=@"这个人很懒，什么都没留下";
    }
    NSMutableArray *array_section1=[[NSMutableArray alloc]initWithObjects:string_username,string_sex,string_location,string_jianjie, nil];
    
    
    NSString *string_fans=[dic_detail objectForKey:@"fans_count"];
    NSString *string_email=[dic_detail objectForKey:@"email"];
    NSMutableArray *array_section2=[[NSMutableArray alloc]initWithObjects:string_fans,self.info.follow_count,self.info.blog_count,self.info.album_count,self.info.circle_createcount,string_email, nil];
    
    [array_receive removeAllObjects];
    [array_receive addObject:array_section1];
    [array_receive addObject:array_section2];
    
    
    
    
    //    NSString *stringname=[dic_ objectForKey:@"username"];
    NSLog(@"dic==%@   detail=%@",dic_,dic_detail);
    [detail_tab reloadData];
    
    
    
}
#pragma  mark-tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 3;
    }else{
        return 6;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string_identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string_identifier];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string_identifier];
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5,0,297,44)];
    
    imageView.image = [UIImage imageNamed:@"jianjiebackimage.png"];
    
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:imageView];
    
    
    label_content=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 44)];
    label_content.text=[[array_all objectAtIndex:indexPath.section ]objectAtIndex:indexPath.row];
    label_content.backgroundColor=[UIColor clearColor];
    label_content.textColor = RGBACOLOR(76,76,76,1);
    label_content.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:label_content];
    
    if (array_receive.count != 0)
    {
        label_receive=[[UILabel alloc]initWithFrame:CGRectMake(85, 0, 320-85, 44)];
        label_receive.textAlignment=NSTextAlignmentLeft;
        label_receive.font=[UIFont systemFontOfSize:15];
        label_receive.textColor = RGBACOLOR(12,12,12,1);
        label_receive.numberOfLines=0;
        
        label_receive.text= [array_receive objectAtIndex:indexPath.section * 3 + indexPath.row];
        [cell.contentView addSubview:label_receive];
        label_receive.backgroundColor=[UIColor clearColor];
        
    }
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,35)];
    
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 10;
    }else
    {
        return 35;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [detail_tab deselectRowAtIndexPath:[detail_tab indexPathForSelectedRow] animated:YES];
    
}




#pragma mark-MapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLatitude=userLocation.coordinate.latitude;
    userlongitude=userLocation.coordinate.longitude;
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
    region.span=span;
    region.center=CLLocationCoordinate2DMake([self.info.service_lat doubleValue],[self.info.service_lng doubleValue]);//[userLocation coordinate];
    
    [myMapView setRegion:region animated:YES];
}

-(void)ShowMapView:(UITapGestureRecognizer *)sender
{
    FBMapViewController * mapView = [[FBMapViewController alloc] init];
    
    mapView.info = self.info;
    
    [self.navigationController pushViewController:mapView animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
