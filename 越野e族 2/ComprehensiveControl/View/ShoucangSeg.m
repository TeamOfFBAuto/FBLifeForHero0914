//
//  WeiBoCustomSegmentView.m
//  FbLife
//
//  Created by soulnear on 13-12-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "ShoucangSeg.h"

@implementation ShoucangSeg
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,frame.size.height,self.frame.size.width/4-23,1)];
        
        lineImageView.backgroundColor = RGBCOLOR(88,88,88);
        
        lineImageView.image = [UIImage imageNamed:@"ios7_huandongtiao.png"];
        
        [self addSubview:lineImageView];
    }
    return self;
}



-(void)setAllViewsWith:(NSArray *)array index:(int)index
{
    if (array.count==2) {
        lineImageView.frame=CGRectMake(0,self.frame.size.height,self.frame.size.width/array.count-47,1);

    }
    
    for (int i = 0;i < array.count;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i == 0)
        {
            button.frame = CGRectMake(0,0,self.frame.size.width/array.count,self.frame.size.height-2);
        }else if (i == 1)
        {
            button.frame = CGRectMake((self.frame.size.width/array.count)+3,0,self.frame.size.width/array.count,self.frame.size.height-2);
        }else if (i == 2)
        {
            button.frame = CGRectMake((self.frame.size.width/array.count)*2+3,0,self.frame.size.width/array.count,self.frame.size.height-2);
        }else if (i==3){
        
         button.frame = CGRectMake((self.frame.size.width/array.count)*3+3,0,self.frame.size.width/array.count,self.frame.size.height-2);
        
        }
        
        
        if (index == i)
        {
            lineImageView.center = CGPointMake(button.center.x,self.frame.size.height-1);
        }
        
         button.tag = 100 + i;
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        
        [button setTitleColor:RGBCOLOR(51,51,51) forState:UIControlStateNormal];
        
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [button addTarget:self action:@selector(chooseButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
}


-(void)chooseButton:(UIButton *)sender
{
    if (sender.tag-100 != 1)
    {
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        
        if (!isLogIn)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(sWeiBoViewLogIn)])
            {
                [self.delegate sWeiBoViewLogIn];
            }
            return;
        }
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sClickWeiBoCustomSegmentWithIndex:)])
    {
        [self.delegate sClickWeiBoCustomSegmentWithIndex:sender.tag-100];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        lineImageView.center = CGPointMake(sender.center.x,self.frame.size.height-1);
    } completion:^(BOOL finished) {
        
    }];
}


-(void)MyButtonStateWithIndex:(int)index
{
    UIButton * sender = (UIButton *)[self viewWithTag:index+100];
    
    [UIView animateWithDuration:0.3 animations:^{
        lineImageView.center = CGPointMake(sender.center.x,self.frame.size.height-1);
    } completion:^(BOOL finished) {
        
    }];
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
