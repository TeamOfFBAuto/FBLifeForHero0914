//
//  DetailViewController.m
//  QRCodeDemo
//
//  Created by soulnear on 13-9-6.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "DetailViewController.h"
#import "NewMineViewController.h"
#import "fbWebViewController.h"
#import "QrcodeViewController.h"

@interface DetailViewController (){
    NSString *string_uid;
    
    UIView * loadingView;
//
//    UIImageView * line;
//    
//    UIView * downView;
//    UIView *rightView;
//    UIView *leftView;
//    UIView* upView;
}

@end

@implementation DetailViewController
@synthesize delegate;
@synthesize line = _line;



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
    
    [MobClick endEvent:@"DetailViewController"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [UIView beginAnimations:@"animation" context:nil];
//    
//    [UIView setAnimationDuration:2];
//    
//    [UIView setAnimationRepeatAutoreverses:YES];
//    
//    [UIView setAnimationRepeatCount:HUGE_VALF];
//    
//    line.frame = CGRectMake(35,280-7.5,250,7.5);
//    
//    [UIView commitAnimations];
    
    [MobClick beginEvent:@"DetailViewController"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (UIView * view in loadingView.subviews)
    {
        [view removeFromSuperview];
    }
    
    [loadingView removeFromSuperview];
    
    [timer invalidate];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(animation1) userInfo:nil repeats:YES];

    
//    upView.alpha = 0.6;
//    upView.backgroundColor = [UIColor blackColor];
//    
//    downView.alpha = 0.6;
//    downView.backgroundColor = [UIColor blackColor];
//    
//    leftView.alpha = 0.6;
//    leftView.backgroundColor = [UIColor blackColor];
//    
//    rightView.alpha = 0.6;
//    rightView.backgroundColor = [UIColor blackColor];
    
    
    
    [myReaderView start];
}


#pragma mark - 返回

-(void)leftButtonTap:(UIButton *)sender
{
    [timer invalidate];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"扫一扫";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    //
//    
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
//        //iOS 5 new UINavigationBar custom background
//        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
//        
//    }
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(5, 3, 12, 43/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back.png"] forState:UIControlStateNormal];
//    
//    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 28)];
//    [back_view addSubview:button_back];
//    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
//    self.navigationItem.leftBarButtonItem=back_item;
    
    
	[self scanning];
}

-(void)backto{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scanning
{
    myReaderView = [[ZBarReaderView alloc]init];
    myReaderView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    myReaderView.readerDelegate = self;
    myReaderView.tracksSymbols = NO;
    //关闭闪光灯
    myReaderView.torchMode = 0;
    
    
    //扫描区域
    //    CGRect scanMaskRect = CGRectMake(37,80,251,312-80);
    
    
    float height = iPhone5?0:-60;
    
    //半透明的浮层
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64)];
    backImageView.image = [UIImage imageNamed:@"saoyisao_bg_640_996.png"];
    [myReaderView addSubview:backImageView];
	
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15,40+height,290,50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    //labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [myReaderView addSubview:labIntroudction];
    
    
    
    //四个角
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50,89+height,220,220)];
    imageView.image = [UIImage imageNamed:@"saoyisao_440_440.png"];
    [myReaderView addSubview:imageView];
    
    
    //文字提示label
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,CGRectGetMaxY(imageView.frame)+19,120,50)];
    tishiLabel.numberOfLines = 0;
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.font = [UIFont systemFontOfSize:13];
    tishiLabel.textColor = [UIColor whiteColor];
    tishiLabel.backgroundColor = [UIColor clearColor];
    tishiLabel.text = @"将取景框对准二维码即可自动扫描";
    [myReaderView addSubview:tishiLabel];
    
    
    upOrdown = NO;
    num =0;
    
    //上下滚动的条
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50,90+height,220,num)];
    _line.image = [UIImage imageNamed:@"11.png"];
    [myReaderView addSubview:_line];
    
    
    UIView * function_view = [[UIView alloc] initWithFrame:CGRectMake(0,(iPhone5?568:480)-64-100,320,100)];
    
    function_view.backgroundColor = RGBCOLOR(53,53,51);
    
    [myReaderView addSubview:function_view];
    
    NSArray * image_array = [NSArray arrayWithObjects:@"saoyisao_photo",@"saoyisao_kacha",@"saoyisao_ma",nil];
    
    NSArray * name_array = [NSArray arrayWithObjects:@"相册",@"开灯",@"我的二维码",nil];
    
    for (int i = 0;i < 3;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor clearColor];
        
        button.frame = CGRectMake(5+105*i,0,90,100);
        
        button.tag = 10000 + i;
        
        [button setImage:[UIImage imageNamed:[image_array objectAtIndex:i]] forState:UIControlStateNormal];
        
        [button setTitle:[name_array objectAtIndex:i] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [button setTitleColor:RGBCOLOR(197,196,194) forState:UIControlStateNormal];
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0,22.25,20,0)];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(70,-50,0,0)];
        
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [function_view addSubview:button];
    }
    
    
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(2,2,216,216)];
    
    loadingView.backgroundColor = RGBCOLOR(6,0,0);
    
    [imageView addSubview:loadingView];
    
    
    UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,30,30)];
    
    activity.center = CGPointMake(loadingView.frame.size.width/2,loadingView.frame.size.height/2);
    
    activity.backgroundColor = [UIColor clearColor];
    
    [activity startAnimating];
    
    [loadingView addSubview:activity];
    
    
    UILabel * loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,280,241,40)];
    
    loadingLabel.center = CGPointMake(loadingView.frame.size.width/2,loadingView.frame.size.height/2 + 40);
    
    loadingLabel.text = @"准备中...";
    
    loadingLabel.textColor = [UIColor whiteColor];
    
    loadingLabel.backgroundColor = [UIColor clearColor];
    
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    
    [loadingView addSubview:loadingLabel];
    
    
