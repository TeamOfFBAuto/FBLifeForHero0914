//
//  AdvertisingimageView.m
//  FbLife
//
//  Created by 史忠坤 on 13-8-7.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "AdvertisingimageView.h"

@implementation AdvertisingimageView
@synthesize adv_img=_adv_img,string_urlimg=_string_urlimg,delegate,guanggao_image;
- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled=YES;
        
        //
         }
    return self;
}

-(void)layoutSubviews{
 
}
-(void)setString_urlimg:(NSString *)string_urlimg{
    
    self.guanggao_image.userInteractionEnabled=YES;
    self.guanggao_image=[[AsyncImageView alloc]initWithFrame:CGRectMake(0,0, 320,50)];
    self.guanggao_image.backgroundColor=[UIColor orangeColor];
    self.guanggao_image.delegate=self;
    UITapGestureRecognizer* singleRecognizer;
    [self.guanggao_image loadImageFromURL:string_urlimg withPlaceholdImage:[UIImage imageNamed:@"640_100@2x.jpg"]];
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    
    [self.guanggao_image addGestureRecognizer:singleRecognizer];
    [self addSubview:guanggao_image];
    
    UIButton *button_turn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 280, 50)];
    [button_turn addTarget:self action:@selector(handleSingleTapFrom) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_turn];

    UIButton *button_dismiss=[[UIButton alloc]initWithFrame:CGRectMake(292, 15, 39/2, 39/2)];
    [button_dismiss setBackgroundImage:[UIImage imageNamed:@"x39_39.png"] forState:UIControlStateNormal];
    [button_dismiss addTarget:self action:@selector(dismissadimgv) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_dismiss];
    
    UIButton *bigdismissbutton=[[UIButton alloc]initWithFrame:CGRectMake(270, 0, 50, 50)];
    bigdismissbutton.backgroundColor=[UIColor clearColor];
    [bigdismissbutton addTarget:self action:@selector(dismissadimgv) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bigdismissbutton];
    

}
-(void)dismissadimgv{
    [self.delegate advimgdismiss];
}
-(void)handleSingleTapFrom
{
    
    NSLog(@"点击之后发生跳转");

    [self.delegate TurntoFbWebview];
    
}
-(void)handleImageLayout:(AsyncImageView *)tag{
    NSLog(@"下载下来了广告图片，在这个view里面");
    [self.delegate showmyadvertising];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
