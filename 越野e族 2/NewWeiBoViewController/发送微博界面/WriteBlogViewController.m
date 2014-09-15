//
//  WriteBlogViewController.m
//  FbLife
//
//  Created by szk on 13-3-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "WriteBlogViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "WeiBoFaceScrollView.h"
#import "FriendListViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "QBImagePickerController.h"
#import "DraftDatabase.h"

@interface WriteBlogViewController ()
{
    WeiBoFaceScrollView * scrollView;
    AlertRePlaceView * _replaceAlertView;
    UINavigationBar *nav;
}

@end

@implementation WriteBlogViewController
@synthesize image = _image;
@synthesize map_flg = _map_flg;
@synthesize myTextView;
@synthesize tid;
@synthesize rid;
@synthesize username;
@synthesize theText;
@synthesize allImageUrl;
@synthesize allImageArray1;
@synthesize allAssesters1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)allImageArraySet:(NSString *)imageurl
{
    if (allImageUrl.length != 0)
    {
        NSArray * ImageArray = [allImageUrl componentsSeparatedByString:@"||"];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        for (int i = 0;i < ImageArray.count;i++)
        {
            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:0]];
            NSURL *referenceURL = [NSURL URLWithString:imgurl];
            
            __block UIImage *returnValue = nil;
            [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
             {
                 returnValue = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]]; //Retain Added
                 
                 if (returnValue) {
                     [allImageArray addObject:returnValue];
                     
                     [allAssesters addObject:returnValue];
                 }
                 
                 
                 //                UIButton * button = (UIButton *)[morePicView viewWithTag:101+i];
                 //
                 //                [button setImage:returnValue forState:UIControlStateNormal];
                 
                 
             } failureBlock:^(NSError *error) {
                 // error handling
             }];
        }
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    hud.delegate=nil;
    [hud removeFromParentViewController];
    hud=nil;
    
    [MobClick endEvent:@"WriteBlogViewController"];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"WriteBlogViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    allAssesters = [[NSMutableArray alloc] init];
    
    allImageArray = [[NSMutableArray alloc] init];
    
    [allAssesters addObjectsFromArray:allAssesters1];
    [allImageArray addObjectsFromArray:allImageArray1];
    
    
    //    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
	//自定义navigation
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //创建navbar
    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,aScreenRect.size.width,IOS_VERSION>=7.0?64:44)];
    //创建navbaritem
    UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:@"发表微博"];
    
    nav.barStyle = UIBarStyleBlackOpaque;
    
    [nav pushNavigationItem:NavTitle animated:YES];
    
    [self.view addSubview:nav];
    
    
    UIBarButtonItem * space_button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_button.width = MY_MACRO_NAME?-4:5;
    
    
    
    //创建barbutton 创建系统样式的
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,31/2,32/2)];
    
    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"logIn_close.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    NavTitle.leftBarButtonItems=@[space_button,back_item];
    
    UIButton * send_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    send_button.frame = CGRectMake(0,0,30,44);
    
    send_button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [send_button setTitle:@"发送" forState:UIControlStateNormal];
    
    send_button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [send_button setTitleColor:RGBCOLOR(89,89,89) forState:UIControlStateNormal];
    
    [send_button addTarget:self action:@selector(loginH) forControlEvents:UIControlEventTouchUpInside];
    
    NavTitle.rightBarButtonItems = @[space_button,[[UIBarButtonItem alloc] initWithCustomView:send_button]];
    //设置barbutton
    [nav setItems:[NSArray arrayWithObject:NavTitle]];
    
    
    if([nav respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [nav setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,44)];
    
    title_label.text = @"发表微博";
    
    title_label.backgroundColor = [UIColor clearColor];
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.textAlignment = NSTextAlignmentCenter;
    
    title_label.font = TITLEFONT;
    
    NavTitle.titleView = title_label;
    
    
    
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10,IOS_VERSION>=7.0?64:55,300,100)];
    myTextView.backgroundColor =IOS_VERSION>=7.0?[UIColor whiteColor]:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    
    myTextView.backgroundColor = [UIColor clearColor];
    
    myTextView.delegate = self;
    
    if (theText.length ==0 || [theText isEqualToString:@""])
    {
        myTextView.text = @"分享新鲜事......";
        myTextView.tag = 100;
        myTextView.textColor = RGBCOLOR(174,174,174);
        myTextView.selectedRange =  NSMakeRange(0, 0);
        
    }else
    {
        myTextView.text = theText;
        myTextView.tag = 101;
        myTextView.textColor = [UIColor blackColor];
    }
    
    myTextView.font = [UIFont systemFontOfSize:17];
    myTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    myTextView.scrollEnabled = YES;
    //    [myTextView sizeToFit];
    [myTextView becomeFirstResponder];
    
    [self.view addSubview:myTextView];
    
    
    
    options_view = [[UIView alloc] initWithFrame:CGRectMake(0,IOS_VERSION>=7.0?79:59,320,73)];
    options_view.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    [self.view addSubview:options_view];
    
    dingwei = [self addDingweiView:CGRectMake(30,0,120,20)];
    dingwei.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    dingwei.hidden = YES;
    [options_view addSubview:dingwei];
    
    
    weizhi_button = [UIButton buttonWithType:UIButtonTypeCustom];
    weizhi_button.frame = CGRectMake(10,5,150,20);
    [weizhi_button setImage:[personal getImageWithName:@"dingwei_bg@2x"] forState:UIControlStateNormal];
    weizhi_button.hidden = YES;
    [options_view addSubview:weizhi_button];
    
    
    weizhi_label = [[UILabel alloc] initWithFrame:CGRectMake(22,0,110,20)];
    weizhi_label.textAlignment = NSTextAlignmentLeft;
    weizhi_label.font = [UIFont systemFontOfSize:13];
    weizhi_label.backgroundColor = [UIColor clearColor];
    [weizhi_button addSubview:weizhi_label];
    
    
    wordsNumber_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    wordsNumber_button.frame = CGRectMake(260,2,60,25);
    
    [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
    
    [wordsNumber_button setTitleColor:RGBCOLOR(154,162,166) forState:UIControlStateNormal];
    
    wordsNumber_button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [wordsNumber_button setTitleEdgeInsets:UIEdgeInsetsMake(1,0,0,12)];
    
    
    // [wordsNumber_button setImage:[personal getImageWithName:@"111@2x"] forState:UIControlStateNormal];
    
    UIImageView *xximg=[[UIImageView alloc]initWithFrame:CGRectMake(40,9,9,9)];
    xximg.image=[UIImage imageNamed:@"writeblog_delete_image.png"];
    [wordsNumber_button addSubview:xximg];
    
    wordsNumber_button.backgroundColor = [UIColor clearColor];
    
    [wordsNumber_button setImageEdgeInsets:UIEdgeInsetsMake(2,35,0,0)];
    
    [wordsNumber_button addTarget:self action:@selector(doTap:) forControlEvents:UIControlEventTouchUpInside
     ];
    
    [options_view addSubview:wordsNumber_button];
    
    
    UIImageView * faceImageView = [[UIImageView alloc] initWithImage:[personal getImageWithName:@"write_blog_back@2x"]];
    
    faceImageView.userInteractionEnabled = YES;
    
    faceImageView.frame = CGRectMake(0,30,320,43);
    
    [options_view addSubview:faceImageView];
    
    
    NSArray * array = [NSArray arrayWithObjects:@"photo_write",@"where_write",@"talk_write",@"write_blog_at",@"smile_write",@"write_blog_key",nil];
    
    for (int i = 0;i < 5;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = 1000 + i;
        
        
        if (i == 1) {
            UIImageView * imageView11 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,30/2,44/2)];
            
            imageView11.center = CGPointMake(12.5,12.5);
            
            imageView11.image = [UIImage imageNamed:@"where_write.png"];
            
            [button addSubview:imageView11];
        }else{
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[array objectAtIndex:i]]] forState:UIControlStateNormal];
        }
        
        
        [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(12 + 68.75 * i,7.5,25,25);
        
        [faceImageView addSubview:button];
    }
    
    
    
    UIButton * deleteImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    deleteImageView.frame = CGRectMake(0,0,25,20);
    
    deleteImageView.hidden = YES;
    
    deleteImageView.center = CGPointMake(0,0);
    
    deleteImageView.tag = 999999;
    
    [deleteImageView setImage:[personal getImageWithName:@"delete"] forState:UIControlStateNormal];
    
    [deleteImageView addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:deleteImageView];
    
    
    
    scrollView = [[WeiBoFaceScrollView alloc] initWithFrame:CGRectMake(0,(iPhone5?(568-215):(480-215))-(MY_MACRO_NAME?0:20),320,215) target:self];
    scrollView.hidden = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(320*3,0);
    [self.view addSubview:scrollView];
    
    
    
    pageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0,0,320,25)];
    
    //    pageControl.center = CGPointMake(160,iPhone5?(568-20-(IOS_VERSION>=7.0?0:20)):(480-20-(IOS_VERSION>=7.0?0:20)));
    
    pageControl.center = CGPointMake(160,215-20);
    
    pageControl.numberOfPages = 3;
    
    pageControl.currentPage = 0;
    
    [scrollView addSubview:pageControl];
    
    
    
    morePicView = [[UIView alloc] initWithFrame:CGRectMake(0,iPhone5?(568-215-(IOS_VERSION>=7.0?0:20)):(480-215-(IOS_VERSION>=7.0?0:20)),320,215)];
    
    morePicView.backgroundColor = RGBCOLOR(241,241,241);
    
    morePicView.hidden = YES;
    
    [self.view addSubview:morePicView];
    
    
    morePicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,135)];
    
    morePicImageView.userInteractionEnabled = YES;
    
    morePicImageView.backgroundColor = RGBCOLOR(241,241,241);
    
    [morePicView addSubview:morePicImageView];
    
    
    if (self.myAllimgUrl.count>0)
    {
        [self comeonmyimage];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self comeonmyimage];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                NSLog(@"我艹 -----  %@",allImageArray);