//    UIButton * location_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    location_button.frame = CGRectMake(50,330,65,67);
//    
//    location_button.backgroundColor = [UIColor clearColor];
//    
//    
//    [location_button setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down.png"] forState:UIControlStateSelected];
//    
//    [location_button setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor.png"] forState:UIControlStateNormal];
//    
//    //    [location_button setTitle:@"相册" forState:UIControlStateNormal];
//    
//    [location_button addTarget:self action:@selector(locationPhotos:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [myReaderView addSubview:location_button];
//    
//    
//    
//    UIButton * light_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    light_button.frame = CGRectMake(210,330,65,67);
//    
//    light_button.backgroundColor = [UIColor clearColor];
//    
//    //    [light_button setTitle:@"闪光灯" forState:UIControlStateNormal];
//    
//    
//    [light_button setImage:[UIImage imageNamed:@"qrcode_scan_btn_scan_off.png"] forState:UIControlStateSelected];
//    
//    [light_button setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor.png"] forState:UIControlStateNormal];
//    
//    [light_button addTarget:self action:@selector(lightButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [myReaderView addSubview:light_button];
    
    
    
    
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR)
    {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = myReaderView;
    }
    
    [self.view addSubview:myReaderView];
    
    
    //扫描区域计算
    
    CGRect scanMaskRect = CGRectMake(40,79+height,230,230);
    
    myReaderView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:myReaderView.bounds];
    
    
    //    myReaderView.scanCrop = CGRectMake(0.2,0.05,0.47,0.8);
    myReaderView.scanCrop = CGRectMake(0.2,0.05,0.5,0.8);
    //    [myReaderView start];
}


