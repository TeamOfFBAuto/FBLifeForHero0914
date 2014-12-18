//
//  SliderBBSForumSegmentView.m
//  越野e族
//
//  Created by soulnear on 14-7-4.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SliderBBSForumSegmentView.h"

#define SELECTED_COLOR RGBCOLOR(65,65,65)

#define UN_SELECTED_COLOR RGBCOLOR(130,130,130)


@implementation SliderBBSForumSegmentView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGBCOLOR(238,238,238);
    }
    return self;
}



-(void)setAllViewsWithTextArray:(NSArray *)textArray WithImageArray:(NSArray *)imageArray WithBlock:(SliderBBSForumSegmentViewBlock)theBlock
{
    forumViewBlock = theBlock;
    
    image_array = [NSMutableArray arrayWithArray:imageArray];
    for (int i = 0;i < 4;i++)
    {
        UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(((DEVICE_WIDTH-6)/4 + 2)*i,0,(DEVICE_WIDTH-6)/4,56)];
        aView.backgroundColor = [UIColor whiteColor];
        [self addSubview:aView];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(((DEVICE_WIDTH-6)/4 + 2)*i,0,(DEVICE_WIDTH-6)/4,61);
        button.center = CGPointMake(aView.width/2,button.center.y);
        button.tag = i + 100;
        button.titleLabel.font = [UIFont systemFontOfSize:12.5];
        [button setBackgroundColor:[UIColor clearColor]];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.imageView.clipsToBounds = YES;
        [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:4+i]] forState:UIControlStateSelected];
        history_page = 0;
        
        if (i == 0)
        {
            [button setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
            button.selected = YES;
        }else
        {
            [button setTitleColor:UN_SELECTED_COLOR forState:UIControlStateNormal];
            
        }
        
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [aView addSubview:button];
    }
}


#pragma mark- 选择论坛版块

-(void)buttonTap:(UIButton *)sender
{
    if (sender.tag-100 == history_page)
    {
        return;
    }
    UIButton * history_button = (UIButton *)[self viewWithTag:history_page+100];
    
    history_button.selected = NO;
    
    [history_button setTitleColor:UN_SELECTED_COLOR forState:UIControlStateNormal];
    
    sender.selected = YES;
    [sender setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
    
    forumViewBlock(sender.tag-100);
    
    history_page = sender.tag-100;
}



@end

















