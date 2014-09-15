//
//  FBMapViewController.m
//  越野e族
//
//  Created by soulnear on 13-12-18.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "FBMapViewController.h"
#import <AddressBook/AddressBook.h>

@interface FBMapViewController ()

@end

@implementation FBMapViewController
@synthesize myMapView = _myMapView;
@synthesize info = _info;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ToMapView:(UIButton *)button
{//跳转到地图
    
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"使用百度地图",@"使用手机地图",nil];
    [actionSheet showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex -----  %d",buttonIndex);
    switch (buttonIndex) {
        case 2:
        {//取消
            
        }
            break;
        case 0:
        {//百度
            NSString * string = [NSString stringWithFormat:@"baidumap://map/marker?location=%f,%f&title=%@&content=%@",[_info.service_lat doubleValue],[_info.service_lng doubleValue],[self.info.service_shopname stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[self.info.service_address stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding]];
            
            UIApplication *app = [UIApplication sharedApplication];
            
            if ([app canOpenURL:[NSURL URLWithString:string]])
            {
                [app openURL:[NSURL URLWithString:string]];
            }
            
        }
            break;
        case 1:
        {//手机
            if (IOS_VERSION>=6.0)
            {
                
                NSDictionary *dicOfAddress = [NSDictionary dictionaryWithObjectsAndKeys:self.info.service_shopname,(NSString *)kABPersonAddressStreetKey,nil];
                
                
                
                CLLocationCoordinate2D coords =
                CLLocationCoordinate2DMake([_info.service_lat doubleValue],[_info.service_lng doubleValue]);
                
                
                MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:coords addressDictionary:dicOfAddress];
                
                MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
                
                [mapItem openInMapsWithLaunchOptions:nil];
                
            }else
            {
                NSString *string = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f",userLatitude,userlongitude];
                
                [[UIApplication sharedApplication]  openURL:[NSURL URLWithString:string]];
            }
            
            
        }
            break;
            
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"FBMapViewController"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"FBMapViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spaceBar.width = MY_MACRO_NAME?0:5;
//
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(5,8,12,21.5)];
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    
//    self.navigationItem.leftBarButtonItems=@[spaceBar,back_item];
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        if (IOS_VERSION>=7.0)
//        {
//            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS7DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//        }else
//        {
//            //iOS 5 new UINavigationBar custom background
//            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//        }
//    }
    
    
    self.title = @"地图";
    
//    UIColor * cc = [UIColor blackColor];
    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    
    UIButton * button_dingwei = [[UIButton alloc]initWithFrame:CGRectMake(270,8,29/2,44/2)];
    [button_dingwei addTarget:self action:@selector(ToMapView:) forControlEvents:UIControlEventTouchUpInside];
    [button_dingwei setBackgroundImage:[personal getImageWithName:@"where_write@2x"] forState:UIControlStateNormal];
    [button_dingwei.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.navigationItem.rightBarButtonItems = @[spaceBar,[[UIBarButtonItem alloc] initWithCustomView:button_dingwei]];
    
    
    _myMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    _myMapView.mapType=MKMapTypeStandard;
    
    _myMapView.delegate=self;
    
    _myMapView.showsUserLocation=NO;
    
    [self.view addSubview:_myMapView];
    
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
    region.span=span;
    region.center=CLLocationCoordinate2DMake([self.info.service_lat doubleValue],[self.info.service_lng doubleValue]);//[userLocation coordinate];
    
    [_myMapView setRegion:region animated:YES];
    
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = region.center;
    [ann setTitle:self.info.service_shopname];
    [ann setSubtitle:self.info.service_address];
    //触发viewForAnnotation
    [_myMapView addAnnotation:ann];
	
}


#pragma mark-MapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLatitude=userLocation.coordinate.latitude;
    userlongitude=userLocation.coordinate.longitude;
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.010;
    span.longitudeDelta=0.010;
    region.span=span;
    region.center=[userLocation coordinate];
    
    [_myMapView setRegion:[_myMapView regionThatFits:region] animated:YES];
}



















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
