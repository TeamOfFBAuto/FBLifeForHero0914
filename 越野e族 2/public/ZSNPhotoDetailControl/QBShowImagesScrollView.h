//
//  QBShowImagesScrollView.h
//  FBCircle
//
//  Created by soulnear on 14-5-13.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AsyncImageView.h"

@protocol QBShowImagesScrollViewDelegate <NSObject>

-(void)singleClicked;

-(void)reloadAtlasData;//重新加载数据

@end


typedef enum
{
    QBShowImagesScrollViewTypeLocation=0,
    QBShowImagesScrollViewTypeWeb
    
}QBShowImagesScrollViewType;


@interface QBShowImagesScrollView : UIScrollView<AsyncImageDelegate,UIScrollViewDelegate>
{
    BOOL _isZoomed;
    
    NSTimer * _tapTimer;
    
    UIButton * placeHolderButton;
    
    UIView * loading_view;//菊花背景
    
    UIActivityIndicatorView * activity_view;//菊花
    
    BOOL is_load;//判断图片是否加载完成
    
    UILabel * load_again;//重新加载
    
    
    UIView * load_failed_view;//加载失败弹框
}


@property(nonatomic,strong)AsyncImageView * asyImageView;

@property(nonatomic,strong)AsyncImageView * locationImageView;

@property(nonatomic,assign)QBShowImagesScrollViewType ImageType;

@property(nonatomic,assign)id<QBShowImagesScrollViewDelegate>aDelegate;


-(QBShowImagesScrollView *)initWithFrame:(CGRect)frame WithLocation:(UIImage *)theImage;


-(QBShowImagesScrollView *)initWithFrame:(CGRect)frame WithUrl:(NSString *)theUrl;

-(void)resetImageView:(UIImage *)theImage;


//加载数据失败
-(void)loadDataFailed;


@end







