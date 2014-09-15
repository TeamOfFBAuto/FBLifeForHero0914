//
//  loadingimview.m
//  FbLife
//
//  Created by 史忠坤 on 13-7-26.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "loadingimview.h"

@implementation loadingimview

- (id)initWithFrame:(CGRect)frame labelString:(NSString *)_string
{
   // self = [super initWithImage:[UIImage imageNamed:@"tishijizai308_223.png"]];
    self=[super initWithFrame:CGRectMake(0, 0, 308/2, 223/2)];
    self.image=nil;
    UIColor *color_gray=[[UIColor blackColor] colorWithAlphaComponent:0.6];

    self.backgroundColor=color_gray;
    self.layer.cornerRadius=4;
    
    if (self) {
        
        UILabel *label_zhengzaijiazai=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 308/2, 20)];
        label_zhengzaijiazai.textColor=[UIColor whiteColor];
        label_zhengzaijiazai.textAlignment=UITextAlignmentCenter;
        label_zhengzaijiazai.font=[UIFont systemFontOfSize:16];
        label_zhengzaijiazai.backgroundColor=[UIColor clearColor];
        label_zhengzaijiazai.text=@"数据加载中";
        [self addSubview:label_zhengzaijiazai];
        
        self.center=CGPointMake(160, iPhone5?568/2:480/2);
    UIActivityIndicatorView *    activityIndicator = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:
                             UIActivityIndicatorViewStyleWhiteLarge];
        //    activityIndicator.frame = CGRectMake(0, 0, 30, 30);
        activityIndicator.center =CGPointMake(154/2, 110/2+17);
        activityIndicator.hidden =NO;
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
    }
    return self;
}


-(void)hide{
    
    [self removeFromSuperview];
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
