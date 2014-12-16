//
//  VerificationViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-26.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "VerificationViewController.h"

@interface VerificationViewController ()
{
    MBProgressHUD * hud;
}

@end

@implementation VerificationViewController
@synthesize MyPhoneNumber = _MyPhoneNumber;


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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

-(void)cancelKeyboradTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(247,247,247);
    UITapGestureRecognizer * cancel_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboradTap:)];
    [self.view addGestureRecognizer:cancel_tap];
    
    self.title = @"填写验证码";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(23/2,23/2,200,16)];
    label1.text = @"请输入收到的短信验证码:";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = RGBCOLOR(101,102,104);
    label1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label1];
    
    
    UIView * back_view = [[UIView alloc] initWithFrame:CGRectMake(23/2,38,DEVICE_WIDTH-23,42)];
    back_view.backgroundColor = [UIColor whiteColor];
    back_view.layer.borderColor = RGBCOLOR(226,226,226).CGColor;
    back_view.layer.borderWidth = 0.5;
    [self.view addSubview:back_view];
    
    verification_tf = [[UITextField alloc] initWithFrame:CGRectMake(10,0,DEVICE_WIDTH-23-20,42)];
    verification_tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    verification_tf.placeholder = @"请输入验证码";
    verification_tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verification_tf.keyboardType = UIKeyboardTypeNumberPad;
    verification_tf.backgroundColor = [UIColor clearColor];
    verification_tf.font = [UIFont systemFontOfSize:15];
    [verification_tf becomeFirstResponder];
    
    [back_view addSubview:verification_tf];
    
    
    UIButton * next_button = [UIButton buttonWithType:UIButtonTypeCustom];
    next_button.frame = CGRectMake(23/2,80+23/2,DEVICE_WIDTH-23,43);
    next_button.backgroundColor = RGBCOLOR(255,144,0);
    [next_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next_button setTitle:@"下一步" forState:UIControlStateNormal];
    [next_button addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next_button];
    
    
    
    ReSendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ReSendButton.frame = CGRectMake((DEVICE_WIDTH-132)/2,200,132,43.5);
    ReSendButton.hidden = YES;
    [ReSendButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
    [ReSendButton setTitleColor:RGBCOLOR(168,167,167) forState:UIControlStateNormal];
    ReSendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [ReSendButton setBackgroundImage:RGBCOLOR(247,247,247) forState:UIControlStateNormal];
    ReSendButton.backgroundColor = RGBCOLOR(247,247,247);
    [ReSendButton addTarget:self action:@selector(reSend:) forControlEvents:UIControlEventTouchUpInside];
    ReSendButton.layer.borderColor = RGBCOLOR(207,207,207).CGColor;
    ReSendButton.layer.borderWidth = 0.5;
    [self.view addSubview:ReSendButton];
    
    
    
    time_number = 60;
    
    time_label = [[UILabel alloc] initWithFrame:CGRectMake((DEVICE_WIDTH-180)/2,200,180,43.5)];
    time_label.text = [NSString stringWithFormat:@"接收短信大约需要%d秒钟",time_number];
    time_label.textAlignment = NSTextAlignmentCenter;
    time_label.textColor = [UIColor grayColor];
    time_label.font = [UIFont systemFontOfSize:15];
    time_label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:time_label];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
}

-(void)reSend:(UIButton *)sender
{
    [self initReSendRequest];
}

-(void)doTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

-(void)timeCount
{
    if (time_number == 1)
    {
        time_label.hidden = YES;
        
        ReSendButton.hidden = NO;
        
        [timer invalidate];
        
        return;
    }
    
    time_number--;
    
    time_label.text = [NSString stringWithFormat:@"接收短信大约需要%d秒钟",time_number];
}



-(void)nextStep:(UIButton *)sender
{
    //    ZhuCeViewController * zhuce = [[ZhuCeViewController alloc] init];
    //    zhuce.PhoneNumber = self.MyPhoneNumber;
    //    zhuce.verification = verification_tf.text;
    //    [self.navigationController pushViewController:zhuce animated:YES];
    //    return;
    
    
    [self initYanZhengVerification];
}


-(void)initReSendRequest
{
    if (reSend_request)
    {
        [reSend_request cancel];
        reSend_request.delegate = nil;
        reSend_request = nil;
    }
    
    hud = [zsnApi showMBProgressWithText:@"发送中..." addToView:self.view];
    
    NSString * fullUrl = [NSString stringWithFormat:SENDPHONENUMBER,self.MyPhoneNumber];
    
    NSLog(@"发送手机请求的url------%@",fullUrl);
    
    reSend_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    
    reSend_request.delegate = self;
    
    reSend_request.shouldAttemptPersistentConnection = NO;
    
    [reSend_request startAsynchronous];
    
}


-(void)initYanZhengVerification
{
    if (request_)
    {
        [request_ cancel];
        request_.delegate = nil;
        request_ = nil;
    }
    
    hud = [zsnApi showMBProgressWithText:@"发送中..." addToView:self.view];
    
    NSString * fullUrl = [NSString stringWithFormat:SENDERVerification,self.MyPhoneNumber,verification_tf.text];
    
    request_ = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    request_.delegate = self;
    
    request_.shouldAttemptPersistentConnection = NO;
    
    [request_ startAsynchronous];
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    [hud hide:YES];
    NSDictionary * data_dic = [request.responseData objectFromJSONData];
    
    NSString * errcode = [NSString stringWithFormat:@"%@",[data_dic objectForKey:@"errcode"]]
    ;
    
    NSString * bbsinfo = [NSString stringWithFormat:@"%@",[data_dic objectForKey:@"bbsinfo"]];
    
    
    if (request == request_)
    {
        if ([errcode intValue] == 0)
        {
            ZhuCeViewController * zhuce = [[ZhuCeViewController alloc] init];
            zhuce.PhoneNumber = self.MyPhoneNumber;
            zhuce.verification = verification_tf.text;
            [self.navigationController pushViewController:zhuce animated:YES];
        }else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:bbsinfo message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            [alert show];
        }
    }else
    {
        if ([errcode intValue] == 0)
        {
            [zsnApi showAutoHiddenMBProgressWithText:@"发送成功" addToView:self.view];
            time_number = 60;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
            ReSendButton.hidden = YES;
            time_label.hidden = NO;
        }else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:bbsinfo message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            
            [alert show];
        }
    }
    
    
    
    
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [hud hide:YES];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"发送失败,请检查当前网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    
    [alert show];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end




