//                [self setbutton];
//            });
//        });
    }else
    {
        [self setbutton];
    }
    
    
    UILabel * highPic_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,150,200,44)];
    
    highPic_titleLabel.text = @"开启上传高清图片";
    
    highPic_titleLabel.backgroundColor = [UIColor clearColor];
    
    highPic_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    highPic_titleLabel.textColor = RGBCOLOR(43,43,43);
    
    [morePicView addSubview:highPic_titleLabel];
    
    
    UISwitch * highPicSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(160,156,80,25)];
    
    highPicSwitch.on = YES;
    
    image_quality = YES;
    
    [highPicSwitch addTarget:self action:@selector(chooseImageQuality:) forControlEvents:UIControlEventValueChanged];
    
    [morePicView addSubview:highPicSwitch];
    
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
    
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}


#pragma mark--多线程取图片

-(void)comeonmyimage
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    __weak typeof(self)bself = self;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        
        for (int i = 0;i < self.myAllimgUrl.count;i++)
        {
            NSString *imgurl=[NSString stringWithFormat:@"%@",[self.myAllimgUrl objectAtIndex:i]];
            NSURL *referenceURL = [NSURL URLWithString:imgurl];
            
            __block UIImage *returnValue = nil;
            [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
             {
                 
                 //returnValue = [UIImage imageWithCGImage:[asset thumbnail]]; //Retain Added
                 ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                 
                 CGImageRef imgRef = [assetRep fullScreenImage];
                 
                 returnValue=[UIImage imageWithCGImage:imgRef
                                                 scale:assetRep.scale
                                           orientation:(UIImageOrientation)assetRep.orientation];
                 
                 if (returnValue)
                 {
                     [allImageArray addObject:returnValue];
                     [allAssesters addObject:imgurl];
                 }
                 
                 NSLog(@"怎么没有呢1111 ----  %@",allImageArray);
                 
                 if (i == self.myAllimgUrl.count-1) {
                     [bself setbutton];
                 }
                 
             } failureBlock:^(NSError *error)
             {
                 // error handling
             }];
        }
        
