//
//  newsimage_scro.h
//  FbLife
//
//  Created by 史忠坤 on 13-2-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface newsimage_scro : UIScrollView<UIScrollViewDelegate>{
    UIPageControl *page;
    NSTimer *  timer;
}
@property (nonatomic,strong)AsyncImageView *imagev_;
@property (nonatomic,strong)NSArray *image_array;
@property(nonatomic,assign)    int iscount;

-(void)startanimation;

@end
