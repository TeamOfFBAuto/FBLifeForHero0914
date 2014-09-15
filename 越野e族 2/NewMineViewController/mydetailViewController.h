//
//  mydetailViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-2-28.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "PersonInfo.h"
#import "RTLabel.h"
#import <MapKit/MapKit.h>
#import "FBMapViewController.h"



@interface mydetailViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
    UITableView *detail_tab;
    
    NSMutableArray *array_all;//所有的cell的label的名字
    NSMutableArray *array_receive;
    
    UILabel *label_content;
    UILabel *label_receive;
    
    
    MKMapView * myMapView;
    
    double userLatitude;
    double userlongitude;
    
}


@property(nonatomic,assign)BOOL isShangJia;

@property(nonatomic,strong)PersonInfo * info;


@end
