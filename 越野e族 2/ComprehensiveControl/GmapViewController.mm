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
    BMKOfflineMap* _offlineMap;//离线地图
    BMKMapView *_mapView;//地图
    BMKLocationService *_locService;//定位服务
    
    UIActivityIndicatorView *_juhua;
    BOOL _isOverLay;
}
@end

@implementation GmapViewController


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    //    _offlineMap.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _offlineMap.delegate = nil; // 不用时,置 nil
}



- (void)dealloc
{
    if (_mapView) {
        _mapView = nil;
    }
    
    if (_offlineMap != nil) {
        
        _offlineMap = nil; }
    
    
    
    NSLog(@"%s",__FUNCTION__);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    self.title = @"英雄会";
    
    _juhua =  [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _juhua.center = CGPointMake(160.0f, 100.0f);//只能设置中心，不能设置大小
    _juhua.color = [UIColor grayColor]; // 改变圈圈的颜色为红色；
    
    [self.view addSubview:_juhua];
    [_juhua startAnimating];
    
    
    //写到沙盒
    [self gcopyToDoc];
    
    
    
    //    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"在没网情况下打开wifi可以提高定位精准度,即使没有wifi环境" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [al show];
    
    
}


#pragma mark - 写到documents


-(void)gcopyToDoc{
    //把工程里的vmp文件夹 复制到沙盒里
    //不能整个vmp文件夹拷贝到documents 那就一个一个拷贝
    [self creatFileFolderWithFileName:@"vmp"];
    [self creatFileFolderWithFileName:@"vmp/h"];
    [self creatFileFolderWithFileName:@"vmp/h/traffic"];
    [self writeDocumentsWithFileName:@"vmp/h/beijing_131.dat" originPathName:@"beijing_131" originType:@"dat"];
    [self writeDocumentsWithFileName:@"vmp/h/DVUserdat.cfg" originPathName:@"DVUserdat" originType:@"cfg"];
    
    
    //初始化离线地图服务
    _offlineMap = [[BMKOfflineMap alloc]init];
    _offlineMap.delegate = self;
    
    //地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    [_mapView setZoomLevel:18];// 设置地图级别
    _mapView.isSelectedAnnotationViewFront = YES;
    _mapView.delegate = self;//设置代理
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [self.view addSubview:_mapView];
    
    
    //定位
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    _isOverLay = NO;
    
    
    
}



//拷贝文件
///fileName:沙盒里文件的名字.类型    originPathName:工程里文件的名字       originType:工程里文件的类型
-(void)writeDocumentsWithFileName:(NSString *)fileName originPathName:(NSString *)originPathName originType:(NSString *)originType {
    //沙盒中sql文件的路径
	NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *FilePath = [docPath stringByAppendingPathComponent:fileName];
	//原始sql文件路径
	NSString *originFilePath = [[NSBundle mainBundle] pathForResource:originPathName ofType:originType];
	
	NSFileManager *fm = [NSFileManager defaultManager];//文件管理器
	if([fm fileExistsAtPath:FilePath] == NO)//如果文件不在doc下，copy过来
	{
		NSError *error = nil;
		if([fm copyItemAtPath:originFilePath toPath:FilePath error:&error] == NO)
		{
			NSLog(@"拷贝文件错误");
		}else{
            NSLog(@"拷贝文件成功");
        }
	}else{
        NSLog(@"文件已存在");
    }
	
	
}

//创建文件夹
///需要添加的文件夹名字
-(void)creatFileFolderWithFileName:(NSString *)fileName{
    //沙盒中sql文件的路径
	NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *FilePath = [docPath stringByAppendingPathComponent:fileName];//沙盒路径
    
    NSFileManager *fm = [NSFileManager defaultManager];//文件管理器
    
    if([fm fileExistsAtPath:FilePath] == NO)//没有文件 添加
	{
		NSError *error = nil;
        
        if ([fm createDirectoryAtPath:FilePath withIntermediateDirectories:YES attributes:nil error:&error] == NO) {
            NSLog(@"拷贝文件夹错误");
        }else{
            NSLog(@"拷贝文件夹成功");
        }
	}else{
        NSLog(@"文件夹已存在");
    }
	
	
    
}


#pragma mark - 离线地图

//添加对离线地图的监听方法
//离线地图delegate，用于获取通知
- (void)onGetOfflineMapState:(int)type withState:(int)state
{
    
    if (type == TYPE_OFFLINE_UPDATE) {
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
    }
    if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }
    if (type == TYPE_OFFLINE_UNZIP) {
        //正在解压第state个离线包，导入时会回调此类型
    }
    if (type == TYPE_OFFLINE_ZIPCNT) {
        //检测到state个离线包，开始导入时会回调此类型
        NSLog(@"检测到%d个离线包",state);
        if(state==0)
        {
            [self showImportMesg:state];
        }
    }
    if (type == TYPE_OFFLINE_ERRZIP) {
        //有state个错误包，导入完成后会回调此类型
        NSLog(@"有%d个离线包导入错误",state);
    }
    if (type == TYPE_OFFLINE_UNZIPFINISH) {
        NSLog(@"成功导入%d个离线包",state);
        //导入成功state个离线包，导入成功后会回调此类型
        [self showImportMesg:state];
    }
    
}

/**
 *启动下载指定城市 id 的离线地图 *@param cityID 指定的城市 id
 *@return 成功返回 YES,否则返回 NO
 */
- (BOOL)start:(int)cityID{
    
    return [_offlineMap start:cityID];
}

//导入提示框
- (void)showImportMesg:(int)count
{
    NSString* showmeg = [NSString stringWithFormat:@"成功导入离线地图包个数:%d", count];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"导入离线地图" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
    
}





#pragma mark - 地图view代理方法 BMKMapViewDelegate
//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
		return groundView;
    }
	return nil;
}

//地图mapview即将出现
-(void)viewWillAppear{
    [_juhua stopAnimating];
    [_juhua setHidesWhenStopped:YES];
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
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}


//用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
    [_mapView updateLocationData:userLocation];
    
    
    //判断是否有经纬度
    if (userLocation.location) {//有经纬度的话 停止定位 上传自己坐标
        
        //        [_locService stopUserLocationService];//关掉定位
        
        if (!_isOverLay) {
            _isOverLay = YES;
            _mapView.centerCoordinate = userLocation.location.coordinate;
            
            //提供两个经纬度 添加图片覆盖物
            CLLocationCoordinate2D coords1[2] = {0};
            coords1[0].latitude = 39.982151;
            coords1[0].longitude = 116.375128;
            coords1[1].latitude = 39.983209;
            coords1[1].longitude = 116.376844;
            BMKCoordinateBounds bound2;
            bound2.southWest = coords1[0];//西南角经纬度
            bound2.northEast = coords1[1];//东北角经纬度
            
            //地图浮层
            BMKGroundOverlay *ground2 = [BMKGroundOverlay groundOverlayWithBounds:bound2 icon:[UIImage imageNamed:@"test.png"]];
            [_mapView addOverlay:ground2];
            
        }
        
        
        
        
    }
    
}


//定位失败后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];
}





#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex == 0) {
        
    }
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
