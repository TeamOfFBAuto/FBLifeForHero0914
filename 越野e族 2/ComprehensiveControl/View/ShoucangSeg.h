//
//  WeiBoCustomSegmentView.h
//  FbLife
//
//  Created by soulnear on 13-12-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//



@protocol ShoucangSegDelegate <NSObject>


@optional;

-(void)sClickWeiBoCustomSegmentWithIndex:(int)index;

-(void)sWeiBoViewLogIn;

@end


#import <UIKit/UIKit.h>

@interface ShoucangSeg : UIView
{
    UIImageView * lineImageView;
}


@property(nonatomic,assign)id<ShoucangSegDelegate>delegate;


-(void)setAllViewsWith:(NSArray *)array index:(int)index;


-(void)MyButtonStateWithIndex:(int)index;


@end
