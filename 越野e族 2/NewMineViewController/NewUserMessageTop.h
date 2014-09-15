//
//  NewUserMessageTop.h
//  FbLife
//
//  Created by soulnear on 13-12-11.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@protocol NewUserMessageTopDelegate <NSObject>

-(void)clickButtonWithIndex:(int)index;

-(void)attentionClick;

-(void)sendMessageClick;

@end



#import <UIKit/UIKit.h>
#import "PersonInfo.h"

@interface NewUserMessageTop : UIView<AsyncImageDelegate>
{
    BOOL attention_flg;
}

@property(nonatomic,strong)PersonInfo * info;

@property(nonatomic,strong)AsyncImageView * background_imageview;

@property(nonatomic,strong)AsyncImageView * header_imageview;

@property(nonatomic,strong)UILabel * username_label;

@property(nonatomic,strong)UIButton * sendMessage_button;

@property(nonatomic,strong)UIButton * attention_button;

@property(nonatomic,strong)UIScrollView * tap_background_view;


@property(nonatomic,strong)NSMutableArray * data_array;

@property(nonatomic,assign)id<NewUserMessageTopDelegate>delegate;



-(void)setAllViewWithPerson:(PersonInfo *)info type:(int)type;


@end

























