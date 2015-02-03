//
//  LogInViewController.m
//  FbLife
//
//  Created by szk on 13-2-26.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "LogInViewController.h"
@interface LogInViewController ()
{
    downloadtool *tool1;
    downloadtool *tool2;
    downloadtool *tool3;
}

@end

@implementation LogInViewController
@synthesize myTableView = _myTableView;
@synthesize TextField1 = _TextField1;
@synthesize TextField2 = _TextField2;
@synthesize delegate = _delegate;


+ (LogInViewController *)sharedManager
{
    static LogInViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"LogInViewController"];
}


-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [MobClick beginEvent:@"LogInViewController"];
    
    if (isShow && logoImageView)
    {
        [self loadDown];
    }
    
}


-(void)loadDown
{
    logoImageView.center = CGPointMake(logoImageView.center.x,42 + 49.5/2 + (IOS_VERSION>=7.0?64:44));
    
    denglu_imageView.frame = CGRectMake(denglu_imageView.frame.origin.x,logoImageView.center.y+25+10,296.5,185);
    
    isShow = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isShow = NO;
    
    dictionary = [[NSDictionary alloc] init];
    
    self.view.backgroundColor = RGBCOLOR(245,245,245);
    ///////////////////////////////////
    //[self kaitongfb];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //创建navbar
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, aScreenRect.size.width,IOS_VERSION>=7.0?64:44)];
    //创建navbaritem
    UINavigationItem * NavTitle = [[UINavigationItem alloc] initWithTitle:@"登录账号"];
    nav.barStyle = UIBarStyleBlackOpaque;
    [nav pushNavigationItem:NavTitle animated:YES];
    
    //    nav.translucent = NO;
    
    if([nav respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        [nav setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,44)];
    title_label.text = @"登录";
    title_label.textColor = [UIColor blackColor];
    title_label.backgroundColor = [UIColor clearColor];
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font =TITLEFONT;
    NavTitle.titleView = title_label;
    
    UIBarButtonItem * spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBar.width = MY_MACRO_NAME?-5:5;
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,31/2,32/2)];
    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"logIn_close.png"] forState:UIControlStateNormal];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    NavTitle.rightBarButtonItems=@[spaceBar,back_item];
    
    
    //设置barbutton
    [nav setItems:[NSArray arrayWithObject:NavTitle]];
    ///////////////////////////////////
    
    UIImage * logo_image = [UIImage imageNamed:@"logoInLogo.png"];
    logoImageView = [[UIImageView alloc] initWithImage:logo_image];
    logoImageView.center = CGPointMake(DEVICE_WIDTH/2.0,42 + 49.5/2 + (IOS_VERSION>=7.0?64:44));
    [self.view addSubview:logoImageView];
    
    denglu_imageView = [[UIImageView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH-296.5)/2.0,logoImageView.center.y+25+10,296.5,185)];
    denglu_imageView.userInteractionEnabled = YES;
    denglu_imageView.image = [UIImage imageNamed:@"llongInBackImage.png"];
    [self.view addSubview:denglu_imageView];
    
    
    userNameField=[[UITextField alloc] initWithFrame:CGRectMake(70,18,209,42)];
    userNameField.backgroundColor=[UIColor clearColor];
    userNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
    userNameField.placeholder = @"用户名";                          //默认显示的字
    userNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
    userNameField.returnKeyType = UIReturnKeyDone;                    //键盘有done
    userNameField.delegate=self;
    userNameField.font = [UIFont systemFontOfSize:16];
    [denglu_imageView addSubview:userNameField];
    
    pwNameField=[[UITextField alloc] initWithFrame:CGRectMake(70,74,209,42)];
    pwNameField.delegate = self;
    pwNameField.backgroundColor=[UIColor clearColor];
    pwNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
    pwNameField.secureTextEntry = YES;                              //密码输入时
    pwNameField.placeholder = @"密码";                          //默认显示的字
    pwNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
    pwNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
    pwNameField.returnKeyType = UIReturnKeyDone;
    pwNameField.font = [UIFont systemFontOfSize:16];
    [denglu_imageView addSubview:pwNameField];
    
    
    
    UIButton * logIn_button = [UIButton buttonWithType:UIButtonTypeCustom];
    logIn_button.frame = CGRectMake(13,130,272,43);
    logIn_button.backgroundColor = [UIColor clearColor];
    [logIn_button setTitle:@"登 录" forState:UIControlStateNormal];
    [logIn_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logIn_button addTarget:self action:@selector(loginH) forControlEvents:UIControlEventTouchUpInside];
    [denglu_imageView addSubview:logIn_button];
    
    
    /*老版界面
     loginboxImageView=[[UIImageView alloc] initWithImage: [UIImage imageNamed: @"denglu.png"]];
     [loginboxImageView setFrame:CGRectMake(([UIScreen mainScreen].applicationFrame.size.width-304)/2, 20+44+(IOS_VERSION>=7.0?20:0),304,91)];
     [self.view addSubview:loginboxImageView];
     
     userNameField=[[UITextField alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].applicationFrame.size.width-304)/2+95,24+44+(IOS_VERSION>=7.0?20:0), [UIScreen mainScreen].applicationFrame.size.width-110,40)];
     
     userNameField.backgroundColor=[UIColor clearColor];
     userNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
     userNameField.placeholder = @"用户名";                          //默认显示的字
     userNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
     userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
     userNameField.returnKeyType = UIReturnKeyDone;                    //键盘有done
     userNameField.delegate=self;    [self.view addSubview:userNameField];
     
     pwNameField=[[UITextField alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].applicationFrame.size.width-304)/2+95,44+68+(IOS_VERSION>=7.0?20:0), [UIScreen mainScreen].applicationFrame.size.width-110, 40)];
     pwNameField.backgroundColor=[UIColor clearColor];
     pwNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
     pwNameField.secureTextEntry = YES;                              //密码输入时
     pwNameField.placeholder = @"密码";                          //默认显示的字
     pwNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
     pwNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
     // pwNameField.returnKeyType = UIReturnKeyDone;                    //键盘有done
     // pwNameField.delegate=self;
     [self.view addSubview:pwNameField];
     
     
     UILabel *  powerText = [[UILabel alloc] initWithFrame:CGRectMake(30,44+125+(IOS_VERSION>=7.0?20:0),[UIScreen mainScreen].applicationFrame.size.width, 10)];
     powerText.text = @"注册越野e族会员,请登录FBLIFE.COM";
     powerText.font = [UIFont boldSystemFontOfSize:15];
     powerText.textColor=[UIColor blackColor];
     powerText.backgroundColor = [UIColor clearColor];
     [powerText sizeToFit];
     [self.view addSubview:powerText];
     
     */
    
    
    UIButton * zhuce_button = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuce_button.frame = CGRectMake(DEVICE_WIDTH/2.0-80,[UIScreen mainScreen].bounds.size.height-60,65,20);
    [zhuce_button setTitle:@"注册账号" forState:UIControlStateNormal];
    zhuce_button.titleLabel.font = [UIFont systemFontOfSize:16];
    zhuce_button.titleLabel.textAlignment = NSTextAlignmentCenter;
    zhuce_button.backgroundColor = [UIColor clearColor];
    [zhuce_button setTitleColor:RGBCOLOR(82,82,82) forState:UIControlStateNormal];
    [zhuce_button addTarget:self action:@selector(zhuceButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce_button];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2.0,[UIScreen mainScreen].bounds.size.height-58,0.5,16)];
    lineView.backgroundColor = RGBCOLOR(65,65,65);
    [self.view addSubview:lineView];
    
    UIButton * zhaohui_button = [UIButton buttonWithType:UIButtonTypeCustom];
    zhaohui_button.frame = CGRectMake(DEVICE_WIDTH/2.0+14,[UIScreen mainScreen].bounds.size.height-60,65,20);
    zhaohui_button.titleLabel.font = [UIFont systemFontOfSize:16];
    [zhaohui_button setTitleColor:RGBCOLOR(82,82,82) forState:UIControlStateNormal];
    [zhaohui_button setTitle:@"忘记密码" forState:UIControlStateNormal];
    [zhaohui_button addTarget:self action:@selector(zhaohuiButton:) forControlEvents:UIControlEventTouchUpInside];
    zhaohui_button.backgroundColor = [UIColor clearColor];
    zhaohui_button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:zhaohui_button];
    
    [self.view addSubview:nav];
}


