//
//  AppDelegate.h
//  越野e族
//
//  Created by soulnear on 13-12-16.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "LogInViewController.h"
#import "AsyncImageView.h"
#import "LeveyTabBarController.h"
#import "PRTween.h"
#import "UMSocialData.h"
#import "WXApi.h"
#import "RootViewController.h"
#import "BBSViewController.h"
#import "NewWeiBoViewController.h"
#import "NewMineViewController.h"
#import "MessageViewController.h"
#import "WeiboSDK.h"
#import "CarPortViewController.h"
#import "PersonalmoreViewController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
//新改版额
#import "RESideMenu.h"
#import "LeftViewController.h"
#import "ComprehensiveViewController.h"
#import "FansViewController.h"
#import "MMDrawerController.h"
#import <CoreData/CoreData.h>

//新改版的share界面

#import "ShareView.h"

//百度地图
#import "BMapKit.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,LogInViewControllerDelegate,downloaddelegate,LeveyTabBarControllerDelegate,LeveyTabBarDelegate,AsyncImageDelegate,MobClickDelegate,WXApiDelegate,RESideMenuDelegate>
{
    UIBackgroundTaskIdentifier backgroundTask_;
    
    
//    UIBackgroundTaskIdentifier szkTast;
    int bgCount;

    
    UITabBarController * tabbar;
    LogInViewController * logIn;
    AsyncImageView *guanggao_image;
    LeveyTabBarController *_leveyTabBarController;
    NSTimer *  timer;
    int index;
    
    PRTweenOperation *activeTweenOperation;
    UIImageView *iMagelogo;
    UIImageView *bigimageview;
    UIViewController *current_controller;
    NSDictionary *dic_push;
    int  NewsMessageNumber;
    downloadtool *allnotificationtool;
    
    int flagofpage;
    CTCallCenter *center;
    UIImageView *img_TEST;
    
    
    //百度地图
    BMKMapManager* _mapManager;
    
    ///是否接收到本地通知
    BOOL isHaveLocalNotification;
    
    ///夜间模式
    UIView * night_view;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)RootViewController * rootVC;
@property(nonatomic,strong)BBSViewController * bbsVC;
@property(nonatomic,strong)NewWeiBoViewController * weiboVC;
@property(nonatomic,strong)CarPortViewController * mineVC;
@property(nonatomic,strong)PersonalmoreViewController * moreVC;
@property(nonatomic,strong)CTCallCenter *_center;

@property(nonatomic,strong)UINavigationController *navigationController;

@property(nonatomic,strong)UINavigationController * root_nav;

@property(nonatomic,strong)MMDrawerController *RootVC;

@property(nonatomic,strong)FansViewController * pushViewController;//控制跳转的透明view

//coredata相关

@property(strong,nonatomic,readonly)NSManagedObjectModel* managedObjectModel;

@property(strong,nonatomic,readonly)NSManagedObjectContext* managedObjectContext;

@property(strong,nonatomic,readonly)NSPersistentStoreCoordinator* persistentStoreCoordinator;

@property(strong,nonatomic)ShareView *globalShareView;

@property(strong,nonatomic)UIView *halfBlackView;


@end







