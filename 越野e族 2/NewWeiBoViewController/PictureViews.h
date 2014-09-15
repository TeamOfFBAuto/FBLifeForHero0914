//
//  PictureViews.h
//  FbLife
//
//  Created by soulnear on 13-6-17.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@protocol PictureViewsDelegate <NSObject>

-(void)clickPicture:(int)index WithIsReply:(BOOL)isRe;

@end


#import <UIKit/UIKit.h>

@interface PictureViews : UIView<AsyncImageDelegate>
{
    
}

@property(nonatomic,assign)BOOL isReply;
@property(nonatomic,assign)id<PictureViewsDelegate>delegate;

-(void)setImageUrls:(NSString *)theUrl withSize:(int)size isjuzhong:(BOOL)juzhong;

-(void)setDelegate:(id<PictureViewsDelegate>)delegate1;

@end
