//
//  AboutViewController.m
//  FbLife
//
//  Created by szk on 13-2-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "AboutViewController.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

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
    
    
    NSArray *family=[UIFont familyNames];
    NSLog(@"famlilyname=%@",family);
    

    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    self.title = @"关于";
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, 3, 12, 43/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
//    [back_view addSubview:button_back];
//    back_view.backgroundColor=[UIColor clearColor];
//    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
//    self.navigationItem.leftBarButtonItem=back_item;
    
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, 3, 20, 28)];
    
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    //[button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    [button_back setImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    
    //1008  832
    imageView = [[UIImageView alloc] initWithImage:[personal getImageWithName:iPhone5?@"newAboultIphone5@2x":@"newAbout@2x"]];
    imageView.frame = CGRectMake(0,0,320,iPhone5?1008/2:832/2);
    //    imageView.center = CGPointMake(160,iPhone5?252:208);
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    
    
    UILabel * version_label = [[UILabel alloc] initWithFrame:CGRectMake(0,iPhone5?400:315,320,30)];
    
    version_label.text = [NSString stringWithFormat:@"版本:%@",NOW_VERSION];
    
    version_label.textColor = RGBCOLOR(88,88,88);
    
    version_label.font = [UIFont systemFontOfSize:15];
    
    version_label.textAlignment = NSTextAlignmentCenter;
    
    version_label.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    [self.view addSubview:version_label];

 // [self Mytool];
    
      
}

-(void)checkallmynotification{
    flagofpage++;
    
    switch (flagofpage) {
        case 1:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_4.png"];
        }
            break;
        case 2:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_3.png"];

        }
            break;
        case 3:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_2.png"];

        }
            break;
        case 4:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_1.png"];

        }
            break;
            
        default:
            break;
    }
    
    if (flagofpage==4) {
        flagofpage=0;
    }
    
    
    
    
    
}

-(void)dongqilai{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"AboutViewController"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"AboutViewController"];
}

#pragma mark-infodelegate
-(void)finishloadNotificationInfo:(NSArray *)arrayinfo errcode:(NSString *)string_codeerror errordata:(NSString *)errorinfodata{
    
    NSLog(@"%s ====%@",__FUNCTION__,arrayinfo);
}
-(void)failedtoloaddata{
    
}
#pragma mark-测试自己写的效率
-(void)Mytool{
 
    newstool=[[downloadtool alloc]init];
    NSString *string_url=[NSString stringWithFormat:@"http://bbs2.fblife.com/bbsapinew/getthreadsnew_tmp.php?tid=1573337&page=1&formattype=json"];
    NSLog(@"请求的url为%@",string_url);
    [newstool setUrl_string:string_url];
    newstool.delegate=self;
    
    [newstool start];
//
    
}


-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data
{
    NSLog(@"已经得到数据");
 //   imageView.image=[UIImage imageWithData:data];
    
    
 NSDictionary *   dic = [data objectFromJSONData];
    NSLog(@"dic==%@",dic);
//    
//    NSArray *array_info=[dic objectForKey:@"info"];
//
//    NSLog(@"array_info===%@",array_info);
//    
//    NSMutableArray *array_msg=[[NSMutableArray alloc]init];
//    
//    NSString *string__hard;
//    for (int i=0; i<array_info.count; i++) {
//        NSDictionary *dic_=[array_info objectAtIndex:i];
//        NSString *string_msg=[dic_ objectForKey:@"msg_message"];
//        [array_msg addObject:string_msg];
//        
//        if (i==2) {
//            string__hard=[NSString stringWithFormat:@"%@",string_msg];
//            string__hard=[string__hard stringByReplacingOccurrencesOfString:@"[img]http://img1.fblife.com/attachments1/day_130803/20130803_95fcf5cb82ef08a74558T6u37XxPTP3i.png.thumb.jpg[/img]" withString:@""];
//            string__hard=[string__hard stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
//            
//            TTStyledTextLabel *label=[[TTStyledTextLabel alloc]initWithFrame:CGRectMake(0, 10, 320, 400)];
//            label.text=[TTStyledText textFromXHTML:string__hard lineBreaks:YES URLs:YES];
//            [self.view addSubview:label];
//            label.backgroundColor=[UIColor redColor];
//        }
//    }
//    NSLog(@"-----msg===%@",array_msg);
//    
//    
  
//    NSLog(@"info=%@",[dic objectForKey:@"seller_info"]);
//    NSDictionary *dic_inf=[[dic objectForKey:@"data"] objectForKey:@"seller_info"] ;
//    
//    NSString *string_=[NSString stringWithFormat:@"%@",[dic_inf objectForKey:@"seller_name"]];
//    NSLog(@"string_jiangnan=%@",string_);
    
}

-(void)downloadtoolError{
       UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接超时，请检查您的网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      [alert_ show];
}



-(void)backto{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//对应ios6下的横竖屏问题
- (BOOL)shouldAutorotate{
    return  NO;
}
@end
