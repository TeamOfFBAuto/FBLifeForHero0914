//
//  WriteBlogViewController.h
//  FbLife
//
//  Created by szk on 13-3-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FaceView.h"
#import "FriendListViewController.h"
#import "ASIFormDataRequest.h"
#import "ATMHud.h"
#import "QBImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LoadImgFromImPicker.h"
@interface WriteBlogViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UIActionSheetDelegate,CLLocationManagerDelegate,expressionDelegate,FriendListViewControllerDelegate,ASIHTTPRequestDelegate,UIScrollViewDelegate,QBImagePickerControllerDelegate,AlertRePlaceViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    UIView * options_view;
    
    
    
    CLLocationManager * locationManager;
    
    
    UIView * dingwei;
    UIButton * weizhi_button;
    UILabel * weizhi_label;
    BOOL hasLocated;
    
    UIImageView * imageView;
    
    UIView * morePicView;
    UIImageView * morePicImageView;
    
    int remainTextNum;//还可以输入的字数
    UIButton * wordsNumber_button;//显示还可以输入的字数限制文字
    
    BOOL isFace;
    
    NSString * map_name;
    float longitude;
    float lattitude;
    
    
    ATMHud * hud;
    
    NSMutableArray * allImageArray;
    NSMutableArray * allAssesters;
    
    BOOL image_quality;
    
    QBImagePickerController *imagePickerController;
    
    int issu;
    GrayPageControl * pageControl;
    
}

@property(nonatomic,strong)NSMutableArray * allImageArray1;
@property(nonatomic,strong)NSMutableArray * allAssesters1;
@property(nonatomic,strong)UIImage * image;//图片
@property(nonatomic,assign)BOOL map_flg;//地图信息

@property(nonatomic,strong)UITextView * myTextView;
@property(nonatomic,strong)NSString * theText;
@property(nonatomic,strong)NSString * tid;
@property(nonatomic,strong)NSString * rid;
@property(nonatomic,strong)NSString * username;
@property(nonatomic,strong)NSArray * myAllimgUrl;


@property(nonatomic,strong)NSString * allImageUrl;


@end
