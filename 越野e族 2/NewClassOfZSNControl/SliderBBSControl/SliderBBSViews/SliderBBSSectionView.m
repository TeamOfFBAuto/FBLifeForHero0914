//
//  SliderBBSSectionView.m
//  越野e族
//
//  Created by soulnear on 14-7-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SliderBBSSectionView.h"
#import "testbase.h"

#define selected_color RGBCOLOR(63,63,63)

#define unselected_color RGBCOLOR(137,137,137)


@implementation SliderBBSSectionView
@synthesize myScrollView = _myScrollView;




- (id)initWithFrame:(CGRect)frame WithBlock:(SliderBBSSectionSegmentBlock)theBlock WithLogInBlock:(SliderBBSSectionSegmentLogInBlock)theLogIn
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        sliderBBSSectionSegmentBlock = theBlock;
        
        logIn_block = theLogIn;
        
        for (int i = 0;i < 3;i++)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            
            button.tag = 100 + i;
            
            [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0)
            {
                button.frame = CGRectMake(0,0,111,44);
                
                [button setTitle:@"我的收藏" forState:UIControlStateNormal];
                
                [button setTitleColor:selected_color forState:UIControlStateNormal];
                
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                
                UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,1,15)];
                
                line_view.center = CGPointMake(223.0/2,22);
                
                line_view.backgroundColor = RGBCOLOR(184,184,184);
                
                [self addSubview:line_view];
            }else if(i == 1)
            {
                button.frame = CGRectMake(112,0,223.0/2,44);
                
                [button setTitle:@"最新浏览" forState:UIControlStateNormal];
                
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [button setTitleColor:unselected_color forState:UIControlStateNormal];
                
                UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,1,15)];
                
                line_view.center = CGPointMake(448.0/2,22);
                
                line_view.backgroundColor = RGBCOLOR(184,184,184);
                
                [self addSubview:line_view];
            }else
            {
                button.frame = CGRectMake(224.5,0,191.0/2,44);
                
                [button setTitle:@"排行榜" forState:UIControlStateNormal];
                
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [button setTitleColor:RGBCOLOR(235,79,83) forState:UIControlStateNormal];
            }
            
            
            [self addSubview:button];
        }
        
        
        
        background_imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0,37,320,58.5)];
        
        background_imageview.image = [UIImage imageNamed:@"bbs_forum_jingxuan_beijing"];
        
        background_imageview.userInteractionEnabled = YES;
        
        [self addSubview:background_imageview];
        
        
        
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,6,320,52)];
        
        _myScrollView.backgroundColor = [UIColor clearColor];
        
        _myScrollView.showsVerticalScrollIndicator = NO;
        
        [background_imageview addSubview:_myScrollView];
    }
    return self;
}


