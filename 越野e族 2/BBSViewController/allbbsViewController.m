//
//  allbbsViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-5.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "allbbsViewController.h"
#import "JSONKit.h"
#import "BBSfenduiViewController.h"
@interface allbbsViewController (){
    ASIHTTPRequest *_request;
    BBSfenduiViewController *fendui;
}

@end

@implementation allbbsViewController
@synthesize string_zhuti,zhutitag;

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
    [super viewDidLoad];
    //
    array_name=[[NSMutableArray alloc]init];
    array_gid=[[NSMutableArray alloc]init];
    array_section=[[NSMutableArray alloc]init];
    array_row=[[NSMutableArray alloc]init];
    array_detail=[[NSMutableArray alloc]init];
    array_IDrow=[[NSMutableArray alloc]init];
    array_IDdetail=[[NSMutableArray alloc]init];
    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10, 8, 32, 28)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"bc@2x.png"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    self.navigationItem.leftBarButtonItem=back_item;
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
//        //iOS 5 new UINavigationBar custom background
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS7DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [refreshButton setImage:[UIImage imageNamed:@"weibo_right@2x.png"] forState:UIControlStateNormal];
//    refreshButton.frame = CGRectMake(0,0,32,28);
//    refreshButton.center = CGPointMake(300,20);
//    refreshButton.backgroundColor=[UIColor redColor];
//    [refreshButton addTarget:self action:@selector(sendrequesttest) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    
    
    
    
    //
   
    //
    UIButton *button_comment;
        button_comment=[[UIButton alloc]initWithFrame:CGRectMake(265, 8, 41/2, 39/2)];
        

    button_comment.tag=26;
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(sendrequesttest) forControlEvents:UIControlEventTouchUpInside];
    [button_comment setBackgroundImage:[UIImage imageNamed:@"ios7_refresh4139.png"] forState:UIControlStateNormal];
    button_comment.userInteractionEnabled=NO;
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
              [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
        
    }
    //  self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:73 green:73 blue:72 alpha:1];
    
    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, 3, 12, 43/2)];
    
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    self.navigationItem.leftBarButtonItem=back_item;
    
    
    
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    space.width = MY_MACRO_NAME?-4:5;
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:button_comment];
    
    self.navigationItem.rightBarButtonItems=@[space,comment_item];
    //  self.navigationItem.title=@"新闻中心";
    
    self.navigationItem.title = @"论坛";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;

    

