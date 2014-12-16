//
//  ZhuCeViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-23.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "ZhuCeViewController.h"
#import "MBProgressHUD.h"

@interface ZhuCeViewController ()
{
    MBProgressHUD * aHud;
}

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
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(247,247,247);
    
    self.title = @"完善个人资料";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    UILabel * yonghuming = [[UILabel alloc] initWithFrame:CGRectMake(23/2,23/2,100,20)];
    yonghuming.text = @"用户名:";
    yonghuming.textAlignment = NSTextAlignmentLeft;
    yonghuming.textColor = RGBCOLOR(120,121,122);
    yonghuming.backgroundColor = [UIColor clearColor];
    [self.view addSubview:yonghuming];
    
    
    userName_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,38,DEVICE_WIDTH-23,42)];
    userName_tf.backgroundColor = [UIColor whiteColor];
    userName_tf.delegate = self;
    userName_tf.font = [UIFont systemFontOfSize:15];
    userName_tf.placeholder = @"最多可输入7个中文,注册后用户名不可更改";
    [self.view addSubview:userName_tf];
    
    
    UILabel * mima_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,90,200,20)];
    mima_label.textColor = RGBCOLOR(120,121,122);
    mima_label.text = @"密码:";
    mima_label.textAlignment = NSTextAlignmentLeft;
    mima_label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mima_label];
    
    
    mima_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,120,DEVICE_WIDTH-23,42)];
    mima_tf.placeholder = @"请输入密码";
    mima_tf.delegate = self;
    mima_tf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
    mima_tf.secureTextEntry = YES;                              //密码输入时
    mima_tf.backgroundColor = [UIColor whiteColor];
    mima_tf.layer.borderColor = RGBCOLOR(31,31,31).CGColor;
    mima_tf.font = [UIFont systemFontOfSize:15];
    mima_tf.layer.borderWidth = 0.5;
    [self.view addSubview:mima_tf];
    
    
    UILabel * youxiang_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,175,200,20)];
    youxiang_label.text = @"邮箱:";
    youxiang_label.textColor = RGBCOLOR(120,121,122);
    youxiang_label.backgroundColor = [UIColor clearColor];
    youxiang_label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:youxiang_label];
    
    
    youxiang_tf = [[UITextField alloc] initWithFrame:CGRectMake(23/2,200,DEVICE_WIDTH-23,42)];
    youxiang_tf.placeholder = @"用来找回密码,请慎重填写";
    youxiang_tf.backgroundColor = [UIColor whiteColor];
    youxiang_tf.delegate = self;
    youxiang_tf.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:youxiang_tf];
    
    
    UIButton * complete_button = [UIButton buttonWithType:UIButtonTypeCustom];
    complete_button.frame = CGRectMake(23/2,257,DEVICE_WIDTH-23,43);
    [complete_button setTitle:@"完 成" forState:UIControlStateNormal];
    complete_button.backgroundColor = RGBCOLOR(255,144,0);
    [complete_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [complete_button addTarget:self action:@selector(zhuCe:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:complete_button];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
}

-(void)doTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
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
    
    aHud = [zsnApi showMBProgressWithText:@"正在注册..." addToView:self.view];
    
    NSString * fullUrl = [NSString stringWithFormat:SENDUSERINFO,self.PhoneNumber,self.verification,[userName_tf.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],mima_tf.text,youxiang_tf.text];
    request_ = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    request_.delegate = self;
    request_.shouldAttemptPersistentConnection = NO;
    [request_ startAsynchronous];
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [aHud hide:YES];
    
    [zsnApi showAutoHiddenMBProgressWithText:@"注册失败,请检查当前网络" addToView:self.view];
    
    //    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"发送失败,请检查当前网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    //    [alert show];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    [aHud hide:YES];
    
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
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:bbsinfo message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [alert show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


//-(void)animationStar
//{
//    //弹出提示信息
//    [hud setBlockTouches:NO];
//    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
//    [hud setCaption:@"正在注册"];
//    [hud setActivity:YES];
//    [hud show];
//    [hud hideAfter:3];
//}
//
//-(void)animationEnd
//{
//    //弹出提示信息
//    [hud setBlockTouches:NO];
//    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
//    [hud setCaption:@"注册成功"];
//    [hud setActivity:NO];
//    [hud setImage:[UIImage imageNamed:@"19-check"]];
//    [hud show];
//    [hud hideAfter:3];
//}


#pragma mark-UITextFieldDelegate

#pragma mark-UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.frame.origin.y+textField.frame.size.height + 260 > DEVICE_HEIGHT)
    {
        CGRect frame = self.view.frame;
        frame.origin.y = DEVICE_HEIGHT - (textField.frame.origin.y+textField.frame.size.height + 300);
        [UIView animateWithDuration:0.35 animations:^{
            self.view.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.35 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 64;
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end













