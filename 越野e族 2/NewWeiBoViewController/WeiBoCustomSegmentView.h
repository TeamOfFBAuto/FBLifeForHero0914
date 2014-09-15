//
//  WeiBoCustomSegmentView.h
//  FbLife
//
//  Created by soulnear on 13-12-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//



@protocol WeiBoCustomSegmentViewDelegate <NSObject>


@optional;

-(void)ClickWeiBoCustomSegmentWithIndex:(int)index;

-(void)WeiBoViewLogIn;

@end


#import <UIKit/UIKit.h>

@interface WeiBoCustomSegmentView : UIView
{
    UIImageView * lineImageView;
    
    int history_index;
}


@property(nonatomic,assign)id<WeiBoCustomSegmentViewDelegate>delegate;


-(void)setAllViewsWith:(NSArray *)array index:(int)index;


-(void)MyButtonStateWithIndex:(int)index;


@end
