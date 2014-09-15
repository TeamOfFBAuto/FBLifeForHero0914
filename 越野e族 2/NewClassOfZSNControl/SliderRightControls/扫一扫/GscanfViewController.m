//
//  GscanfViewController.m
//  FBCircle
//
//  Created by gaomeng on 14-6-19.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "GscanfViewController.h"

@interface GscanfViewController ()

@end

@implementation GscanfViewController





- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    self.title = @"扫一扫";
    
    
    float height = iPhone5?0:-60;
    
    //半透明的浮层
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64)];
    backImageView.image = [UIImage imageNamed:@"saoyisao_bg_640_996.png"];
    [self.view addSubview:backImageView];
	
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15,40+height,290,50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    //labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    
    
    
    //四个角
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50,89+height,220,220)];
    imageView.image = [UIImage imageNamed:@"saoyisao_440_440.png"];
    [self.view addSubview:imageView];
    
    
    //文字提示label
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,CGRectGetMaxY(imageView.frame)+19,120,50)];
    tishiLabel.numberOfLines = 0;
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.font = [UIFont systemFontOfSize:13];
    tishiLabel.textColor = [UIColor whiteColor];
    tishiLabel.backgroundColor = [UIColor clearColor];
    tishiLabel.text = @"将取景框对准二维码即可自动扫描";
    [self.view addSubview:tishiLabel];
    

    upOrdown = NO;
    num =0;
    
    //上下滚动的条
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50,90+height,220,num)];
    _line.image = [UIImage imageNamed:@"11.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
    UIView * function_view = [[UIView alloc] initWithFrame:CGRectMake(0,(iPhone5?568:480)-64-100,320,100)];
    
    function_view.backgroundColor = RGBCOLOR(53,53,51);
    
    [self.view addSubview:function_view];
    
    NSArray * image_array = [NSArray arrayWithObjects:@"saoyisao_photo",@"saoyisao_kacha",@"saoyisao_ma",nil];
    
    NSArray * name_array = [NSArray arrayWithObjects:@"相册",@"开灯",@"我的二维码",nil];
    
    for (int i = 0;i < 3;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor clearColor];
        
        button.frame = CGRectMake(5+105*i,0,90,100);
        
        [button setImage:[UIImage imageNamed:[image_array objectAtIndex:i]] forState:UIControlStateNormal];
        
        [button setTitle:[name_array objectAtIndex:i] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [button setTitleColor:RGBCOLOR(197,196,194) forState:UIControlStateNormal];
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0,22.25,20,0)];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(70,-50,0,0)];
        
        [function_view addSubview:button];
    }
    
    
    
    
    
}
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


-(void)viewWillAppear:(BOOL)animated
{
    
    if (!TARGET_IPHONE_SIMULATOR) {
        [self setupCamera];
    }
    
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    //_preview.frame =CGRectMake(20,110,280,280);
    _preview.frame = CGRectMake(0, 0, 320, 568);
    
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    NSLog(@"-------%@",stringValue);
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    [self dismissViewControllerAnimated:YES completion:^
     {
         [timer invalidate];
         NSLog(@"123");
         
         
         
     }];
}


@end
