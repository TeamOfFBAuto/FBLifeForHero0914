//
//  DetailBottomView.m
//  FbLife
//
//  Created by soulnear on 13-12-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "DetailBottomView.h"

@implementation DetailBottomView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,0.5)];
        
        line_view.backgroundColor = RGBCOLOR(145,148,153);
        
        [self addSubview:line_view];
        
        
        NSArray * array1 = [NSArray arrayWithObjects:@"刷新",@"转发",@"评论",nil];
        
        NSArray * array2 = [NSArray arrayWithObjects:@"weibo_detail_shuaxin.png",@"weibo_detail_zhuanfa.png",@"weibo_detail_pinglun.png",nil];
        
        for (int i = 0;i < 3;i++)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.tag = 1000 + i;
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            
            button.frame = CGRectMake(5+((DEVICE_WIDTH-240-10)/2 + 80)*i,0,80,44);
            
            [button setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:[array2 objectAtIndex:i]] forState:UIControlStateNormal];
            
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,1,10)];
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,5,0,0)];
            
            [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            
        }
    }
    return self;
}


-(void)doButton:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(buttonClickWithIndex:)])
    {
        [_delegate buttonClickWithIndex:sender.tag-1000];
    }
}


@end
