//
//  DraftBoxView.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import "DraftBoxView.h"
@implementation DraftBoxView
@synthesize string_content,string_date,delegate,string_type;
- (id)initWithFrame:(CGRect)frame contentstring:(NSString *)_contentstring datestring:(NSString *)_datestring type:(NSString *)_type tag:(NSInteger)_buttontag
{
    self = [super initWithFrame:frame];
    if (self) {

        
        rowofl=(int)_buttontag;
        UIButton *button_=[[UIButton alloc]initWithFrame:CGRectMake(5, self.frame.size.height/2-47/2+14, 46/2, 47/2)];
//        [button_ addTarget:self action:@selector(handleSingleTapFrom:mytype:) forControlEvents:UIControlEventTouchUpInside];
        button_.userInteractionEnabled = NO;
        [self addSubview:button_];
        [button_ setBackgroundImage:[UIImage imageNamed:@"ref46_47.png"] forState:UIControlStateNormal];
        
        self.string_type=[NSString stringWithFormat:@"%@",_type];
        
        UILabel *label_content=[[UILabel alloc]init];
        label_content.backgroundColor=[UIColor clearColor];
        label_content.text=_contentstring;
        label_content.textAlignment=UITextAlignmentLeft;
        label_content.font=[UIFont systemFontOfSize:16];
        label_content.numberOfLines=0;
        UIFont *cellFont = [UIFont systemFontOfSize:16];
        CGSize constraintSize = CGSizeMake(275, MAXFLOAT);
        CGSize labelSize = [label_content.text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILayoutPriorityRequired];
        label_content.frame=CGRectMake(36, 5, 275, labelSize.height);
        [self addSubview:label_content];
        UILabel *label_date;
        if (_contentstring.length==0||[_contentstring isEqualToString:@"(null)"]) {
                    label_date=[[UILabel alloc]initWithFrame:CGRectMake(36.5, 20+7, 275, 18)];
        }else{
            label_date=[[UILabel alloc]initWithFrame:CGRectMake(36.5, labelSize.height+7, 275, 18)];
        }

        label_date.backgroundColor=[UIColor clearColor];
        label_date.text=_datestring;
        label_date.textAlignment=UITextAlignmentLeft;
        label_date.font=[UIFont systemFontOfSize:14];
        label_date.textColor=[UIColor lightGrayColor];
        [self addSubview:label_date];
        
        button_dele=[[UIButton alloc]initWithFrame:CGRectMake(265, 5, 55, 34)];
        button_dele.backgroundColor=[UIColor orangeColor];
        [button_dele setTitle:@"删除" forState:UIControlStateNormal];
        [button_dele setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button_dele.titleLabel.font=[UIFont systemFontOfSize:17];
        [button_dele addTarget:self action:@selector(deleorsend:) forControlEvents:UIControlEventTouchUpInside];
        button_dele.tag=_buttontag;
        [self addSubview:button_dele];
        button_dele.hidden=YES;
}
    return self;
}
-(void)deleorsend:(UIButton *)sender
{
    [self.delegate dele:sender type:self.string_type];
}
-(void)handleSwipeFrom
{
    button_dele.hidden=NO;
}
-(void)show{
    button_dele.hidden=YES;
}
-(void)handleSingleTapFrom:(NSInteger)row mytype:(NSString *)_type{
    [self.delegate resendrow:rowofl type:self.string_type];
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