//        dispatch_async(dispatch_get_main_queue(), ^{
    
            NSLog(@"怎么没有呢 ----  %@",allImageArray);
//            [bself setbutton];
    
//        });
//    });
    
    
    
}



-(void)setbutton
{
    for (int i = 0;i < 2;i++)
    {
        for (int j = 0;j < 5;j++)
        {
            UIButton * imageV = [UIButton buttonWithType:UIButtonTypeCustom];
            imageV.frame = CGRectMake(5 + 62.75*j,7+62.75*i,59,59);
            imageV.imageView.clipsToBounds = YES;
            imageV.imageView.contentMode = UIViewContentModeScaleAspectFill;
            if (i == 0 && j == 0)
            {
                [imageV setImage:[UIImage imageNamed:@"write_blog_add_more.png"] forState:UIControlStateNormal];
                [imageV addTarget:self action:@selector(addPicture:) forControlEvents:UIControlEventTouchUpInside];
            }else
            {
                [imageV setImage:[UIImage imageNamed:@"write_blog_more.png"] forState:UIControlStateNormal];
                if (j+i*5-1 < allImageArray.count)
                {
                    [imageV setImage:[allImageArray objectAtIndex:j+i*5-1]  forState:UIControlStateNormal];
                }
                
                
                [imageV addTarget:self action:@selector(removeSelf:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            imageV.tag = j+i*5+100;
            [morePicImageView addSubview:imageV];
        }
    }
}



-(void)removeSelf:(UIButton *)button
{
    if (button.tag-101 < allImageArray.count)
    {
        [allImageArray removeObjectAtIndex:button.tag-101];
        [allAssesters removeObjectAtIndex:button.tag-101];
        
        [self returnAllImageUrl];
        for (UIButton *oldbutton in morePicImageView.subviews) {
            [oldbutton removeFromSuperview];
        }
        
        
        [self setbutton];
    }
}

-(void)addPicture:(UIButton *)button
{
    
    
    if (allImageArray.count >=9)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"最多上传9张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        
        return;
    }
    
    
    
    
    if (!imagePickerController)
    {
        imagePickerController = nil;
    }
    
    imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    
    imagePickerController.assters = allAssesters;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    
    
    navigationController.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    if([navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        //iOS 5 new UINavigationBar custom background
        [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}


-(void)chooseImageQuality:(UISwitch *)swith
{
    image_quality = swith.on;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    pageControl.center = CGPointMake(160+scrollView1.contentOffset.x,215-20);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    //获取当前页码
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    
    //设置当前页码
    pageControl.currentPage = index;
}

-(void)deleteImage:(UIButton *)button
{
    imageView.image = nil;
    button.hidden = YES;
    [imageView.layer removeAnimationForKey:@"shakeAnimation"];
}


-(void)deleteTap:(UITapGestureRecognizer *)sender
{
    UIImageView * imageView1 = (UIImageView *)sender.view;
    
    if (imageView1.image)
    {
        UIButton * delete = (UIButton *)[imageView1 viewWithTag:999999];
        
        delete.hidden = NO;
        
        [self wobble:imageView1];
    }
}


- (void)wobble:(UIImageView *)wobble
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount = MAXFLOAT;
    shake.removedOnCompletion = NO;
    CGFloat rotation = 0.03;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(wobble.layer.transform,-rotation, 0.0 ,0.0 ,1.5)];
    shake.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(wobble.layer.transform, rotation, 0.0 ,0.0 ,1.5)];
    [wobble.layer addAnimation:shake forKey:@"shakeAnimation"];
}


-(UIView *)addDingweiView:(CGRect)frame
{
    UIView * view = [[UIView alloc] initWithFrame:frame];
    
    UIActivityIndicatorView * activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.frame = CGRectMake(0,0,20,20);
    activityIndicatorView.backgroundColor = [UIColor clearColor];
    [activityIndicatorView startAnimating];
    [view addSubview:activityIndicatorView];
    
    
    UILabel * dingweilaebl = [[UILabel alloc] initWithFrame:CGRectMake(20,0,100,20)];
    dingweilaebl.backgroundColor = [UIColor clearColor];
    dingweilaebl.text = @"定位中•••";
    dingweilaebl.font = [UIFont systemFontOfSize:13];
    dingweilaebl.textAlignment = NSTextAlignmentLeft;
    
    [view addSubview:dingweilaebl];
    
    return view;
}

-(void)doButton:(UIButton *)button
{
    switch (button.tag-1000)
    {
        case 0:
        {
            [UIView animateWithDuration:0.3 animations:^
             {
                 morePicView.hidden = NO;
                 
                 options_view.frame =  CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-72-215,320,73);
                 myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-73-20-44-215:480-73-20-44-215)-(MY_MACRO_NAME?0:20));
                 [myTextView resignFirstResponder];
             }];
            
            UIActionSheet * actionSheet = [[UIActionSheet alloc]  initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册",nil];
            actionSheet.delegate = self;
            actionSheet.tag = 1000001;
            [actionSheet showInView:self.view];
        }
            break;
        case 1:
        {
            dingwei.hidden = NO;
            weizhi_button.hidden = YES;
            hasLocated = NO;
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            [locationManager startUpdatingLocation];
        }
            break;
        case 2:
        {
            [self huati];
        }
            break;
        case 3:
        {
            //@某人
            FriendListViewController * list = [[FriendListViewController alloc] init];
            list.delegate = self;
            
            UINavigationController * list_nav = [[UINavigationController alloc] initWithRootViewController:list];
            
            [self presentViewController:list_nav animated:YES completion:NULL];
        }
            break;
        case 4:
        {
            isFace = !isFace;
            [button setImage:[personal getImageWithName:isFace?@"write_blog_key@2x":@"smile_write@2x"] forState:UIControlStateNormal];
            
            scrollView.hidden = !isFace;
            
            if (isFace)
            {
                //弹出表情
                
                morePicView.hidden = YES;
                pageControl.hidden = NO;
                scrollView.hidden = NO;
                
                [UIView animateWithDuration:0.3 animations:^{
                    options_view.frame =  CGRectMake(0,((iPhone5?568:480)-72-215)-(MY_MACRO_NAME?0:20),320,73);
                    myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-73-20-44-215:480-20-73-44-215)-(MY_MACRO_NAME?0:20));
                    [myTextView resignFirstResponder];
                }];
            }else
            {
                //弹出键盘
                
                if (allImageArray.count)
                {
                    morePicView.hidden = NO;
                    options_view.frame =  CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-73-215,320,73);
                    myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44-215:480-20-73-44-215)-(MY_MACRO_NAME?0:20));
                }else
                {
                    [myTextView becomeFirstResponder];
                }
            }
        }
            break;
            
        default:
            break;
    }
}