-(void)buttonTap:(UIButton *)button
{
    switch (button.tag - 10000)
    {
        case 0:
        {
            [self locationPhotos:button];
        }
            break;
        case 1:
        {
            [self lightButton:button];
        }
            break;
        case 2:
        {
            BOOL islogIn = [self isLogIn];
            
            if (islogIn)
            {
                QrcodeViewController * qrcode = [[QrcodeViewController alloc] init];
                
                [self.navigationController pushViewController:qrcode animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - 判断是否登录


-(BOOL)isLogIn
{
    BOOL islogin = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!islogin)
    {
        LogInViewController * logIn = [LogInViewController sharedManager];
        
        [self presentViewController:logIn animated:YES completion:NULL];
    }
    return islogin;
}


#pragma mark - 扫描动画


-(void)animation1
{
    //一个图
    if (upOrdown == NO) {
        num ++;
        
        _line.image = [UIImage imageNamed:@"saoyisao_line33.png"];
        _line.frame = CGRectMake(50,_line.frame.origin.y, 220, num);
        _line.alpha = num/220.0f;
        if (num == 220) {
            upOrdown = YES;
            num = 0;
        }
    }
    else {
        num ++;
        
        _line.image = [UIImage imageNamed:@"saoyisao_line33.png"];
        _line.frame = CGRectMake(50,_line.frame.origin.y, 220, num);
        if (num == 220) {
            upOrdown = NO;
            _line.alpha = num/220.0f;
            num = 0;
        }
    }
}




-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
//    CGFloat x,y,width,height;
//    
//    x = rect.origin.x / readerViewBounds.size.width;
//    y = rect.origin.y / readerViewBounds.size.height;
//    width = rect.size.width / readerViewBounds.size.width;
//    height = rect.size.height / readerViewBounds.size.height;
//    
//    NSLog(@"---=-=---  %f ---  %f ---  %f ---  %f",x,y,width,height);
//    
//    return CGRectMake(x,y,width,height);
    
    
    
    CGFloat x,y,width,height;
    x = rect.origin.y / readerViewBounds.size.height;
    y = 1 - (rect.origin.x + rect.size.width) / readerViewBounds.size.width;
    width = (rect.origin.y + rect.size.height) / readerViewBounds.size.height;
    height = 1 - rect.origin.x / readerViewBounds.size.width;
    return CGRectMake(x, y, width, height);
}

-(void)lightButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    myReaderView.torchMode = !myReaderView.torchMode;
}

-(void)locationPhotos:(UIButton *)sender
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController * pickerView = [[UIImagePickerController alloc] init];
    
    pickerView.sourceType = sourceType;
    
    pickerView.delegate = self;
    
    pickerView.allowsEditing = YES;
    
    [self presentViewController:pickerView animated:YES completion:NULL];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ZBarReaderController* read = [ZBarReaderController new];
    read.readerDelegate = self;
    
    UIImage* image = [info objectForKey: UIImagePickerControllerOriginalImage];
    CGImageRef cgImageRef = image.CGImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    ZBarSymbol* symbol = nil;
    
    id <NSFastEnumeration> haha = [read scanImage:cgImageRef];
    
    if (haha)
    {
        for(symbol in haha)
        {
            if (delegate && [delegate respondsToSelector:@selector(successToScanning:)])
            {
                [delegate successToScanning:symbol.data];
            }
            
            // [self.navigationController popViewControllerAnimated:YES];
            /*
             UID：967897
             ID：soulnear
             性别：男
             
             */
            NSString *stringreplace=[NSString stringWithFormat:@"%@",symbol.data];
            
            [self findString:stringreplace];
            
            NSLog(@"在照片库里扫描出的信息%@",stringreplace);
            
        }
    }else
    {
        NSLog(@"没找到二维码");
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未找到二维码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alert show];
        
    }
    
    
    
    
}





- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol *symbol in symbols)
    {
        if (delegate && [delegate respondsToSelector:@selector(successToScanning:)])
        {
            [delegate successToScanning:symbol.data];
        }
        
        
        NSString *stringreplace=[NSString stringWithFormat:@"%@",symbol.data];
        
        
        [self findString:stringreplace];
        
        NSLog(@"lalallalallall扫描出的信息%@",stringreplace);
        
        break;
    }
    
    [readerView stop];
}


-(void)findString:(NSString *)stringreplace
{
    string_uid=[personal getuidwithstring:stringreplace];
    
    
    if ([string_uid isEqualToString:@"0"] || string_uid.length == 0 || [string_uid isEqual:[NSNull null]])
    {
        if ([stringreplace rangeOfString:@"http://"].length && [stringreplace rangeOfString:@"."].length)
        {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"是否打开此链接" message:stringreplace delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.delegate = self;
            
            alert.tag = 100000;
            
            [alert show];
            
        }else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"未识别的二维码" message:stringreplace delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil,nil];
            [alert show];
        }
    }else
    {
        NSLog(@"_____stringuid===%@_____",string_uid);
        [self pushtonewmine];
        
    }
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        fbWebViewController * fbweb = [[fbWebViewController alloc] init];
        
        fbweb.urlstring = alertView.message;
        
        [self.navigationController pushViewController:fbweb animated:YES];
    }
    
    if (buttonIndex == 0) {
        [myReaderView start];
    }
}


-(void)dealloc
{
    
    
}


-(void)pushtonewmine{
    NewMineViewController *_newM=[[NewMineViewController alloc]init];
    _newM.uid=string_uid;
    [self.navigationController pushViewController:_newM animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











