//
//  WeiBoNormalView.h
//  FbLife
//
//  Created by soulnear on 13-12-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@protocol WeiBoNormalViewDelegate <NSObject>

-(void)NormalClickUrl:(NSString *)theUrl withIsRe:(BOOL)isreply;

-(void)NormalClickPictures:(int)index WithIsRe:(BOOL)isRe;

@end



#import <UIKit/UIKit.h>
#import "FbFeed.h"
#import "RTLabel.h"
#import "PictureViews.h"


@interface WeiBoNormalView : UIView<RTLabelDelegate,PictureViewsDelegate>
{
    BOOL isReplys;
}


@property(nonatomic,strong)RTLabel * weibo_content;
@property(nonatomic,strong)PictureViews * pictureViews;

@property(nonatomic,assign)id<WeiBoNormalViewDelegate>delegate;



-(float)setAllViewWithFBFeed:(FbFeed *)info isReply:(BOOL)isReply;

-(void)Reset;


@end
