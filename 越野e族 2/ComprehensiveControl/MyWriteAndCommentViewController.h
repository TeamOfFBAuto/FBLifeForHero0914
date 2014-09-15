//
//  MyWriteAndCommentViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-15.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ShoucangSeg.h"

#import "FinalshoucangView.h"

@interface MyWriteAndCommentViewController : MyViewController<FinalshoucangViewDelegate,ShoucangSegDelegate,UIScrollViewDelegate>{
    
    
    UIScrollView *newsScrow;
    
}
@property(nonatomic,strong)ShoucangSeg * weibo_seg;//顶头切换按钮

@end
