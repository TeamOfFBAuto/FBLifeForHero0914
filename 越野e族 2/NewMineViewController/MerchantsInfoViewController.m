//
//  MerchantsInfoViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-23.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "MerchantsInfoViewController.h"

@interface MerchantsInfoViewController ()

@end

@implementation MerchantsInfoViewController
@synthesize uid = _uid;
@synthesize myTableView = _myTableView;
@synthesize data_array = _data_array;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}



-(void)initHttpRequest
{
    NSString * authkey = [[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString * _theUrl = [NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=service&code=getservice&uid=%@&fromtype=b5eeec0b&authkey=%@&page=%d&ps=10&fbtype=json",_uid,authkey,pageCount];
    
    NSLog(@"请求资讯url ---  %@",_theUrl);
    
    request_ = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:_theUrl]];
    
    request_.delegate = self;
    
    request_.shouldAttemptPersistentConnection = NO;
    
    [request_ startAsynchronous];    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary * dic = [request.responseData objectFromJSONData];
    
    NSString * errcode = [dic objectForKey:@"errcode"];
    
    if ([errcode intValue] == 0)
    {
        NSDictionary * data = [dic objectForKey:@"data"];
        
        NSArray * array = [data allValues];
        
        
        for (NSDictionary * dic1 in array)
        {
            ShangJiaNewsInfo * info = [[ShangJiaNewsInfo alloc] initWithDic:dic1];
            
            [self.data_array addObject:info];
        }
        
        
        [_myTableView reloadData];
    }

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    
}

-(void)backH:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"MerchantsInfoViewController"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"MerchantsInfoViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data_array = [[NSMutableArray alloc] init];
    
    pageCount = 1;
    
    [self initHttpRequest];
    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        //iOS 5 new UINavigationBar custom background
//        
//        if (IOS_VERSION>=7.0)
//        {
//            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS7DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//        }else
//        {
//            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//        }
//    }
//    
//    
//    UIButton * back_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    back_button.frame = CGRectMake(0,0,12,21.5);
//    
//    [back_button setImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    [back_button addTarget:self action:@selector(backH:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back_button];
    
    
    self.navigationItem.title = @"资讯";
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
	
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num = self.data_array.count%2?self.data_array.count/2+1:self.data_array.count/2;
    return num;

}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106.5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    MerchantsInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[MerchantsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    [cell setAllView];
    
    
    if (indexPath.row*2 < self.data_array.count)
    {
        ShangJiaNewsInfo * info = [self.data_array objectAtIndex:indexPath.row*2];
        [cell.imageView1 loadImageFromURL:info.photo withPlaceholdImage:nil];
        
        cell.titleLabel1.text = info.title;
    }
    
    if (indexPath.row*2+1 < self.data_array.count)
    {
        ShangJiaNewsInfo * info = [self.data_array objectAtIndex:indexPath.row*2+1];
        [cell.imageView2 loadImageFromURL:info.photo withPlaceholdImage:nil];
        cell.titleLabel2.text = info.title;
    }
    
    
    return cell;
}


-(void)clickImageWithIndex:(int)index Cell:(MerchantsInfoCell *)cell
{
    NSIndexPath * indexPath = [_myTableView indexPathForCell:cell];
    
    int num = indexPath.row*2+index;
    
    ShangJiaNewsInfo * info = [self.data_array objectAtIndex:num];
    
    
    fbWebViewController * web = [[fbWebViewController alloc] init];
    
    web.urlstring = info.link;
    
    [self.navigationController pushViewController:web animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end















