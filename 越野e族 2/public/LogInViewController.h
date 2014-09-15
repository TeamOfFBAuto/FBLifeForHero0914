//
//  LogInViewController.h
//  FbLife
//
//  Created by szk on 13-2-26.
//  Copyright (c) 2013年 szk. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "downloadtool.h"
#import "ATMHud.h"
#import "ZhuCeViewController.h"
#import "ZhaoHuiViewController.h"
#import "MyPhoneNumViewController.h"


@protocol LogInViewControllerDelegate <NSObject>

-(void)successToLogIn;

-(void)failToLogIn;

@end


@interface LogInViewController : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate,downloaddelegate>
{
    UIImageView * loginboxImageView;//logo图片  login_box
    UITextField * userNameField;//用户名控件
    UITextField * pwNameField;//密码控件
    
    ASIHTTPRequest *_request;
    
    NSDictionary *dictionary;
    
    ATMHud * hud;
    
    UIImageView * logoImageView;
    
    UIImageView * denglu_imageView;
    
    BOOL isShow;
    
}

@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)UITextField * TextField1;
@property(nonatomic,strong)UITextField * TextField2;

@property(nonatomic,assign)id<LogInViewControllerDelegate>delegate;


+ (LogInViewController *)sharedManager;//单例模式


@end








