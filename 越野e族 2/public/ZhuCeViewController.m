//
//  ZhuCeViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-23.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "ZhuCeViewController.h"

@interface ZhuCeViewController ()

@end

@implementation ZhuCeViewController
@synthesize PhoneNumber = _PhoneNumber;
@synthesize verification = _verification;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    [MobClick endEvent:@"ZhuCeViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"ZhuCeViewController"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(245,245,245);
	
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
    
    
    self.navigationItem.title = @"完善个人资料";
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    UIBarButtonItem * space_button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space_button.width = MY_MACRO_NAME?0:5;
//    
//    
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,12,21.5)];
//    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back_item = [[UIBarButtonItem alloc]initWithCustomView:button_back];
//    self.navigationItem.leftBarButtonItems = @[space_button,back_item];
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    UILabel * yonghuming = [[UILabel alloc] initWithFrame:CGRectMake(23/2,23/2,100,20)];
    
    yonghuming.text = @"用户名:";
    
    yonghuming.textAlignment = NSTextAlignmentLeft;
    
    yonghuming.textColor = RGBCOLOR(101,102,104);
    
    yonghuming.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:yonghuming];
    
    
    userName_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,38,296,42)];
    
    userName_tf.backgroundColor = [UIColor whiteColor];
    
    userName_tf.delegate = self;
    
    userName_tf.font = [UIFont systemFontOfSize:15];
    
    userName_tf.placeholder = @"最多可输入7个中文,注册后用户名不可更改";
    
    [self.view addSubview:userName_tf];
    
    
    UILabel * mima_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,90,200,20)];
    
    mima_label.textColor = RGBCOLOR(101,102,104);
    
    mima_label.text = @"密码:";
    
    mima_label.textAlignment = NSTextAlignmentLeft;
    
    mima_label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:mima_label];
    
    
    mima_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,120,296,42)];
    
    mima_tf.placeholder = @"请输入密码";
    
    mima_tf.delegate = self;
    
    mima_tf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
    
    mima_tf.secureTextEntry = YES;                              //密码输入时
    
    mima_tf.backgroundColor = [UIColor whiteColor];
    
    mima_tf.layer.borderColor = [UIColor blackColor].CGColor;
    
    mima_tf.font = [UIFont systemFontOfSize:15];
    
    mima_tf.layer.borderWidth = 0.5;
    
    [self.view addSubview:mima_tf];
    
    
    UILabel * youxiang_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,175,200,20)];
    
    youxiang_label.text = @"邮箱";
    
    youxiang_label.textColor = RGBCOLOR(101,102,104);
    
    youxiang_label.backgroundColor = [UIColor clearColor];
    
    youxiang_label.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:youxiang_label];
    
    
    youxiang_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,200,296,42)];
    
    youxiang_tf.placeholder = @"用来找回密码,请慎重填写";
    
    youxiang_tf.backgroundColor = [UIColor whiteColor];
    
    youxiang_tf.delegate = self;
    
    youxiang_tf.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:youxiang_tf];
    
    
    UIButton * complete_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    complete_button.frame = CGRectMake(23/2,257,593/2,43);
    
    [complete_button setTitle:@"完 成" forState:UIControlStateNormal];
    
    complete_button.backgroundColor = RGBCOLOR(101,102,104);
    
    [complete_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [complete_button addTarget:self action:@selector(zhuCe:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:complete_button];
    
    
    
    hud = [[ATMHud alloc] initWithDelegate:self];
    
    [self.view addSubview:hud.view];
}


-(void)zhuCe:(UIButton *)button
{
    if (userName_tf.text.length == 0)
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alertView show];
        
        [userName_tf becomeFirstResponder];
        
        return;
    }
    
    
    if (mima_tf.text.length == 0)
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alertView show];
        
        [mima_tf becomeFirstResponder];
        
        return;
    }
    
    if (youxiang_tf.text.length == 0)
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"邮箱不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alertView show];
        
        [youxiang_tf becomeFirstResponder];
        
        return;
    }else
    {
        BOOL isMail = [zsnApi validateEmail:youxiang_tf.text];
        
        if (!isMail)
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的邮箱" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            
            [alertView show];
            
            return;
        }
    }
    
    
    if (request_)
    {
        [request_ cancel];
        
        request_.delegate = nil;
        
        request_ = nil;
    }
    
    [self animationStar];
    
    
    NSString * fullUrl = [NSString stringWithFormat:SENDUSERINFO,self.PhoneNumber,self.verification,[userName_tf.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],mima_tf.text,youxiang_tf.text];
    
    request_ = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    request_.delegate = self;
    
    request_.shouldAttemptPersistentConnection = NO;
    
    [request_ startAsynchronous];
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [self animationEnd];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"发送失败,请检查当前网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    
    [alert show];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    [self animationEnd];
    
    NSDictionary * data_dic = [request.responseData objectFromJSONData];
    
    NSString * errcode = [NSString stringWithFormat:@"%@",[data_dic objectForKey:@"errcode"]]
    ;
    
    NSString * bbsinfo = [NSString stringWithFormat:@"%@",[data_dic objectForKey:@"bbsinfo"]];
    
    if ([errcode intValue] == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"注册成功,马上去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
        
        alert.delegate = self;
        
        [alert show];
    }else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:bbsinfo delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alert show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}


-(void)animationStar
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:@"正在注册"];
    [hud setActivity:YES];
    [hud show];
    [hud hideAfter:3];
}

-(void)animationEnd
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:@"注册成功"];
    [hud setActivity:NO];
    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
}


#pragma mark-UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end













