//
//  FBQuanAlertView.m
//  FBCircle
//
//  Created by 史忠坤 on 14-6-7.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "FBQuanAlertView.h"

@implementation FBQuanAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame=CGRectMake(0, 0, 220, 120);
        self.center=CGPointMake(160, iPhone5?(-80+568)/2:480/2);
        
        self.backgroundColor=[RGBCOLOR(20, 20, 30)colorWithAlphaComponent:0.6];
        
        CALayer *l = [self layer];   //获取ImageView的层
        [l setMasksToBounds:YES];
        [l setCornerRadius:3.0f];
        
        _juhuazhuan=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_juhuazhuan startAnimating];
        _juhuazhuan.hidden=YES;
        _juhuazhuan.hidesWhenStopped = YES;
        _juhuazhuan.color = [UIColor whiteColor]; // 改变圈圈的颜色为黑色；iOS5引入
        [self addSubview:_juhuazhuan];
        
        _TextLabel=[[UILabel alloc]init];
        _TextLabel.textColor=[UIColor whiteColor];
        _TextLabel.font=[UIFont systemFontOfSize:17];
        _TextLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_TextLabel];
        
    }
    return self;
}

-(void)setType:(FBQuanAlertViewType)thetype thetext:(NSString *)alerttext{
    
    _TextLabel.text=[NSString stringWithFormat:@"%@",alerttext];
    
    switch (thetype) {
        case FBQuanAlertViewTypeHaveJuhua:
        {
            self.frame=CGRectMake(50, iPhone5?(-120+568/2):-120+480/2, 220, 120);

            _juhuazhuan.hidden=NO;
            
            _juhuazhuan.center = CGPointMake(self.frame.size.width/2, 50);//只能设置中心，不能设置大小
            
            _TextLabel.frame=CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 20);
            
            
        }
            break;
        case FBQuanAlertViewTypeNoJuhua:
        {
            self.frame=CGRectMake(50, iPhone5?(-120+568/2):-120+480/2, 220, 40);

            
            _juhuazhuan.hidden=YES;
            
            [_juhuazhuan stopAnimating];
            
            _TextLabel.frame=CGRectMake(0, 10, self.frame.size.width, 20);
            
            _TextLabel.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            
            
        }
            break;
            
        default:
            break;
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
