//
//  ShoucangViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-10.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableHeaderView.h"

#import "ShoucangSeg.h"

#import "FinalshoucangView.h"




@interface ShoucangViewController : MyViewController<FinalshoucangViewDelegate,ShoucangSegDelegate,UIScrollViewDelegate>{


    UIScrollView *newsScrow;

}
@property(nonatomic,strong)ShoucangSeg * weibo_seg;//顶头切换按钮

@end