-(void)setAllViewsWithArray:(NSArray *)array WithType:(int)theType withBlock:(SliderBBSSectionViewBlock)theBlock
{
    sectionView_block = theBlock;
    
    if (_myScrollView)//如果有数据，把之前的数据干掉
    {
        for (UIView * view in _myScrollView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    
    UIButton * button1 = (UIButton *)[self viewWithTag:100];
    
    UIButton * button2 = (UIButton *)[self viewWithTag:101];
    
    if (theType == 0)
    {
        [button1 setTitleColor:selected_color forState:UIControlStateNormal];
        
        [button2 setTitleColor:unselected_color forState:UIControlStateNormal];
    }else
    {
        [button2 setTitleColor:selected_color forState:UIControlStateNormal];
        
        [button1 setTitleColor:unselected_color forState:UIControlStateNormal];
    }

    
    int count = array.count;
    
    
    if (count > 10 && theType == 1)
    {
        count = 10;
    }
    
    
    if (count == 0)
    {
        if (!no_data_name_label)
        {
            no_data_name_label = [[UILabel alloc] initWithFrame:_myScrollView.frame];
            
            no_data_name_label.textAlignment = NSTextAlignmentCenter;
            
            no_data_name_label.userInteractionEnabled = YES;
            
            no_data_name_label.font = [UIFont systemFontOfSize:15];
            
            no_data_name_label.textColor = RGBCOLOR(135,135,135);
            
            no_data_name_label.backgroundColor = [UIColor clearColor];
            
            [background_imageview addSubview:no_data_name_label];
        }
        
        no_data_name_label.hidden = NO;
        
        if (theType == 0)
        {
            BOOL islogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
            
            no_data_name_label.text = islogIn?@"你还没有收藏版块":@"点击立即登录";
            
        }else if(theType == 1)
        {
            no_data_name_label.text = @"你还没有浏览记录";
        }
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logInTap:)];
        
        [no_data_name_label addGestureRecognizer:tap];
        
        
        return;
    }else
    {
        no_data_name_label.hidden = YES;
    }
    
    
    
    
    _myScrollView.contentSize = CGSizeMake(20+90*count+(count-1)*10,0);
    
    NSString * string = @"";
    
    for (int i = 0;i < count;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(10 + 100*i,10,90,63.0/2);
        
        if (theType == 0)
        {
            string = [[array objectAtIndex:i] objectForKey:@"name"];
        }else if (theType == 1)
        {
            if (i > 9)
            {
                return;
            }
            
            testbase * base = [array objectAtIndex:(array.count-1)-i];
            
            string = base.name;
        }
        
        CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        
        button.tag = 1000+i;
        
        [button addTarget:self action:@selector(buttonSelectedTap:) forControlEvents:UIControlEventTouchUpInside];
        
        button.layer.masksToBounds = NO;
        
        button.backgroundColor = [UIColor whiteColor];
        
        button.layer.borderColor = RGBCOLOR(195,195,195).CGColor;
        
        button.layer.borderWidth = 0.5;
        
        [_myScrollView addSubview:button];
        
        
        UILabel * name_label = [[UILabel alloc] initWithFrame:CGRectMake(4,0,82,63.0/2)];
        
        name_label.text = string;
        
        name_label.numberOfLines = 0;
        
        name_label.textAlignment = NSTextAlignmentCenter;
        
        name_label.textColor = RGBCOLOR(40,40,40);
        
        name_label.backgroundColor = [UIColor clearColor];
        
        
        if (titleSize.width > 90)
        {
            name_label.font = [UIFont systemFontOfSize:10];
            
        }else
        {
            name_label.font = [UIFont systemFontOfSize:15];
        }
        
        [button addSubview:name_label];
    }
    
 /*
  
    int row = count/3 + (count%3?1:0);
    
    for (int i = 0;i < row;i++) {
        for (int j = 0;j < 3;j++) {
            
            if (i*3+j < array.count) {
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button.frame = CGRectMake(10 + 100*j,10,90,63.0/2);
                
                [button setTitle:[[array objectAtIndex:i*3+j] objectForKey:@"name"] forState:UIControlStateNormal];
                
                button.tag = 1000+i*3+j;
                
                [button addTarget:self action:@selector(buttonSelectedTap:) forControlEvents:UIControlEventTouchUpInside];
                
                [button setTitleColor:RGBCOLOR(105,105,105) forState:UIControlStateNormal];
                
                button.layer.masksToBounds = NO;
                
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                
                button.layer.borderColor = RGBCOLOR(194,194,194).CGColor;
                
                button.layer.borderWidth = 0.5;
                
                [background_imageview addSubview:button];
            }
        }
    }
  
  */
    
    [UIView animateWithDuration:0.3 animations:^{
        background_imageview.frame = CGRectMake(0,37,320,58.5);
    } completion:^(BOOL finished) {
        
    }];
}



//选择订阅 最新 排行榜

-(void)buttonTap:(UIButton *)sender
{
    if (sender.tag -100 == 0)
    {
        background_imageview.image = [UIImage imageNamed:@"bbs_forum_jingxuan_beijing"];
    }else if (sender.tag - 100 == 1)
    {
        background_imageview.image = [UIImage imageNamed:@"bbs_forum_jingxuan_beijing1"];
    }
    
    sliderBBSSectionSegmentBlock(sender.tag - 100);
}


#pragma mark - 点击我的订阅内容

-(void)buttonSelectedTap:(UIButton *)sender
{
    
    
    sectionView_block(sender.tag-1000);
}



#pragma mark - 点击登陆


-(void)logInTap:(UITapGestureRecognizer *)sender
{
    if ([no_data_name_label.text isEqualToString:@"点击立即登录"])
    {
        logIn_block();
    }
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
















