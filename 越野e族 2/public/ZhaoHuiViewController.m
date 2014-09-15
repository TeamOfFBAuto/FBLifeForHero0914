//
//  ZhaoHuiViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-23.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "ZhaoHuiViewController.h"

@interface ZhaoHuiViewController ()

@end

@implementation ZhaoHuiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}
-(void)backH
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"ZhaoHuiViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"ZhaoHuiViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float ios7_height = IOS_VERSION>=7.0?20:0;
    
    self.view.backgroundColor = RGBCOLOR(245,245,245);
    ///////////////////////////////////
    //[self kaitongfb];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //创建navbar
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, aScreenRect.size.width,IOS_VERSION>=7.0?64:44)];
    //创建navbaritem
    UINavigationItem * NavTitle = [[UINavigationItem alloc] initWithTitle:@"找回密码"];
    nav.barStyle = UIBarStyleBlackOpaque;
    [nav pushNavigationItem:NavTitle animated:YES];
    
    [self.view addSubview:nav];
    
    
    if([nav respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        [nav setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,44)];
    
    title_label.text = @"找回密码";
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.textAlignment = NSTextAlignmentCenter;
    
    title_label.font = TITLEFONT;
    
    NavTitle.titleView = title_label;
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,12,21.5)];
    
    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?BACK_DEFAULT_IMAGE:@"bc@2x.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    NavTitle.leftBarButtonItem=back_item;
    
    //设置barbutton
    [nav setItems:[NSArray arrayWithObject:NavTitle]];
    
    
    
    UILabel * yonghuming = [[UILabel alloc] initWithFrame:CGRectMake(23/2,23/2+44+ios7_height,100,20)];
    
    yonghuming.text = @"用户名:";
    
    yonghuming.textAlignment = NSTextAlignmentLeft;
    
    yonghuming.textColor = RGBCOLOR(101,102,104);
    
    yonghuming.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:yonghuming];
    
    
    UITextField * userName_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,38+44+ios7_height,296,42)];
    
    userName_tf.backgroundColor = [UIColor whiteColor];
    
    userName_tf.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:userName_tf];
    
    
    UILabel * phone_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,90+44+ios7_height,200,20)];
    
    phone_label.textColor = RGBCOLOR(101,102,104);
    
    phone_label.text = @"手机号码:";
    
    phone_label.textAlignment = NSTextAlignmentLeft;
    
    phone_label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:phone_label];
    
    
    UITextField * phone_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,120+44+ios7_height,296,42)];
    
    phone_tf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
    
    phone_tf.keyboardType = UIKeyboardTypeNumberPad;
    
    phone_tf.backgroundColor = [UIColor whiteColor];
    
    phone_tf.font = [UIFont systemFontOfSize:15];
        
    [self.view addSubview:phone_tf];
    
    UIButton * next_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    next_button.frame = CGRectMake(23/2,175+44+ios7_height,593/2,43);
    
    [next_button setTitle:@"下一步" forState:UIControlStateNormal];
    
    next_button.backgroundColor = RGBCOLOR(101,102,104);
    
    [next_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:next_button];
    
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end


















