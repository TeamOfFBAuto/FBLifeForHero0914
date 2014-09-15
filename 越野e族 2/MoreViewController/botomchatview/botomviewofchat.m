//
//  botomviewofchat.m
//  FbLife
//
//  Created by 史忠坤 on 13-8-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "botomviewofchat.h"

@implementation botomviewofchat
@synthesize delegate,atextv=_atextv;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=RGBCOLOR(30, 30, 30);
        
        NSArray *array_buttonimagename=[NSArray arrayWithObjects:@"",@"",@"",@"", nil];
        // Initialization code
        for (int i=0; i<4; i++) {
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(20+74*i, 60, 55, 55)];
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_buttonimagename objectAtIndex:i]]] forState:UIControlStateNormal];
            button.backgroundColor=[UIColor greenColor];
            [self addSubview:button];
            [button addTarget:self action:@selector(presbutton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:i+100];
         //   [self addSubview:button];
            //输入框
            
        }
        _atextv=[[UITextView alloc]initWithFrame:CGRectMake(5, 5, 205, 30)];
        _atextv.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
        _atextv.backgroundColor=[UIColor whiteColor];
        [self addSubview:_atextv];
        
        UIButton *buttonadd=[[UIButton alloc]initWithFrame:CGRectMake(430/2, 5, 35, 30)];
        [buttonadd addTarget:self action:@selector(presbutton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonadd setTag:104];
        buttonadd.backgroundColor=[UIColor orangeColor];
        [buttonadd setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     //   [self addSubview:buttonadd ];
        
        UIButton *buttonsend=[[UIButton alloc]initWithFrame:CGRectMake(514/2-20, 5, 55, 30)];
        [buttonsend addTarget:self action:@selector(presbutton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsend setTag:105];
        buttonsend.backgroundColor=[UIColor orangeColor];
        [buttonsend setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:buttonsend ];

        
         

    }
    return self;
}

-(void)presbutton:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
        {
            NSLog(@"发表情");
        }
            break;
        case 101:
        {
            NSLog(@"取照片");

        }
            break;
        case 102:
        {
            NSLog(@"拍照");

        }
            break;
            
        case 103:
        {
            NSLog(@"位置");

        }
            break;
            
        case 104:
        {
            NSLog(@"加号");

        }
            break;
            
        case 105:
        {
            NSLog(@"发送");

            [self.delegate sendwithtext:_atextv.text];
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