//
    
    UIView *aview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568:480)];
    self.view=aview;
    tab_=[[UITableView alloc]initWithFrame:CGRectMake(178/2, 5, 436/2, iPhone5?568-19-50:480-19-50) style:UITableViewStylePlain];
    tab_.delegate=self;
    tab_.dataSource=self;
    tab_.backgroundView=[[UIView alloc]init];
    tab_.backgroundColor=[UIColor clearColor];
    tab_.separatorColor=[UIColor clearColor];
    tab_.showsHorizontalScrollIndicator=NO;
    tab_.showsVerticalScrollIndicator=NO;
    [aview addSubview:tab_];
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [aview addSubview:hud.view];
    }
    //左边的主题栏
    
    selected_array=[[NSMutableArray alloc]init];
    unselected_array=[[NSMutableArray alloc]init];
    zhutiarray=[[NSArray alloc]initWithObjects:@"quanbu",@"diqu",@"chexing",@"zhuti",@"jiaoyi", nil];
    
    for (int i=0; i<5; i++) {
        
        NSString *string_selected=[NSString stringWithFormat:@"11%d_1.png",i];
        NSString *string_unselected=[NSString stringWithFormat:@"11%d.png",i];
        NSLog(@"sr=%@",string_selected);
        NSLog(@"sr=%@",string_unselected);
        
        [selected_array addObject:string_selected];
        [unselected_array addObject:string_unselected];
        
        UIButton *button_zhuti=[[UIButton alloc]initWithFrame:CGRectMake(0, i*160/2, 166/2, 159/2)];
        
        if (i==self.zhutitag-100) {
            button_zhuti.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:string_selected]];
        }else{
            button_zhuti.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:string_unselected]];
            
        }
        button_zhuti.tag=i+200;
        [button_zhuti addTarget:self action:@selector(changezhuti:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button_zhuti];
        
    }
    
    NSLog(@"arrayse===%@\narray_img=%@",selected_array,unselected_array);
    
    UIImageView *bg_view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 160*2.5, 166/2, 240)];
    bg_view.image=[UIImage imageNamed:@"ios7allbbs_166_159.png"];
    [aview addSubview:bg_view];
    aview.backgroundColor=[UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
    
    UIButton *buttoncurrenge=(UIButton *)[self.view viewWithTag:self.zhutitag-100+200];
    
    [self changezhuti:buttoncurrenge];
    
	// Do any additional setup after loading the view.
}
#pragma mark-转换主题
-(void)changezhuti:(UIButton *)sender{
    NSArray *bbsinfo_array;
    NSLog(@"%stag=%d",__FUNCTION__,sender.tag);
    
    for (int i=0; i<1000; i++) {
        mark[i]=0;
    }
    for (int i=0; i<1000; i++) {
        for (int j=0; j<1000; j++) {
            isexpanded[i][j]=0;
        }
    }
    [array_name removeAllObjects];
    [array_gid removeAllObjects];
    
    [array_section removeAllObjects];
    [array_row removeAllObjects];
    [array_detail removeAllObjects];
    [array_IDrow removeAllObjects];
    [array_IDdetail removeAllObjects];
    
    
    self.string_zhuti=[NSString stringWithFormat:@"%@",[zhutiarray objectAtIndex:sender.tag-200]];
    
    
    NSLog(@"zhuti=%@",self.string_zhuti);
    
    NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
    NSString *stringhave=[NSString stringWithFormat:@"%@",[standarduser objectForKey:@"youshuju"]];
    
    
    
    switch (sender.tag) {
        case 200:{
            NSLog(@"quanbu?");
            sender.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[selected_array objectAtIndex:0]]];
            
            UIButton *button1=(UIButton *)[self.view viewWithTag:201];
            button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:1]]];
            
            UIButton *button2=(UIButton *)[self.view viewWithTag:202];
            button2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:2]]];
            
            UIButton *button3=(UIButton *)[self.view viewWithTag:203];
            button3.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:3]]];
            
            UIButton *button4=(UIButton *)[self.view viewWithTag:204];
            button4.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:4]]];
            
            // [standarduser setObject:@"yijingyoushujule" forKey:@"youshuju"];
            
            if (stringhave.length>6) {
                NSLog(@"缓存读取数据");
                
                bbsinfo_array=[standarduser objectForKey:@"quanbuinfo"];
                NSLog(@"全部的info=%@",bbsinfo_array);
                
            }else{
                NSLog(@"网路获取数据");
                [self sendrequesttest];
            }
            
        }
            break;
        case 201:{
            sender.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[selected_array objectAtIndex:1]]];
            UIButton *button1=(UIButton *)[self.view viewWithTag:200];
            button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:0]]];
            UIButton *button2=(UIButton *)[self.view viewWithTag:202];
            button2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:2]]];
            UIButton *button3=(UIButton *)[self.view viewWithTag:203];
            button3.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:3]]];
            UIButton *button4=(UIButton *)[self.view viewWithTag:204];
            button4.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:4]]];
            
            
            if (stringhave.length>6) {
                NSLog(@"缓存读取数据");
                
                bbsinfo_array=[standarduser objectForKey:@"diquinfo"];
                
            }else{
                NSLog(@"网路获取数据");
                [self sendrequesttest];
            }
            
            
        }
            break;
        case 202:{
            sender.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[selected_array objectAtIndex:2]]];
            UIButton *button1=(UIButton *)[self.view viewWithTag:200];
            button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:0]]];
            UIButton *button2=(UIButton *)[self.view viewWithTag:201];
            button2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:1]]];
            UIButton *button3=(UIButton *)[self.view viewWithTag:203];
            button3.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:3]]];
            UIButton *button4=(UIButton *)[self.view viewWithTag:204];
            button4.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:4]]];
            
            if (stringhave.length>6) {
                NSLog(@"缓存读取数据");
                
                bbsinfo_array=[standarduser objectForKey:@"chexinginfo"];
                
            }else{
                NSLog(@"网路获取数据");
                [self sendrequesttest];
            }
            
            
            
        }
            break;
        case 203:{
            sender.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[selected_array objectAtIndex:3]]];
            UIButton *button1=(UIButton *)[self.view viewWithTag:201];
            button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:1]]];
            UIButton *button2=(UIButton *)[self.view viewWithTag:202];
            button2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:2]]];
            UIButton *button3=(UIButton *)[self.view viewWithTag:200];
            button3.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:0]]];
            UIButton *button4=(UIButton *)[self.view viewWithTag:204];
            button4.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:4]]];
            
            if (stringhave.length>6) {
                NSLog(@"缓存读取数据");
                
                bbsinfo_array=[standarduser objectForKey:@"zhutiinfo"];
                
            }else{
                NSLog(@"网路获取数据");
                [self sendrequesttest];
            }
            
            
        }
            break;
        case 204:{
            
            sender.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[selected_array objectAtIndex:4]]];
            UIButton *button1=(UIButton *)[self.view viewWithTag:201];
            button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:1]]];
            UIButton *button2=(UIButton *)[self.view viewWithTag:202];
            button2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:2]]];
            UIButton *button3=(UIButton *)[self.view viewWithTag:200];
            button3.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:0]]];
            UIButton *button4=(UIButton *)[self.view viewWithTag:203];
            button4.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[unselected_array objectAtIndex:3]]];
            
            if (stringhave.length>6) {
                NSLog(@"缓存读取数据");
                
                bbsinfo_array=[standarduser objectForKey:@"jiaoyiinfo"];
                
            }else{
                NSLog(@"网路获取数据");
                [self sendrequesttest];
            }
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    if (stringhave.length>6) {
        NSLog(@"缓存读取数据");
        
        for (int i=0; i<bbsinfo_array.count; i++) {
            NSDictionary *section_dic=[bbsinfo_array objectAtIndex:i];
            NSString *string_section=[section_dic objectForKey:@"name"];
            [array_section addObject:string_section];//找到了所有的section的header;
            
            NSArray *sub1_array=[section_dic objectForKey:@"sub"];//可以找到所有section里面的内容
            NSMutableArray *row_array=[[NSMutableArray alloc]init];
            NSMutableArray *idrow_array=[[NSMutableArray alloc]init];
            NSMutableArray *array_zuixiao=[[NSMutableArray alloc]init];
            NSMutableArray *array_zuixiaoid=[[NSMutableArray alloc]init];
            
            for (int i=0; i<sub1_array.count; i++) {
                NSDictionary *row_dic=[sub1_array objectAtIndex:i];
                NSString *row_string=[row_dic objectForKey:@"name"];
                [row_array addObject:row_string];//某一个section里面的row的具体内容
                NSString *idrowstring=[row_dic objectForKey:@"fid"];
                [idrow_array addObject:idrowstring];
                
                
                NSArray *sub2=[row_dic objectForKey:@"sub"];//找到所有的row里面的对应的具体分队
                NSMutableArray *array_lu=[[NSMutableArray alloc]init];
                NSMutableArray *array_idlu=[[NSMutableArray alloc]init];
                for (int i=0; i<sub2.count; i++) {
                    NSDictionary *zuixiao_dic=[sub2 objectAtIndex:i];
                    NSString *zuixiaostring=[zuixiao_dic objectForKey:@"name"];
                    [array_lu addObject:zuixiaostring];
                    
                    NSString *zuixiaostringid=[zuixiao_dic objectForKey:@"fid"];
                    [array_idlu addObject:zuixiaostringid];
                }
                [array_zuixiao addObject:array_lu];
                [array_zuixiaoid addObject:array_idlu];
            }
            [array_row addObject:row_array];//这样就可以取到所有的section里面的row的具体内容
            [array_IDrow addObject:idrow_array];//这样就可以取到所有的section里面的row的id
            
            
            [array_detail addObject:array_zuixiao];
            [array_IDdetail addObject:array_zuixiaoid];
        }
        
        
        [tab_ reloadData];
        
        
    }else{
        NSLog(@"网路获取数据");
        //        [self sendrequesttest];
    }
    
    
    
    
    // [self sendrequesttest];
    
    
}
-(void)backto{
    [_request cancel];
    _request.delegate=nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"allbbsViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"allbbsViewController"];
}
#pragma mark-数据部分
//-(void)sendallbbsrequest{
//    ASIHTTPRequest *_request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:@"http://bbs.fblife.com/bbsapinew/getforums.php?type=index&formattype=json"]];
//    _request.tag=999;
//    _request.delegate=self;
//    [_request startAsynchronous];
//}
-(void)sendrequesttest{
    NSLog(@"fasongle===主题=%@",self.string_zhuti);
    
    NSString *string_authcode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    NSLog(@"code==%@",string_authcode);
    if ([string_authcode isEqualToString:@"(null)"]) {
        string_authcode=@"";
    }
    NSLog(@"string_authcode====%@",string_authcode);
    
    //    if ([self.string_zhuti isEqualToString:@"quanbu"]) {
    //        NSLog(@"点击的是全部");
    //
    //        _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforums.php?type=all&formattype=json&authcode=%@",string_authcode]]];
    //
    //        NSString *string_quanbu= [NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforums.php?type=all&formattype=json&authcode=%@",string_authcode];
    //        NSLog(@"quanbu%@",string_quanbu);
    //
    //        _request.tag=1024;
    //        _request.delegate=self;
    //        [_request startAsynchronous];
    //    }else{
    //        _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",self.string_zhuti,string_authcode]]];
    //
    //        NSString *string_url=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authcode=%@",self.string_zhuti,string_authcode];
    //        NSLog(@"q=请求的地址为=%@",string_url);
    //
    //        _request.tag=1024;
    //        _request.delegate=self;
    //        [_request startAsynchronous];
    //    }
    //
    
    
    //testall
    _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforums.php?type=all&formattype=json&authcode=%@",string_authcode]]];
    
    NSString *string_quanbu= [NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforums.php?type=all&formattype=json&authcode=%@",string_authcode];
    NSLog(@"quanbu%@",string_quanbu);
    
    _request.tag=1024;
    _request.delegate=self;
    [_request startAsynchronous];
    
    
    
    
    _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"diqu",string_authcode]]];
    
    _request.tag=1025;
    _request.delegate=self;
    [_request startAsynchronous];
    
    _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"chexing",string_authcode]]];
    
    _request.tag=1026;
    _request.delegate=self;
    [_request startAsynchronous];
    
    _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"zhuti",string_authcode]]];
    
    _request.tag=1027;
    _request.delegate=self;
    [_request startAsynchronous];
    
    _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"jiaoyi",string_authcode]]];
    
    _request.tag=1028;
    _request.delegate=self;
    [_request startAsynchronous];
    
    
    
    
    
    
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    @try {
        
        NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
        tab_.userInteractionEnabled=YES;
        
        
        NSData *data=[request responseData];
        NSDictionary *dic_test=[[NSDictionary alloc]init];
        dic_test = [data objectFromJSONData];
        NSLog(@"alldic==%@",dic_test);
        [array_section removeAllObjects];
        NSArray *bbsinfo_array=[dic_test objectForKey:@"bbsinfo"];
        switch (request.tag) {
            case 1024:
            {
                
                [standarduser setObject:bbsinfo_array forKey:@"quanbuinfo"];
                [standarduser synchronize];
                isloadsuccess[0]=1;
                break;
            case 1025:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"diquinfo"];
                    [standarduser synchronize];
                    isloadsuccess[1]=1;
                    
                }
                break;
            case 1026:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"chexinginfo"];
                    [standarduser synchronize];
                    isloadsuccess[2]=1;
                }
                break;
            case 1027:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"zhutiinfo"];
                    [standarduser synchronize];
                    isloadsuccess[3]=1;
                }
                break;
            case 1028:
                {
                    [standarduser setObject:bbsinfo_array forKey:@"jiaoyiinfo"];
                    [standarduser synchronize];
                    isloadsuccess[4]=1;
                    
                    
                }
                break;
                
                
            default:
                break;
            }
                
        }
        
        if (isloadsuccess[0]==1&isloadsuccess[1]==1&isloadsuccess[2]==1&isloadsuccess[3]==1&isloadsuccess[4]==1)
        {
            
            [standarduser setObject:@"yijingyoushujule" forKey:@"youshuju"];
            
            [self viewDidLoad];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
   
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"error");
}
#pragma mark-tableview的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [array_section count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    
    return   mark[sectionP] ? [[array_row objectAtIndex:sectionP]count]:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *idetifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idetifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifier];
    }
    for (UIView *aview in cell.contentView.subviews) {
        [aview removeFromSuperview];
    }
    //    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    if (isexpanded[indexPath.section][indexPath.row]) {
        
        
        
        
        
        subsectionview *aview=[[subsectionview alloc]initWithFrame:CGRectMake(-20, 0, 320,[personal returnHeight:[[array_detail objectAtIndex:indexPath.section]objectAtIndex:indexPath.row-1]])];
        aview.buttonselectdelegate=self;
        if (indexPath.row-1>=0) {
            
            aview.array_name=[[array_detail objectAtIndex:indexPath.section]objectAtIndex:indexPath.row-1];
            aview.array_id=[[array_IDdetail objectAtIndex:indexPath.section]objectAtIndex:indexPath.row-1];
        }
        
        [cell.contentView addSubview:aview];
        
        
    }else{
        UILabel *label_test=[[UILabel alloc]initWithFrame:CGRectMake(-20, 0, 300, 45)];
        label_test.text=[NSString stringWithFormat:@"          %@",[[array_row objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
        label_test.font=[UIFont systemFontOfSize:13];
        label_test.textColor=[UIColor colorWithRed:77/255.f green:77/255.f blue:77/255.f alpha:1];
        
        
        
        
        UIImageView *imagexian=[[UIImageView alloc]initWithFrame:CGRectMake(0,44, 320-70, 0.5)];
        
        
        if (isexpanded[indexPath.section][indexPath.row+1]) {
//            imagexian.backgroundColor=[UIColor redColor];
            imagexian.frame=CGRectMake(20, 44-7.5, 436/2, 7.5);
            imagexian.image=[UIImage imageNamed:@"ios7_sanjiaolan.png"];
            
        }else{
            imagexian.image=[UIImage imageNamed:@"1-478-1.png"];

        }
        
        [label_test addSubview:imagexian];
        
        
        
        [cell.contentView addSubview:label_test];
        
        if ([[[array_detail objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] count]>0) {
            UIButton *button_=[[UIButton alloc]initWithFrame:CGRectMake(150, 0, 90, 45)];
            UIImageView *littlebuttonimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 6)];
            littlebuttonimg.center=CGPointMake(45, 22.5);
            [button_ addSubview:littlebuttonimg];
        
            [cell.contentView addSubview:button_];
            button_.tag=indexPath.section*1000+indexPath.row;
            if (!isexpanded[indexPath.section][indexPath.row+1]) {
                
               // [button_ setBackgroundImage:[UIImage imageNamed:@"rightpull90_45.png"] forState:UIControlStateNormal];
                littlebuttonimg.image=[UIImage imageNamed:@"ios7_bbs_down20_12.png"];

            }else{
                littlebuttonimg.image=[UIImage imageNamed:@"ios7_bbs_up20_12.png"];


             //   [button_ setBackgroundImage:[UIImage imageNamed:@"downpull90_45.png"] forState:UIControlStateNormal];
            }
            
            [button_ addTarget:self action:@selector(testbutton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)testbutton:(UIButton *)sender{
    int section=sender.tag/1000;
    int row=sender.tag%1000;
    
    for (int i=0; i<1000; i++) {
        for (int j=0; j<1000; j++) {
            if (j!=row+1&&isexpanded[i][j]==1) {//如果不是当前选的，并且上一次是加了一行的，干掉，如果是下面的直接没有关系，如果是上面的，要减掉一
                NSLog(@"点击的是第个%dsection中的第%d个row",section+1,row+1);
                
                NSLog(@"我日说好的不对呢？i=%d\nj=%d",i,j);
                NSLog(@"array_row=%@",array_row);
                isexpanded[i][j]=0;
                
                NSLog(@"j-1===%@\n j====%@\n  j+1=%@",[[array_row objectAtIndex:section] objectAtIndex:j-1],[[array_row objectAtIndex:section] objectAtIndex:j],[[array_row objectAtIndex:section] objectAtIndex:j+1]);
                
                NSLog(@"array_row=%@",array_row);
                
                [[array_row objectAtIndex:i]removeObjectAtIndex:j];
                [[array_IDrow objectAtIndex:i]removeObjectAtIndex:j];
                
                [[array_detail objectAtIndex:i]removeObjectAtIndex:j];
                [[array_IDdetail objectAtIndex:i]removeObjectAtIndex:j];
                NSLog(@"array_row=%@",array_row);
                
                
                NSLog(@"j-1===%@\n j====%@\n  j+1=%@",[[array_row objectAtIndex:i] objectAtIndex:j-1],[[array_row objectAtIndex:i] objectAtIndex:j],[[array_row objectAtIndex:i] objectAtIndex:j+1]);
                if (row>j) {
                    row--;
                    
                }
                
            }
            
            
        }
    }
    
    
    
    if (!isexpanded[section][row+1]) {
        NSLog(@"charu");
        
        [[array_row objectAtIndex:section]insertObject:@"0" atIndex:row+1];
        [[array_IDrow objectAtIndex:section]insertObject:@"99999" atIndex:row+1];
        
        
        NSArray *array_null=[[NSArray alloc]init];
        [[array_detail objectAtIndex:section] insertObject:array_null atIndex:row+1];
        [[array_IDdetail objectAtIndex:section] insertObject:array_null atIndex:row+1];
        
    }else{
        NSLog(@"shanchu");
        [[array_row objectAtIndex:section]removeObjectAtIndex:row+1];
        [[array_IDrow objectAtIndex:section]removeObjectAtIndex:row+1];
        
        [[array_detail objectAtIndex:section]removeObjectAtIndex:row+1];
        [[array_IDdetail objectAtIndex:section]removeObjectAtIndex:row+1];
        
    }
    
    isexpanded[section][row+1]=!isexpanded[section][row+1];
    //    NSRange range = NSMakeRange(section,1);
    //    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    //    [tab_ reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
    [tab_ reloadData];
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *string_=[NSString string];
    if (array_section.count>section) {
        string_=[array_section objectAtIndex:section];
    }
    return string_;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isexpanded[indexPath.section][indexPath.row]) {
        
        return  [personal returnHeight:[[array_detail objectAtIndex:indexPath.section]objectAtIndex:indexPath.row-1]];
        
    }else{
        return 45;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320-80,35)];
    
    UIView *allview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    view.tag = section+100;
    NSLog(@"%@",array_section);
    
    view.text=[NSString stringWithFormat:@"    %@",[array_section objectAtIndex:section]];
    view.textColor=[UIColor colorWithRed:2/255.f green:2/255.f blue:2/255.f alpha:1];
    view.font=[UIFont systemFontOfSize:16];
    view.userInteractionEnabled=YES;
    
    view.backgroundColor=[UIColor whiteColor];
    
    CALayer *l = [view layer];   //获取ImageView的层
    [l setMasksToBounds:YES];
    [l setCornerRadius:2.0];
    
    view.layer.borderWidth = 0.5;
    
    view.layer.borderColor = [(UIColor *)RGBCOLOR(235,235,235) CGColor];

    
    UIImageView *imageview_little=[[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 10, 6)];
    
    UIImageView *labbel_li=[[UIImageView alloc]initWithFrame:CGRectMake(185, 13, 10, 6)];
   // labbel_li.text=@"展开";
   // labbel_li.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios7_bbs_down20_12.png"]];
//    labbel_li.textColor=[UIColor lightGrayColor];
//    labbel_li.font=[UIFont systemFontOfSize:12];
//    labbel_li.hidden=YES;
    
    if (mark[view.tag-100]) {
        imageview_little.image=[UIImage imageNamed:@"ios7_bbs_down20_12.png"];
       // labbel_li.hidden=YES;
    
        labbel_li.image=[UIImage imageNamed:@"ios7_bbs_down20_12.png"];

        
    }else{
        imageview_little.image=[UIImage imageNamed:@"ios7_bbs_up20_12.png"];
        labbel_li.image=[UIImage imageNamed:@"ios7_bbs_up20_12.png"];
      //  labbel_li.hidden=NO;
        
    }
    labbel_li.hidden=YES;
    // [view addSubview:imageview_little];左边的小箭头
    [view addSubview:labbel_li];//左边的小箭头
    
    [allview addSubview:view];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [view addGestureRecognizer:tap];
    return allview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBSfenduiViewController *  fendui_=[[BBSfenduiViewController alloc]init];
    fendui_.string_id=[[array_IDrow objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    if ([fendui_.string_id integerValue]==99999) {
        NSLog(@"这个不能点击");
    }else{
        [self.navigationController pushViewController:fendui_ animated:YES];
    }
    
    
}
-(void)PromptingisLoading{
    
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    //[hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:@"正在加载"];
    [hud setActivity:YES];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    
    
}

-(void)doTap:(UITapGestureRecognizer *)sender
{
    
    mark[sender.view.tag-100] = !mark[sender.view.tag-100];
    //
    //    UIImageView *imageview_little=[[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 17, 16)];
    //
    //    if (mark[sender.view.tag-100]) {
    //        imageview_little.image=[UIImage imageNamed:@"horn_down17X16.png"];
    //
    //
    //    }else{
    //        imageview_little.image=[UIImage imageNamed:@"horn_right17x16.png"];
    //
    //    }
    //    [sender.view addSubview:imageview_little];
    
    NSRange range = NSMakeRange(sender.view.tag-100,1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    
    [tab_ reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark-里面的button
-(void)selectbuttontag:(NSInteger)tag{
    NSLog(@"tag======%d",tag);
    UIButton *button_ =(UIButton *)[self.view viewWithTag:tag];
    
    BBSfenduiViewController *   fendui_=[[BBSfenduiViewController alloc]init];
    fendui_.string_id=[NSString stringWithFormat:@"%d",tag];
    //    [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
    fendui_.string_name=button_.titleLabel.text;
    [self.navigationController pushViewController:fendui_ animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//对应ios6下的横竖屏问题
- (BOOL)shouldAutorotate{
    return  NO;
}
@end
