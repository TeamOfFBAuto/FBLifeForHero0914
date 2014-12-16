//
//  summarycellview.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "summarycellview.h"
#define RIGHTORIGNOFSUM 10
@implementation summarycellview
@synthesize suminfo;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setSuminfo:(NSDictionary *)__suminfo{
    
    UILabel *labeltitle=[[UILabel alloc]initWithFrame:CGRectMake(RIGHTORIGNOFSUM, 5, DEVICE_WIDTH, 20)];
    labeltitle.backgroundColor=[UIColor clearColor];
    labeltitle.textAlignment=NSTextAlignmentLeft;
    labeltitle.font=[UIFont systemFontOfSize:14];
    labeltitle.textColor=[UIColor blackColor];
    labeltitle.text=[NSString stringWithFormat:@"%@",[[__suminfo objectForKey:@"name"] objectAtIndex:0]];
    [self addSubview:labeltitle];
    
    UILabel *labelegine=[[UILabel alloc]initWithFrame:CGRectMake(RIGHTORIGNOFSUM, 27, DEVICE_WIDTH / 3.f - 30, 20)];
    labelegine.backgroundColor=[UIColor clearColor];
    labelegine.textAlignment=NSTextAlignmentLeft;
    labelegine.font=[UIFont systemFontOfSize:13];
    labelegine.textColor=[UIColor grayColor];
    NSString *string_engine=[NSString stringWithFormat:@"%@",[[__suminfo objectForKey:@"c_fdj"] objectAtIndex:0]];
    if (string_engine.length>5) {
        string_engine=[string_engine substringToIndex:5];
    }
    labelegine.text=[NSString stringWithFormat:@"%@",[[__suminfo objectForKey:@"c_fdj"] objectAtIndex:0]];
    [self addSubview:labelegine];
    
//    labelegine.backgroundColor = [UIColor redColor];
    
    UILabel *labelchange=[[UILabel alloc]initWithFrame:CGRectMake(60, 27, DEVICE_WIDTH / 3.f - 5, 20)];
    labelchange.backgroundColor=[UIColor clearColor];
    labelchange.textAlignment=NSTextAlignmentCenter;
    labelchange.font=[UIFont systemFontOfSize:13];
    labelchange.textColor=[UIColor grayColor];
    labelchange.text=[NSString stringWithFormat:@"%@",[[__suminfo objectForKey:@"c_bsx"] objectAtIndex:0]];
    [self addSubview:labelchange];
    labelchange.center = CGPointMake(DEVICE_WIDTH / 2.f - 5, labelchange.center.y);
//    labelchange.backgroundColor = [UIColor orangeColor];
    
    UILabel *labelprice=[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH - DEVICE_WIDTH / 3.f - 10, 27, DEVICE_WIDTH / 3.f, 20)];
//    labelprice.backgroundColor=[UIColor greenColor];
    labelprice.textAlignment=NSTextAlignmentRight;
    labelprice.font=[UIFont systemFontOfSize:13];
    labelprice.textColor=[UIColor grayColor];
    
    NSString *string_qujian=[NSString stringWithFormat:@"指导价：%@万",[personal getwanwithstring:[[__suminfo objectForKey:@"c_cszdj"] objectAtIndex:0]]];
    if (IOS_VERSION>=6) {
        
        if (string_qujian.length>5) {
            
            
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:string_qujian];
            [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(230, 0, 18) range:NSMakeRange(4, string_qujian.length-4)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 4)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(string_qujian.length-1, 1)];
            labelprice.attributedText=str;
            
        }

    }else{
        labelprice.text=string_qujian;
    }
    
    
    [self addSubview:labelprice];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, DEVICE_WIDTH, 1)];
    img.image=[UIImage imageNamed:@"line-2.png"];
    [self addSubview:img];

    
    
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
