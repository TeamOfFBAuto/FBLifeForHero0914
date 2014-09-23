//
//  GuanggaoViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "GuanggaoViewController.h"

#import "SzkLoadData.h"

@interface GuanggaoViewController ()
{
    BOOL isHidden;
}

@end

@implementation GuanggaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    flagofpage=0;
    
    //1
    bigimageview=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    bigimageview.backgroundColor=[UIColor colorWithRed:245/255.f green:244/255.f blue:242/255.f alpha:1];
    [self.view addSubview:bigimageview];
    //2
    iMagelogo=[[UIImageView alloc]init];
    
    iMagelogo.frame=CGRectMake(0,iPhone5? 568-217/2:480-217/2, 320, 217/2);
    
    iMagelogo.image=[UIImage imageNamed:@"ios7_fengmianlogo2.png"];
    
    //3
    
    guanggao_image=[[AsyncImageView alloc]init];
    guanggao_image.alpha=0;
    
    guanggao_image.delegate = self;
    
    [bigimageview addSubview:guanggao_image];
    [bigimageview addSubview:iMagelogo];
    
    //4
    
    UIView *redview=[[UIView alloc]initWithFrame:CGRectMake(0, iPhone5?568/2-40:480/2-40, 320, 12)];
    redview.backgroundColor=[UIColor clearColor];
    [bigimageview addSubview:redview];
    img_TEST=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_loading61_12_4.png"]];
    img_TEST.center=CGPointMake(160, 6);
    [redview addSubview:img_TEST];
    NSTimer *theTimer;
    theTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(changepic) userInfo:nil repeats:YES];
    
    //加手势
    
    bigimageview.userInteractionEnabled=YES;
    guanggao_image.userInteractionEnabled=YES;
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [guanggao_image addGestureRecognizer:singleRecognizer];
    
    //点击跳过的button
    
    UIButton *buttonTiaoguo=[[UIButton alloc]initWithFrame:CGRectMake(245, 20, 62, 30)];
    [buttonTiaoguo setTitle:@"点击跳过" forState:UIControlStateNormal];
    buttonTiaoguo.titleLabel.font=[UIFont systemFontOfSize:12];
    [buttonTiaoguo setBackgroundColor:RGBACOLOR(245, 245, 245, 0.7)];
    [buttonTiaoguo setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    
    CALayer *l = [buttonTiaoguo layer];   //获取ImageView的层
    [l setMasksToBounds:YES];
    [l setCornerRadius:2.0f];
    
    
    [buttonTiaoguo addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [bigimageview addSubview:buttonTiaoguo];
    
    
    
    [self loadGuanggaoData];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark-点击之后跳到fbweb页面

-(void)handleSingleTapFrom{
    
    
    
    
    
    if (string_url.length!=0&&![string_url isEqualToString:@"(null)"]) {
        
        
        NSDictionary *dic_userinfo=@{@"link": string_url};
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TouchGuanggao" object:self userInfo:dic_userinfo];
        
        
        
        [self back];
        
    }
    
    
    
    
}

#pragma mark--请求数据的动画
-(void)changepic{
    
    
    
    
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


#pragma mark-网络数据

-(void)loadGuanggaoData{
    
    
    
    __weak typeof(self) wself =self;
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    
    
    int mytime=arc4random()%10000;
    
    NSString *str_search=[NSString stringWithFormat:@"http://cmsweb.fblife.com/data/app.ad.txt?updatetime=%d",mytime];
    
    
    NSLog(@"在读。。。===%@",str_search);
    
    
    
    [loaddata SeturlStr:str_search mytest:^(NSDictionary *dicinfo, int errcode) {
        
        
        
        
        NSLog(@"在读。。。数据=%@",dicinfo);
        
        if (errcode==0&&dicinfo.count!=0) {
            
            
            
            [wself refreshNormalWithDic:dicinfo];

        }else{
        
        
            sleep(1);
            if (!isHidden) {
                [wself loadGuanggaoData];
            }
            
        
        }
        
        
        
        
        
        
    }];
    
    
    NSLog(@"广告的接口=。。=%@",str_search);
    
    
    
    
}

-(void)refreshNormalWithDic:(NSDictionary *)dicc{
    
    /**
     {
     imgsrc = "http://img10.fblife.com/attachments/20140717/1405565006.jpg";
     url = "http://www.fblife.com";
     }
     
     */
    string_url=[NSString stringWithFormat:@"%@",[dicc objectForKey:@"url"]];
    
    NSString *str_guanggao=[NSString stringWithFormat:@"%@",[dicc objectForKey:@"imgsrc"]];
    [guanggao_image loadImageFromURL:str_guanggao withPlaceholdImage:nil];
    
    NSLog(@"xxx==%@",str_guanggao);
    
}

#pragma mark-asyimg的代理

-(void)handleImageLayout:(AsyncImageView *)tag
{
    
    
    
    
    [img_TEST removeFromSuperview];
    guanggao_image.image=iPhone5?guanggao_image.image:[self getSubImage:CGRectMake(0, (568-480)*2, 640,guanggao_image.image.size.height)];
    
    guanggao_image.frame=CGRectMake(0, 0, guanggao_image.image.size.width/2, guanggao_image.image.size.height/2+2);
    
    NSLog(@"appdelegate===仔仔到了图片");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    guanggao_image.alpha=1;
    // iMagelogo.frame=CGRectMake(43/2,iPhone5? 413+44+40:413, 566/2, 85/2);
    [UIView commitAnimations];
    [self performSelector:@selector(back) withObject:nil afterDelay:4];
}


#pragma mark-修改图片的大小

-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(guanggao_image.image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


#pragma mark-返回

-(void)back{
    
    
    isHidden = YES;
    
    [self dismissViewControllerAnimated: NO  completion:NULL];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if (!isBack) {
        isBack=!isBack;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshcompre" object:self userInfo:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



-(void)dealloc{
    
    
    NSLog(@"");
}

-(void)seccesDownLoad:(UIImage *)image{
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
