//
//  AdvertisingimageView.h
//  FbLife
//
//  Created by 史忠坤 on 13-8-7.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@class AdvertisingimageView;
@protocol AdvertisingimageViewDelegate <NSObject>

-(void)TurntoFbWebview;
-(void)advimgdismiss;
-(void)showmyadvertising;

@end
@interface AdvertisingimageView : UIView<AsyncImageDelegate>{
  //  UIImageView *guanggao_image;

}

@property(nonatomic,strong)UIImage *adv_img;
@property(nonatomic,strong)NSString *string_urlimg;
@property(nonatomic,strong)     AsyncImageView *guanggao_image;

@property(assign,nonatomic)id<AdvertisingimageViewDelegate>delegate;
@end
