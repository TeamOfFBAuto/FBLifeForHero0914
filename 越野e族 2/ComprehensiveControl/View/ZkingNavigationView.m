//
//  ZkingNavigationView.m
//  RESideMenuExample
//
//  Created by 史忠坤 on 14-3-18.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "ZkingNavigationView.h"

#import "UIImageView+LBBlurredImage.h"


@implementation ZkingNavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    UIImage *background = [UIImage imageNamed:@"white.png"];

 UIImageView *   _blurredImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    _blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    _blurredImageView.alpha = 0.25;
    [_blurredImageView setImageToBlur:background blurRadius:8 completionBlock:nil];

      //  [self addSubview:_blurredImageView];
      //1
        
        UIColor *color_black=[[UIColor grayColor]colorWithAlphaComponent:0.75];
        self.backgroundColor=color_black;
        
        //2
        UIButton *button_left=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 64, 44)];
        button_left.backgroundColor=[UIColor clearColor];
        [button_left addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView* imgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fenlei36_33.png"]];
        imgv.center=CGPointMake(imgv.image.size.width/2, 22);
        [button_left addSubview:imgv];
        button_left.tag=100;
        self.leftbutton=button_left;
        
        [self addSubview:self.leftbutton];
        
        //3
        UIButton *button_right=[[UIButton alloc]initWithFrame:CGRectMake(320-64, 20+2, 64, 44)];
        button_right.backgroundColor=[UIColor clearColor];
        [button_right addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView* imgvr=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"our37_34.png"]];

        imgvr.center=CGPointMake(64-imgvr.image.size.width, 22);
        [button_right addSubview:imgvr];
        button_right.tag=101;
        self.rightbutton=button_right;
        
        [self addSubview:self.rightbutton];
        
        
        //4
        UIImageView *labelcenter=[[UIImageView alloc]initWithFrame:CGRectMake(140, 20+(44-19)/2, 51, 19)];
        self.centerlabel=labelcenter;
        [self addSubview:self.centerlabel];
        
    }
    return self;
}



-(void)dobutton:(UIButton *)sender{
    
    [self.delegate NavigationbuttonWithtag:(int)sender.tag];
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
