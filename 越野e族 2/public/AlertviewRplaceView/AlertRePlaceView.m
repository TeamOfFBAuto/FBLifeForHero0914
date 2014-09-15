//
//  AlertRePlaceView.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-20.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "AlertRePlaceView.h"

@implementation AlertRePlaceView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame labelString:(NSString *)_string
{
    self = [super initWithImage:[UIImage imageNamed:@"308_223.png"]];
//    self=[super init];
    self.image=[UIImage imageNamed:@"308_223.png"];
    self.backgroundColor=[UIColor clearColor];
    if (self) {
        self.center=CGPointMake(160, iPhone5?568/2:480/2);
        UILabel *label_text=[[UILabel alloc]initWithFrame:CGRectMake(2, 58, 150, 50)];
        label_text.backgroundColor=[UIColor clearColor];
        label_text.textAlignment=UITextAlignmentCenter;
        label_text.numberOfLines=0;
        label_text.text=_string;
        label_text.font=[UIFont systemFontOfSize:14];
        label_text.textColor=[UIColor whiteColor];
        [self addSubview:label_text];
    }
    return self;
}


-(void)hide{

    [self.delegate hidefromview];
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
