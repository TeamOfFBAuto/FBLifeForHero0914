//
//  GmapViewController.h
//  越野e族
//
//  Created by gaomeng on 14-9-15.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface GmapViewController : MyViewController<BMKOfflineMapDelegate,NSFileManagerDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,UIAlertViewDelegate>

@end
