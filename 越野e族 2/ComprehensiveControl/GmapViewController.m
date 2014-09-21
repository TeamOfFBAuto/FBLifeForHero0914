//
//  GmapViewController.m
//  越野e族
//
//  Created by gaomeng on 14-9-15.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "GmapViewController.h"


@interface GmapViewController ()
{
    BMKLocationService *_locService;//定位服务
}
@end

@implementation GmapViewController


-(void)viewWillDisappear:(BOOL)animated {
    
    NSLog(@"%s",__FUNCTION__);
    
    _locService.delegate = nil;
    
}


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    self.title = @"英雄会";
    
    
    //GScrollView
    self.gscrollView = [[GScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64) WithLocation:iPhone5?[UIImage imageNamed:@"big5s.jpg"]:[UIImage imageNamed:@"big4s.jpg"]];
    [self.view addSubview:self.gscrollView];
    
    //定位
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    
}




#pragma mark - 定位代理方法

//在地图View将要启动定位时，会调用此函数
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}


//用户方向更新后，会调用此函数
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}


//用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@" 定位数据(x,y)    long = %f   lat = %f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    
    
    //主席台测试数据
    //[self.gscrollView dingweiViewWithX:105.382810 Y:38.807060];
    
    //实际定位坐标  x:long   y:lat
    [self.gscrollView dingweiViewWithX:userLocation.location.coordinate.longitude Y:userLocation.location.coordinate.latitude];
    
    
}


//定位失败后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
