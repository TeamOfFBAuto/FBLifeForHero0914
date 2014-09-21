//
//  GScrollView.h
//  MapHearo
//
//  Created by gaomeng on 14-9-17.
//  Copyright (c) 2014年 FBLIFE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GShowImagesScrollViewDelegate <NSObject>
-(void)singleClicked;
@end




@interface GScrollView : UIScrollView<UIScrollViewDelegate>

{
    BOOL _isZoomed;
    
    NSTimer * _tapTimer;
    
    
    //经纬度
    
    //左上
    CLLocationCoordinate2D _ttLeftUp;
    
//    //左下
//    CLLocationCoordinate2D _ttLeftDown;
//    
//    //右上
//    CLLocationCoordinate2D _ttRightUp;
    
//    //x总长度
//    double _xlong;
//    
//    //y总长度
//    double _ylong;
    
    //用户位置
    UIImageView *_blueImv;
}



@property(nonatomic,strong)UIImageView * locationImageView;

@property(nonatomic,assign)id<GShowImagesScrollViewDelegate>aDelegate;

///双击时最大放大倍数
@property(nonatomic,assign)CGFloat towPointMaxZoom;









///初始化 frame为contentSize
-(GScrollView *)initWithFrame:(CGRect)frame WithLocation:(UIImage *)theImage;


///添加定位view
-(void)dingweiViewWithX:(double)theX Y:(double)theY;


@end
