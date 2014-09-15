//
//  ZkingAlert.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ZkingAlert.h"

@implementation ZkingAlert

- (id)initWithFrame:(CGRect)frame labelString:(NSString *)_string
{
    self = [super initWithImage:[UIImage imageNamed:@"zkingalert.png"]];
    //    self=[super init];
    self.image=[UIImage imageNamed:@"zkingalert.png"];
    self.backgroundColor=[UIColor clearColor];
    if (self) {
        self.hidden=YES;
        self.center=CGPointMake(160, iPhone5?568/2:480/2);
        self.textLabel=[[UILabel alloc]initWithFrame:CGRectMake(2, 58, 150, 50)];
        self.textLabel.backgroundColor=[UIColor clearColor];
        self.textLabel.textAlignment=NSTextAlignmentCenter;
        self.textLabel.numberOfLines=0;
        self.textLabel.text=_string;
        self.textLabel.font=[UIFont systemFontOfSize:16];
        self.textLabel.textColor=[UIColor whiteColor];
        [self addSubview:self.textLabel];
    }
    return self;
}


-(void)zkingalertShowWithString:(NSString *)thestr{


    self.hidden=NO;
    self.textLabel.text=thestr;
    [self ZkingAlerthide];
    

}

-(void)ZkingAlerthide{
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:1.2];

}

-(void)hide{

    self.hidden=YES;
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
