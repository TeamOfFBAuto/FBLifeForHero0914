//
//  WeiBoSpecialView.h
//  FbLife
//
//  Created by soulnear on 13-12-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@protocol WeiBoSpecialViewDelegate <NSObject>

@optional

-(void)SpecialClickUrl:(NSString *)theUrl WithIsRe:(BOOL)isreply;

-(void)SpecialClickPictures:(int)index WithIsRe:(BOOL)isRe;

-(void)SpecialPlayVideoWithReply:(BOOL)isRe;

-(void)SpecialClickOriginalContent;

@end

#import <UIKit/UIKit.h>
#import "FbFeed.h"
#import "PictureViews.h"
#import "RTLabel.h"

@interface WeiBoSpecialView : UIView<RTLabelDelegate,PictureViewsDelegate>
{
    BOOL isReplyssss;
}

@property(nonatomic,strong)RTLabel * content_label;

@property(nonatomic,strong)RTLabel * title_label;

@property(nonatomic,assign)id<WeiBoSpecialViewDelegate>delegate;

@property(nonatomic,strong)PictureViews * pictureViews;

@property(nonatomic,strong)UIButton * video_button;

@property(nonatomic,strong)UIButton * original_pinglun_button;

@property(nonatomic,strong)UIButton * original_zhuanfa_button;

@property(nonatomic,strong)UIView * original_line_view;


@property(nonatomic,assign)float content_font;
@property(nonatomic,assign)int line_space;



-(float)setAllViewWithFeed:(FbFeed *)info isReply:(BOOL)isReply;


-(void)Reset;


@end