-(void)zhuceButton:(UIButton *)sender
{
    MyPhoneNumViewController * zhuce = [[MyPhoneNumViewController alloc] init];
    UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:zhuce];
    [self presentViewController:naVC animated:YES completion:NULL];
}

-(void)zhaohuiButton:(UIButton *)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请登录FBLIFE.COM找回密码" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    
    [alert show];
}



-(void)backH
{
    [self loadDown];
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        if (_delegate && [_delegate respondsToSelector:@selector(failToLogIn)]) {
            [_delegate failToLogIn];
        }
        
    }];
}

-(void)loginH
{
    
    if (userNameField.text.length == 0)
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"用户名不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        
        [alertView show];
        
        return;
    }
    
    if (pwNameField.text.length == 0)
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"密码不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        
        [alertView show];
        
        return;
    }
    
    
    
    
    [tool1 stop];
    [tool2 stop];
    [tool3 stop];
    
    hud = [zsnApi showMBProgressWithText:NS_LOGINING addToView:self.view];
    
    [userNameField resignFirstResponder];
    [pwNameField resignFirstResponder];
    
    [self loadDown];
 /*szk
    tool1=[[downloadtool alloc]init];
    [tool1 setUrl_string:[NSString stringWithFormat:LOGIN_URL,[userNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[pwNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN]]];
    tool1.tag=101;
    
    NSLog(@"登录请求的url:%@",[NSString stringWithFormat:LOGIN_URL,[userNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[pwNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN]]);
    
    tool1.delegate=self;
    [tool1 start];
  */
    
    //http://bbs.fblife.com/bbsapinew/login.php?username=%@&password=%@&formattype=json&token=%@
    ASIFormDataRequest * login_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://bbs.fblife.com/bbsapinew/login.php?&formattype=json"]];
    [login_request setPostValue:userNameField.text forKey:@"username"];
    [login_request setPostValue:pwNameField.text forKey:@"password"];
    [login_request setPostValue:[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN] forKey:@"token"];
    
    __weak typeof(login_request) brequest = login_request;
    
    [login_request setCompletionBlock:^{
        dictionary= [brequest.responseString objectFromJSONString];
        NSLog(@"登录论坛 -=-=  %@",dictionary);
        
        if ([[dictionary objectForKey:@"errcode"] integerValue]==0)
        {
            [self kaitongfb:[dictionary objectForKey:@"bbsinfo"]];
            
        }else
        {
            [hud hide:YES];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_IN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码不正确" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert_ show];
        }

    }];
    
    [login_request setFailedBlock:^{
        [hud hide:YES];
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录失败,请重新登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil] show];
    }];
    
    [login_request startAsynchronous];
    
}