-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name
{
    
    if (myTextView.tag == 100)
    {
        myTextView.text = @"";
        myTextView.textColor = [UIColor blackColor];
        myTextView.tag = 101;
    }
    
    
    myTextView.text = [myTextView.text stringByAppendingString:name];
}

//点击话题打开
-(void)huati
{
    
    if (myTextView.tag == 100)
    {
        myTextView.text = @"";
        myTextView.textColor = [UIColor blackColor];
        myTextView.tag = 101;
    }
    
    
    if (remainTextNum < 0)
    {
        return;
    }
    // 获得光标所在的位置
    int location = myTextView.selectedRange.location;
    // 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
    NSString *content = myTextView.text;
    NSString *result = [NSString stringWithFormat:@"%@#插入新话题#%@",[content substringToIndex:location],[content substringFromIndex:location]];
    // 将调整后的字符串添加到UITextView上面
    myTextView.text = result;
    myTextView.selectedRange = NSMakeRange(location+6, 0);
    
    
    NSString  * nsTextContent=myTextView.text;
    int   existTextNum=[nsTextContent length];
    remainTextNum= 140-existTextNum;
    //    wordsNumber_label.text = [NSString stringWithFormat:@"%i",remainTextNum];
    [wordsNumber_button setTitle:[NSString stringWithFormat:@"%i",remainTextNum] forState:UIControlStateNormal];
    
}


- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^
     {
         options_view.frame = CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-73-_keyboardRect.size.height,320,73);
         
         myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44-_keyboardRect.size.height:480-20-73-44-_keyboardRect.size.height)-(MY_MACRO_NAME?0:20));
     }];
}

-(void)backH
{
    [myTextView resignFirstResponder];
    
    scrollView.hidden = YES;
    
    morePicImageView.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        options_view.frame = CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-72,320,73);
        
        myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44:480-20-73-44)-(MY_MACRO_NAME?0:20));
    }];
    
    if ((myTextView.tag == 100 && [myTextView.text isEqualToString:@"分享新鲜事......"])||[theText isEqualToString:myTextView.text])
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else
    {
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存草稿",@"不保存",nil];
        
        sheet.delegate = self;
        
        sheet.tag = 1000002;
        
        [sheet showInView:self.view];
    }
}






//发送
-(void)loginH
{
    if (myTextView.text.length > 140)
    {
        [self warningMessage];
        return;
    }
    
    
    if ((myTextView.tag == 100 && [myTextView.text isEqualToString:@"分享新鲜事......"])|| myTextView.text==nil)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NS_TISHI message:NS_TISHI_KONG
                                                       delegate:self cancelButtonTitle:NS_KNOWED otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    
    nav.userInteractionEnabled = NO;
    [self updateLoading];
    
    [myTextView resignFirstResponder];
    
    morePicView.hidden = YES;
    
    pageControl.hidden = YES;
    
    scrollView.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^
     {
         options_view.frame = CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-72,320,73);
         
         myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44:480-20-73-44)-(MY_MACRO_NAME?0:20));
     }];
    
    
    
    if (allImageArray.count)
    {
        //带图片上传
        
        self.navigationItem.rightBarButtonItem.enabled=NO;
        [self uploadImage];
        
    }else
    {
        [myTextView resignFirstResponder];
        pageControl.hidden = YES;
        scrollView.hidden = YES;
        options_view.frame = CGRectMake(0,(iPhone5?568:480)-50-(MY_MACRO_NAME?0:20),320,73);
        
        
        self.navigationItem.rightBarButtonItem.enabled=NO;
        
        
        NSString * contetn = myTextView.text;
        
        if (myTextView.tag == 100 && [myTextView.text isEqualToString:@"分享新鲜事......"])
        {
            contetn = @"分享图片";
        }
        
        NSString* fullURL;
        if (_map_flg)
        {
            //带经纬度上传
            fullURL = [NSString stringWithFormat:URLJWD,[contetn stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],@"0",[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD],longitude,lattitude,[map_name stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding]];
            NSLog(@"地理位置信息1 =  %f---%f----%@",longitude,lattitude,map_name);
        }else
        {
            fullURL = [NSString stringWithFormat:URL_UPLOAD,[contetn stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
        }
        
        NSLog(@"18请求的url：%@",fullURL);
        
        
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullURL]];
        request.tag = 3;
        request.delegate = self;
        
        [request startAsynchronous];
        
    }
    
    
    
}


//正在发送

-(void)updateLoading
{
    
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    //    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:@"正在发送"];
    [hud setActivity:YES];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
}


//文字太多提示

-(void)warningMessage
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:@"内容不能超过140个字"];
    [hud setActivity:NO];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
}


