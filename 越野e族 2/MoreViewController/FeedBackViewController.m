//
//  FeedBackViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-5-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"FeedBackViewController"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"FeedBackViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"意见反馈";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    //
    button_comment=[[UIButton alloc]initWithFrame:CGRectMake(265, 8, 46, 28)];
    button_comment.tag=26;
    [button_comment setTitle:@"提交" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(postdemo) forControlEvents:UIControlEventTouchUpInside];
    [button_comment setBackgroundImage:[UIImage imageNamed:@"ping@2x.png"] forState:UIControlStateNormal];
    //[view_daohang addSubview:button_comment];
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pinglun_bg.png"] forBarMetrics: UIBarMetricsDefault];
    }
    //  self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:73 green:73 blue:72 alpha:1];
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10, 8, 32, 28)];
    
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"bc@2x.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    self.navigationItem.leftBarButtonItem=back_item;
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:button_comment];
    self.navigationItem.rightBarButtonItem=comment_item;
    
    //  self.navigationItem.title=@"新闻中心";
//    self.navigationItem.titleView=labelbiaoti;

    
    umFeedback = [UMFeedback sharedInstance];
    [umFeedback setAppkey:@"5153e5e456240b79e20006b9" delegate:self];
    
    
    UIButton *button_post=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 33)];
   // button_post.backgroundColor=[UIColor redColor];
    [button_post addTarget:self action:@selector(postdemo) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:button_post];
    
    UIView *aview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view=aview;
    aview.backgroundColor=[UIColor whiteColor];
    
    
    _contenttextview=[[UITextField alloc]initWithFrame:CGRectMake(0, 5, 320, 205)];
    [_contenttextview setBackgroundColor:[UIColor clearColor]];
    _contenttextview.font=[UIFont systemFontOfSize:15];
    [_contenttextview becomeFirstResponder];
    _contenttextview.placeholder=@"感谢您提出宝贵意见";

    [aview addSubview:_contenttextview];

    
    

	// Do any additional setup after loading the view.
}

-(void)backto{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getFinishedWithError:(NSError *)error{
//    if ([reply objectForKey:@"type"] isEqualToString:@"dev_reply"]){
//        NSLog(@"开发者回复");
//    }else{
//        NSLog(@"用户回复");
//    }
}
-(void)postdemo{
    NSLog(@"已经发送");
    if (_contenttextview.text.length==0) {
        UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"反馈内容不能为空" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        [alert_ show];
    }else{
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:_contenttextview.text forKey:@"content"];
        //    [dictionary setObject:@"2" forKey:@"age_group"];
        //    [dictionary setObject:@"female" forKey:@"gender"];
        //    [dictionary setObject:@[@"Good",@"VIP"] forKey:@"tags"];
        //    NSDictionary *contact = [NSDictionary dictionaryWithObject:@"shizhongkun@fblife.com" forKey:@"email"];
        //    [dictionary setObject:contact forKey:@"contact"];;
        NSString *stringname=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]];
        if (stringname.length==0||[stringname isEqualToString:@"(null)"]) {
            stringname=@"未登陆用户";
        }
        NSDictionary *remark = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",stringname] forKey:@"name"];
        [dictionary setObject:remark forKey:@"remark"];
        [umFeedback post:dictionary];

    }
     
}
-(void)postFinishedWithError:(NSError *)error{
    NSString *string_code=[NSString stringWithFormat:@"%@",error];
    
    NSLog(@"==%@",string_code);
    if ([string_code isEqualToString:@"(null)"]) {
        [self backto];
    }else{
        UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交不成功，请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert_ show];    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