//开通fb
-(void)kaitong:(NSString *)sender
{
    NSLog(@"sender -=-   %@",sender);
    NSString *striingktfb=   [NSString stringWithFormat:ACTIVE_FBUSER_URL,sender];
    NSLog(@"开通时候的key==%@",striingktfb);
    tool3=[[downloadtool alloc]init];
    tool3.tag=103;
    [tool3 setUrl_string:striingktfb];
    tool3.delegate=self;
    [tool3 start];
}



//验证是否开通fb
-(void)kaitongfb:(NSString *)sender
{
    //验证用户是否开通FB
#define CHECK_FBUSER_URL @"http://fb.fblife.com/openapi/index.php?mod=account&code=checkfbuser&authkey=%@&fbtype=json"
    //    //激活Fb账号
#define ACTIVE_FBUSER_URL @"http://fb.fblife.com/openapi/index.php?mod=account&code=activeuser&authkey=%@&fbtype=json"
    
    
    NSString *striingktfb=   [NSString stringWithFormat:CHECK_FBUSER_URL,sender];
    tool2=[[downloadtool alloc]init];
    tool2.tag=102;
    [tool2 setUrl_string:striingktfb];
    tool2.delegate=self;
    [tool2 start];
}


-(void)downloadtoolError
{
    [hud hide:YES];
    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录失败,请重新登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil] show];
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data
{
    @try
    {
        if (tool.tag==101)
        {
            dictionary= [data objectFromJSONData];
            NSLog(@"登录论坛 -=-=  %@",dictionary);
            
            
            if ([[dictionary objectForKey:@"errcode"] integerValue]==0)
            {
                [self kaitongfb:[dictionary objectForKey:@"bbsinfo"]];
                
            }else
            {
                [hud hide:YES];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码不正确" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert_ show];
            }
            
        }else if(tool.tag == 102)
        {
            NSDictionary *dic_=[data objectFromJSONData];
            NSLog(@"验证是否开通fb账号");
            NSLog(@"啦啦啦啦啦 -=-  %@,,,errcode -=  %@",[dic_ objectForKey:@"data"],[dic_ objectForKey:@"errcode"]);
            
            if ([[dic_ objectForKey:@"errcode"] intValue] == 1)
            {
                //登陆成功保存用户信息
                //                [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setObject:pwNameField.text forKey:USER_PW] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"bbsinfo"] forKey:USER_AUTHOD] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"uid"] forKey:USER_UID] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"username"] forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:USER_AUTHOD object:[dictionary objectForKey:@"bbsinfo"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESS object:nil];
                
                [self.delegate successToLogIn];
                pwNameField.text = @"";
                [hud hide:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LogIn" object:nil];
                
                [self dismissViewControllerAnimated:YES completion:NULL];
                
            }else
            {
                NSLog(@"没有开通");
                NSLog(@"---yaochuande-==%@",[dictionary objectForKey:@"bbsinfo"]);
                [self kaitong:[dictionary objectForKey:@"bbsinfo"]];
            }
            
        }else
        {
            [hud hide:YES];
            NSLog(@"正在开通");
            
            NSDictionary * dic = [data objectFromJSONData];
            
            NSLog(@"开通微博数据 -----  %@ ----  %@",[dic objectForKey:@"errcode"],[dic objectForKey:@"data"]);
            if ([[dic objectForKey:@"errcode"] intValue] == 1)
            {
                
                NSLog(@"开通成功");
                
                //登陆成功保存用户信息
                //                [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setObject:pwNameField.text forKey:USER_PW] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"bbsinfo"] forKey:USER_AUTHOD] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"uid"] forKey:USER_UID] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"username"] forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:USER_AUTHOD object:[dictionary objectForKey:@"bbsinfo"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESS object:nil];
                
                [self.delegate successToLogIn];
                pwNameField.text = @"";
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LogIn" object:nil];
                
                [self dismissViewControllerAnimated:YES completion:NULL];
            }else
            {
                NSLog(@"开通时候的dic=%@",dic);
                NSLog(@"开通失败");
                UIAlertView * alert = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"登录失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}



#pragma mark-开通fb
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [hud hide:YES];
    @try {
        if (request.tag==101) {
            NSLog(@"requeststring==%@",[request responseString]);
            NSData *data=[request responseData];
            NSDictionary *dic_=[data objectFromJSONData];
            NSLog(@"dic==%@",dic_);
            if ([[dic_ objectForKey:@"errcode"] integerValue]==0)
            {
                //登陆成功保存用户信息
                [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setObject:pwNameField.text forKey:USER_PW] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dic_ objectForKey:@"bbsinfo"] forKey:USER_AUTHOD] ;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:USER_AUTHOD object:[dic_ objectForKey:@"bbsinfo"]];
                
            }else
            {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码不正确" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert_ show];
            }
        }else{
            NSLog(@"requeststring==%@",[request responseString]);
            NSData *data=[request responseData];
            NSDictionary *dic_=[data objectFromJSONData];
            NSLog(@"dic==%@",dic_);
            UILabel *labeltest=[[UILabel alloc]initWithFrame:CGRectMake(0,300 ,320 , 100)];
            // labeltest.backgroundColor=[UIColor redColor];
            labeltest.text=(NSString *)[dic_ objectForKey:@"data"];
            [self.view addSubview:labeltest];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [hud hide:YES];
    NSLog(@"error");
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    [self loginH];
    
    [pwNameField resignFirstResponder];
    
    [userNameField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        logoImageView.center = CGPointMake(logoImageView.center.x,42 + 49.5/2 + (IOS_VERSION>=7.0?64:44));
        
        denglu_imageView.frame = CGRectMake(denglu_imageView.frame.origin.x,logoImageView.center.y+25+10,296.5,185);
        
        
    } completion:^(BOOL finished) {
        isShow = NO;
    }];
    
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (DEVICE_HEIGHT==480)
    {
        if (!isShow)
        {
            isShow = YES;
            
            [UIView animateWithDuration:0.4 animations:^{
                logoImageView.center = CGPointMake(DEVICE_WIDTH/2.0,-49.5/2);
                
                denglu_imageView.center = CGPointMake(DEVICE_WIDTH/2.0f,(IOS_VERSION>=7.0?64:44)+185/2);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    return YES;
}

-(void)dealloc
{
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end