//上传图片
#define TT_CACHE_EXPIRATION_AGE_NEVER     (1.0 / 0.0)   // inf
- (void)uploadImage
{
    
    NSString* fullURL = [NSString stringWithFormat:URLIMAGE,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    //  NSString * fullURL = [NSString stringWithFormat:@"http://t.fblife.com/openapi/index.php?mod=doweibo&code=addpicmuliti&fromtype=b5eeec0b&authkey=UmZaPlcyXj8AMQRoDHcDvQehBcBYxgfbtype=json"];
    
    
    NSLog(@"上传图片的url  ——--  %@",fullURL);
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:fullURL]];
    request.delegate = self;
    request.tag = 1;
    
    //得到图片的data
    NSData* data;
    //获取图片质量
    //  NSString *tupianzhiliang=[[NSUserDefaults standardUserDefaults] objectForKey:TUPIANZHILIANG];
    
    NSMutableData *myRequestData=[NSMutableData data];
    
    NSLog(@"imagearray -----  %d",allImageArray.count);
    
    for (int i = 0;i < allImageArray.count; i++)
    {
        [request setPostFormat:ASIMultipartFormDataPostFormat];
        
        UIImage *image=[allImageArray objectAtIndex:i];
        
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedImage%d.png",i]];
        //also be .jpg or another
        NSData *imageData = UIImagePNGRepresentation(image);
        //UIImageJPEGRepresentation(image)
        [imageData writeToFile:savedImagePath atomically:NO];
        
        
        
        
        
        
        
        UIImage * newImage = [personal scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
        
        data = UIImageJPEGRepresentation(newImage,image_quality?0.5:0.3);
        
        
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [myRequestData length]]];
        
        //设置http body
        
        [request addData:data withFileName:[NSString stringWithFormat:@"boris%d.png",i] andContentType:@"image/PNG" forKey:@"topic[]"];
        
        //  [request addData:myRequestData forKey:[NSString stringWithFormat:@"boris%d",i]];
        
    }
    
    [request setRequestMethod:@"POST"];
    
    request.cachePolicy = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    request.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
    
    [request startAsynchronous];
    
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    @try {
        nav.userInteractionEnabled = YES;
        [hud hide];
        if (request.tag == 1)
        {
            NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[request.responseData objectFromJSONData]];
            
            NSLog(@"上传图片返回结果 ------   %@",dic);
            //    NSString *errcode = [dic objectForKey:ERRCODE];
            
            
            if ([[dic objectForKey:@"errcode"] intValue] == 0)
            {
                NSDictionary * dictionary = [dic objectForKey:DATA];
                
                NSArray * array2 = [dictionary allKeys];
                
                NSArray *array = [array2 sortedArrayUsingSelector:@selector(compare:)];
                
                NSString* authod = @"";
                
                
                for (int i = 0;i < array.count;i++)
                {
                    if (i == 0)
                    {
                        authod = [array objectAtIndex:i];
                    }else
                    {
                        authod = [NSString stringWithFormat:@"%@|%@",authod,[array objectAtIndex:i]];
                    }
                    
                }
                
                NSLog(@"authod -------   %@",authod);
                
                NSString * contetn = myTextView.text;
                
                if (myTextView.tag == 100 && [myTextView.text isEqualToString:@"分享新鲜事......"])
                {
                    contetn = @"分享图片";
                }
                
                
                NSString* fullURL;
                if (_map_flg)
                {
                    _map_flg=NO;
                    //带经纬度上传
                    fullURL = [NSString stringWithFormat:URLJWD,[contetn stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[authod stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD],longitude,lattitude,[map_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                }else
                {
                    fullURL = [NSString stringWithFormat:URLIMAGEID,[contetn stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[authod stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
                }
                
                NSLog(@"19请求的url：%@",fullURL);
                
                
                ASIHTTPRequest * request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
                request1.tag = 2;
                request1.delegate = self;
                
                [request1 startAsynchronous];
            }else
            {
                nav.userInteractionEnabled = YES;
                [hud hide];
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"图片上传失败,请重新上传" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                [alert show];
            }
            
        }else if (request.tag == 2)
        {
            nav.userInteractionEnabled = YES;
            [hud hide];
            NSDictionary * jieguo = [request.responseData objectFromJSONData];
            
            NSLog(@"request.tag1111 = 2 ==%@",[jieguo objectForKey:@"data"]);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshmydata" object:myTextView.text];
            
            [self dismissViewControllerAnimated:YES completion:NULL];
        }else if (request.tag == 3)
        {
            nav.userInteractionEnabled = YES;
            [hud hide];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshmydata" object:myTextView.text];
            
            [self dismissViewControllerAnimated:YES completion:NULL];
            NSLog(@"request.tag22222 = 2 ==%@",[request responseString]);
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    
    NSLog(@"error = %@",request.error);
    
    [self saveWeiBo];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络不稳定,已保存到草稿箱" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    alertView.delegate = self;
    [alertView show];
}


-(void)saveWeiBo
{
    
    
    
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
    NSLog(@"morelocationString=%@",morelocationString);
    
    
    if (theText.length != 0)
    {
        [DraftDatabase deleteStudentBythecontent:theText];
    }
    
    
    NSMutableArray * arry = [DraftDatabase findallbytheContent:myTextView.text];
    
    if (arry.count!=0)
    {
        [DraftDatabase deleteStudentBythecontent:myTextView.text];
    }
    NSLog(@"allimageUrl ---  %@",allImageUrl);
    int faweibo=  [DraftDatabase addtype:@"发微博" content:myTextView.text date:morelocationString username:[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] fabiaogid:tid huifubbsid:rid weiboid:@"" thehuifubbsfid:@"" thetitle:@"" columns:@"微博" image:allImageUrl];
    
    
    
    
    NSLog(@"faweibo====%d",faweibo);
    
    
    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    nav.userInteractionEnabled = YES;
    [hud hide];
}


#pragma mark-显示框
-(void)hidefromview
{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
    NSLog(@"?????");
}
-(void)hidealert
{
    _replaceAlertView.hidden=YES;
    
}




- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(hasLocated)
    {
        return;
    }else
    {
        [manager stopUpdatingLocation];
        hasLocated = YES;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
         {
             lattitude = newLocation.coordinate.latitude;
             longitude =  newLocation.coordinate.longitude;
             if (array.count > 0)
             {
                 CLPlacemark *placemark = [array objectAtIndex:0];
                 NSString * country = placemark.administrativeArea;
                 NSString * city = placemark.subLocality;
                 
                 
                 //                 NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",placemark.name,placemark.thoroughfare,placemark.subThoroughfare,placemark.locality,placemark.subLocality,placemark.administrativeArea,placemark.subAdministrativeArea,placemark.postalCode,placemark.ISOcountryCode,placemark.country,placemark.inlandWater,placemark.ocean);
                 
                 
                 if (myTextView.tag == 100)
                 {
                     myTextView.text = @"";
                     myTextView.textColor = [UIColor blackColor];
                     myTextView.tag = 101;
                 }
                 
                 map_name = [NSString stringWithFormat:@"%@-%@",country,city];
                 weizhi_label.text = [NSString stringWithFormat:@"%@-%@",country,city];
                 weizhi_button.hidden = NO;
                 dingwei.hidden = YES;
                 myTextView.text = [myTextView.text stringByAppendingFormat:@"我在这里:#%@#",weizhi_label.text];
             }
             
         }];
    }
}


-(void)doTap:(UIButton *)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除文字" otherButtonTitles:nil, nil];
    actionSheet.tag = 100000-1;
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100000-1)
    {
        if (buttonIndex == 0)
        {
            if (myTextView.tag == 100 && [myTextView.text isEqualToString:@"分享新鲜事......"])
            {
                return;
            }
            
            myTextView.text = @"";
            //            wordsNumber_label.text = @"140";
            [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
            
        }
    }else if(actionSheet.tag == 1000002)
    {
        if (buttonIndex == 0)
        {
            [self saveWeiBo];
            
            [self dismissViewControllerAnimated:YES completion:NULL];
            
        }else if(buttonIndex ==1)
        {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }else if (actionSheet.tag == 1000001)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                [self takePhoto];
            }
                break;
            case 1:
            {
                [self addPicture:nil];
            }
                break;
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
}



-(void)takePhoto
{
    
    if (allImageArray.count >=9)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"最多上传9张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        
        return;
    }
    
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController * pickerC = [[UIImagePickerController alloc] init];
        pickerC.delegate = self;
        pickerC.allowsEditing = NO;
        pickerC.sourceType = sourceType;
        [self presentViewController:pickerC animated:YES completion:nil];
    }
    else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

-(void)localPhoto
{
    
    if (allImageArray.count >=9)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"最多上传9张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        
        return;
    }
    
    
    
    morePicView.hidden = NO;
    options_view.frame =  CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-72-215,320,73);
    myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44-215:480-20-73-44-215)-(MY_MACRO_NAME?0:20));
    [myTextView resignFirstResponder];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UIButton * button = (UIButton *)[self.view viewWithTag:1004];
    isFace = NO;
    [button setImage:[personal getImageWithName:isFace?@"write_blog_key@2x":@"smile_write@2x"] forState:UIControlStateNormal];
    
    return YES;
}

