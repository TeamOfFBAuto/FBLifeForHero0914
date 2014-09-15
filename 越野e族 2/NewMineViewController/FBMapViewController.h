//
//  FBMapViewController.h
//  越野e族
//
//  Created by soulnear on 13-12-18.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PersonInfo.h"

@interface FBMapViewController : MyViewController<MKMapViewDelegate,UIActionSheetDelegate>
{
   double userLatitude;
   double userlongitude;
}


@property(nonatomic,strong)MKMapView * myMapView;

@property(nonatomic,strong)PersonInfo * info;


@end
