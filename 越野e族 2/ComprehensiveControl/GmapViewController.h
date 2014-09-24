//
//  GmapViewController.h
//  越野e族
//
//  Created by gaomeng on 14-9-15.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "GScrollView.h"
@interface GmapViewController : MyViewController<BMKLocationServiceDelegate>

@property(nonatomic,strong)GScrollView *gscrollView;

@property(nonatomic,strong)UILabel *tishilabel;//在不在区域内的提示label

@end