///////////////UITextViewDelegate////////////////////
//内容框字数限制
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.tag == 100)
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 101;
    }
    
    return YES;
}
//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.tag == 100 && [textView.text isEqualToString:@"分享新鲜事......"])
    {
        textView.tag = 101;
        textView.text = @"";
    }
    
    
    if (textView.text.length == 0)
    {
        textView.selectedRange =  NSMakeRange(0, 0);
        textView.text = @"分享新鲜事......";
        textView.textColor = RGBCOLOR(154,162,166);
        textView.tag = 100;
    }
    
    NSString  * nsTextContent=textView.text;
    int   existTextNum=[nsTextContent length];
    remainTextNum=140-existTextNum;
    //    wordsNumber_label.text = [NSString stringWithFormat:@"%i",remainTextNum];
    [wordsNumber_button setTitle:[NSString stringWithFormat:@"%i",remainTextNum] forState:UIControlStateNormal];
    
    if ([textView.text isEqualToString:@"分享新鲜事......"])
    {
        [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
        textView.selectedRange =  NSMakeRange(0, 0);
    }
    
}

-(void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"分享新鲜事......"]&&textView.selectedRange.location != 0&&textView.tag == 100)
    {
        [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
        textView.selectedRange =  NSMakeRange(0, 0);
    }
}


