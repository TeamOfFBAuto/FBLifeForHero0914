//
//  RankingListSegmentView.m
//  越野e族
//
//  Created by soulnear on 14-7-9.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "RankingListSegmentView.h"

@implementation RankingListSegmentView

- (id)initWithFrame:(CGRect)frame WithBlock:(RankingListSegmentViewBlock)theBlock
{
    self = [super initWithFrame:frame];
    if (self)
    {
        rankingListBlock = theBlock;
        
        NSArray * image_array = [NSArray arrayWithObjects:@"bbs_rankinglist_zhuti1",@"bbs_rankinglist_chexing1",@"bbs_rankinglist_dadui1",@"bbs_rankinglist_zhuti",@"bbs_rankinglist_chexing",@"bbs_rankinglist_dadui",nil];
        
        for (int i = 0;i < 3;i++)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(12 + 100*i,12,96,45);
                        
            [button setImage:[UIImage imageNamed:[image_array objectAtIndex:i]] forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:[image_array objectAtIndex:i+3]] forState:UIControlStateSelected];
            
            historyPage = 0;
            
            if (i == 0)
            {
                button.selected = YES;
                
                [button setImageEdgeInsets:UIEdgeInsetsZero];
            }else
            {
                button.selected = NO;
                
                [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,5,0)];
            }
            
            button.tag = 100+i;
            
            [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
        }
    }
    return self;
}


-(void)buttonTap:(UIButton *)sender
{
    rankingListBlock(sender.tag - 100);
    
    if (sender.tag -100 == historyPage) {
        
    }else
    {
        UIButton * button = (UIButton *)[self viewWithTag:historyPage+100];
        
        button.selected = NO;
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,5,0)];
        
        sender.selected = YES;
        
        [sender setImageEdgeInsets:UIEdgeInsetsZero];
    }
    
    historyPage = sender.tag -100;
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
