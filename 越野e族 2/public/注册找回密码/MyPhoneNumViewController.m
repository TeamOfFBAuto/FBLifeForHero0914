//
//  MyPhoneNumViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-26.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//testsvn

#import "MyPhoneNumViewController.h"
#import "PrivacyPolicyViewController.h"

@interface MyPhoneNumViewController ()
{
    MBProgressHUD * hud;
}

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



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(247,247,247);
    
    self.title = @"验证手机号码";
    
    self.leftImageName = @"logIn_close.png";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    UIImageView * backGround_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23/2,23/2,DEVICE_WIDTH-23,87/2)];
    backGround_imageView.userInteractionEnabled = YES;
    backGround_imageView.image = [[UIImage imageNamed:@"zc_phoneNum.png"] stretchableImageWithLeftCapWidth:100 topCapHeight:20];
    [self.view addSubview:backGround_imageView];
    
    
    UILabel * tishi_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,68,87/2)];
    tishi_label.text = @"中国 +86";
    tishi_label.backgroundColor = [UIColor clearColor];
    tishi_label.textAlignment = NSTextAlignmentCenter;
    tishi_label.font = [UIFont systemFontOfSize:15];
    tishi_label.textColor = [UIColor blackColor];
    [backGround_imageView addSubview:tishi_label];
    
    
    
    phone_textField = [[UITextField alloc] initWithFrame:CGRectMake(83.5,5,DEVICE_WIDTH-23-85,33.5)];
    phone_textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [phone_textField becomeFirstResponder];
    phone_textField.delegate = self;
    phone_textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    phone_textField.keyboardType = UIKeyboardTypeNumberPad;
    [backGround_imageView addSubview:phone_textField];
    
    
    UIButton * next_button = [UIButton buttonWithType:UIButtonTypeCustom];
    next_button.frame = CGRectMake(23/2,backGround_imageView.frame.origin.y+backGround_imageView.frame.size.height+23/2,DEVICE_WIDTH-23,43);
    next_button.backgroundColor = RGBCOLOR(255,144,0);
    [next_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next_button setTitle:@"下一步" forState:UIControlStateNormal];
    [next_button addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next_button];
    
    
    UIImageView * icon_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23/2,124.5,35/2,34/2)];
    icon_imageView.image = [UIImage imageNamed:@"zc_xieyi.png"];
    [self.view addSubview:icon_imageView];
    
    UIButton * xieyi_button = [UIButton buttonWithType:UIButtonTypeCustom];
    xieyi_button.frame = CGRectMake(30,123,280,20);
    xieyi_button.titleLabel.font = [UIFont systemFontOfSize:16];
    [xieyi_button setTitleColor:RGBCOLOR(153,153,153) forState:UIControlStateNormal];
    [xieyi_button setTitle:@"同意越野e族《隐私条款和服务条款》" forState:UIControlStateNormal];
    [xieyi_button addTarget:self action:@selector(chakanxieyi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xieyi_button];
    
    
    UITapGestureRecognizer * view_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:view_tap];
    
}
-(void)doTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}


-(void)chakanxieyi:(UIButton *)sender
{
    PrivacyPolicyViewController * PPVC = [[PrivacyPolicyViewController alloc] init];
    UINavigationController * navc  = [[UINavigationController alloc] initWithRootViewController:PPVC];
    [self presentViewController:navc animated:YES completion:nil];
}


-(void)nextStep:(UIButton *)sender
{
    //    [ZSNApi showAutoHiddenMBProgressWithText:@"发送成功" addToView:self.view];
    //    VerificationViewController * verification = [[VerificationViewController alloc] init];
    //    verification.MyPhoneNumber = phone_textField.text;
    //    [self.navigationController pushViewController:verification animated:YES];
    //    return;
    
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
            [phone_textField resignFirstResponder];
            if (myRequest)
            {
                [myRequest cancel];
                myRequest.delegate = nil;
                myRequest = nil;
            }
            
            hud = [zsnApi showMBProgressWithText:@"发送中..." addToView:self.view];
            
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
    
    [hud hide:YES];
    
    if ([errcode intValue] == 0)
    {
        [zsnApi showAutoHiddenMBProgressWithText:@"发送成功" addToView:self.view];
        VerificationViewController * verification = [[VerificationViewController alloc] init];
        verification.MyPhoneNumber = phone_textField.text;
        [self.navigationController pushViewController:verification animated:YES];
    }else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:bbsinfo message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [alert show];
        
        //        [zsnApi showautoHiddenMBProgressWithTitle:@"" WithContent:bbsinfo addToView:self.view];
    }
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [hud hide:YES];
    [zsnApi showAutoHiddenMBProgressWithText:@"发送失败,请检查当前网络" addToView:self.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end