-(void)atSomeBodys:(NSString *)string
{
    
    if (isFace)
    {
        //弹出表情
        pageControl.hidden = NO;
        
        scrollView.hidden = NO;
        
        morePicView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            options_view.frame =  CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-72-160,320,73);
            myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44-160:480-20-73-44-160)-(MY_MACRO_NAME?0:20));
            [myTextView resignFirstResponder];
        }];
    }else
    {
        //弹出键盘
        [myTextView becomeFirstResponder];
    }
    
    
    if (string.length == 0 || [string isEqualToString:@""])
    {
        return;
    }
    
    
    if (myTextView.tag == 100)
    {
        myTextView.text = @"";
        myTextView.textColor = [UIColor blackColor];
        myTextView.tag = 101;
    }
    myTextView.text = [myTextView.text stringByAppendingFormat:@" @%@",string];
}




- (void)image:(UIImage *)image didFinishSavingWithError:
(NSError *)error contextInfo:(void *)contextInfo;
{
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:image1.CGImage orientation:(ALAssetOrientation)image1.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error )
     {
         //here is your URL : assetURL
         
         NSString * string = [assetURL absoluteString];
         
         
         if (allImageUrl.length != 0)
         {
             allImageUrl = [NSString stringWithFormat:@"%@||%@",allImageUrl,string];
         }else
         {
             allImageUrl = string;
         }
         
         [allAssesters addObject:assetURL];
         
     }];
    
    
    
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // UIImageWriteToSavedPhotosAlbum(image, self,@selector(image: didFinishSavingWithError:contextInfo:), nil);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    int all = allImageArray.count;
    
    
    UIButton * imageV = (UIButton *)[morePicImageView viewWithTag:101+all];
    [imageV setImage:image forState:UIControlStateNormal];
    imageV.imageView.clipsToBounds = YES;
    imageV.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [allImageArray addObject:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    morePicView.hidden = NO;
    options_view.frame =  CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-72-215,320,73);
    myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44-215:480-20-73-44-215)-(MY_MACRO_NAME?0:20));
    [myTextView resignFirstResponder];
    
    
}



#pragma mark - QBImagePickerControllerDelegate


-(void)takeAphoto
{
    [self takePhoto];
}


-(void)returnAllImageUrl
{
    allImageUrl = @"";
    for (int i = 0;i < allAssesters.count;i++)
    {
        NSString * string = [allAssesters objectAtIndex:i];
        
        if (i == 0)
        {
            allImageUrl = [NSString stringWithFormat:@"%@",string];
        }else
        {
            allImageUrl = [NSString stringWithFormat:@"%@||%@",allImageUrl,string];
        }
    }
}


- (void)imagePickerController1:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    
    NSArray *mediaInfoArray = (NSArray *)info;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    int all = allImageArray.count;
    
    for (int i = 0;i < mediaInfoArray.count;i++)
    {
        UIButton * imageV = (UIButton *)[morePicImageView viewWithTag:i+101+all];
        
        [imageV setImage:[[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
        [allImageArray addObject:[[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerOriginalImage"]];
        
        [allAssesters addObject:[[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerReferenceURL"]];
    }
    
    
    [self performSelector:@selector(returnAllImageUrl)];
    
    
    morePicView.hidden = NO;
    options_view.frame =  CGRectMake(0,(iPhone5?568:480)-(MY_MACRO_NAME?0:20)-72-215,320,73);
    myTextView.frame = CGRectMake(myTextView.frame.origin.x,myTextView.frame.origin.y,myTextView.frame.size.width,(iPhone5?568-20-73-44-215:480-20-73-44-215)-(MY_MACRO_NAME?0:20));
    [myTextView resignFirstResponder];
    
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [myTextView resignFirstResponder];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";//@"すべての写真を選択";
}

- (NSString *)descriptionForDeselectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";//@"すべての写真の選択を解除";
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return @"";//[NSString stringWithFormat:@"写真%d枚", numberOfPhotos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
{
    return @"";//[NSString stringWithFormat:@"ビデオ%d本", numberOfVideos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
{
    return @"";//[NSString stringWithFormat:@"写真%d枚、ビデオ%d本", numberOfPhotos, numberOfVideos];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
