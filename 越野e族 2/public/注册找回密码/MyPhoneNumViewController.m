//
//  MyPhoneNumViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-26.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//testsvn

#import "MyPhoneNumViewController.h"

@interface MyPhoneNumViewController ()

@end

@implementation MyPhoneNumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


-(void)leftButtonTap:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginEvent:@"MyPhoneNumViewController"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [MobClick endEvent:@"MyPhoneNumViewController"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(245,245,245);
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    
    self.navigationItem.title = @"验证手机号码";
    
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
    
    
    self.leftImageName = @"logIn_close.png";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeOther WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    UIImageView * backGround_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23/2,23/2,594/2,87/2)];
    
    backGround_imageView.userInteractionEnabled = YES;
    
    backGround_imageView.image = [UIImage imageNamed:@"zc_phoneNum.png"];
    
    [self.view addSubview:backGround_imageView];
    
    
    UILabel * tishi_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,68,87/2)];
    
    tishi_label.text = @"中国 +86";
    
    tishi_label.backgroundColor = [UIColor clearColor];
    
    tishi_label.textAlignment = NSTextAlignmentCenter;
    
    tishi_label.font = [UIFont systemFontOfSize:15];
    
    tishi_label.textColor = [UIColor blackColor];
    
    [backGround_imageView addSubview:tishi_label];
    
    
    
    phone_textField = [[UITextField alloc] initWithFrame:CGRectMake(83.5,5,200,33.5)];
    
    phone_textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    [phone_textField becomeFirstResponder];
    
    phone_textField.delegate = self;
    
    phone_textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    
    phone_textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [backGround_imageView addSubview:phone_textField];
    
    
    UIButton * next_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    next_button.frame = CGRectMake(23/2,backGround_imageView.frame.origin.y+backGround_imageView.frame.size.height+23/2,297,43);
    
    next_button.backgroundColor = RGBCOLOR(101,102,104);
    
    [next_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [next_button setTitle:@"下一步" forState:UIControlStateNormal];
    
    [next_button addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:next_button];
    
    
    
    UIImageView * icon_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23/2,124.5,35/2,34/2)];
    
    icon_imageView.image = [UIImage imageNamed:@"zc_xieyi.png"];
    
    [self.view addSubview:icon_imageView];
    
    
    UIButton * xieyi_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    xieyi_button.frame = CGRectMake(29,123,280,20);
    
    xieyi_button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [xieyi_button setTitleColor:RGBCOLOR(135,135,135) forState:UIControlStateNormal];
    
    [xieyi_button setTitle:@"同意越野e族《隐私条款和服务条款》" forState:UIControlStateNormal];
    
    [xieyi_button addTarget:self action:@selector(chakanxieyi:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:xieyi_button];
    
    
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        
        [self.view addSubview:hud.view];
    }
    
}


-(void)chakanxieyi:(UIButton *)sender
{
    
}


-(void)nextStep:(UIButton *)sender
{
    if (phone_textField.text.length != 11)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [alert show];
    }else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送验证码短信到这个手机号:+86 %@",phone_textField.text] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
        alert.delegate = self;
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            [self animationStar];
            
            if (myRequest)
            {
                [myRequest cancel];
                myRequest.delegate = nil;
                myRequest = nil;
            }
            
            
            NSString * fullUrl = [NSString stringWithFormat:SENDPHONENUMBER,phone_textField.text];
            
            NSLog(@"发送手机请求的url------%@",fullUrl);
            
            myRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
            
            myRequest.delegate = self;
            
            myRequest.shouldAttemptPersistentConnection = NO;
            
            [myRequest startAsynchronous];

        }
            break;
            
        default:
            break;
    }
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary * data_dic = [request.responseData objectFromJSONData];
    
    NSString * errcode = [NSString stringWithFormat:@"%@",[data_dic objectForKey:@"errcode"]];
    
    NSString * bbsinfo = [NSString stringWithFormat:@"%@",[data_dic objectForKey:@"bbsinfo"]];
    
    NSLog(@"bbsinfo -----  %@",bbsinfo);
    
    [self animationEnd];
    
    if ([errcode intValue] == 0)
    {
        VerificationViewController * verification = [[VerificationViewController alloc] init];
        
        verification.MyPhoneNumber = phone_textField.text;
        
        [self.navigationController pushViewController:verification animated:YES];
    }else
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:bbsinfo delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alertView show];
    }
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [self animationEnd];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"发送失败,请检查当前网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    
    [alert show];
}




-(void)animationStar
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:@"发送中..."];
    [hud setActivity:NO];
    [hud show];
    [hud hideAfter:3];
}

-(void)animationEnd
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:@"发送成功"];
    [hud setActivity:NO];
    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end












