//
//  GscanfViewController.h
//  FBCircle
//
//  Created by gaomeng on 14-6-19.
//  Copyright (c) 2014年 szk. All rights reserved.
//


//扫一扫vc
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@class GpersonallSettingViewController;

@interface GscanfViewController : MyViewController<AVCaptureMetadataOutputObjectsDelegate>

{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

@property(nonatomic,assign)GpersonallSettingViewController *delegete;

@end
