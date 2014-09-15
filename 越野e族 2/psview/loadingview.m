//
//  loadingview.m
//  FblifeAll
//
//  Created by szk on 13-1-24.
//  Copyright (c) 2013年 fblife. All rights reserved.
//

#import "loadingview.h"

@implementation loadingview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        activityIndicator = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:
                             UIActivityIndicatorViewStyleGray];
        //    activityIndicator.frame = CGRectMake(0, 0, 30, 30);
      //  activityIndicator.center =CGRectMake(self.frame.size.width-30, self.frame.size.height/2, 30, 30);
        activityIndicator.center =CGPointMake(self.frame.size.width/2-40, self.frame.size.height/2);
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
        
        UILabel *label_zairu=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-24, self.frame.size.height/2-10, 60, 20)];
        label_zairu.text=@"载入中";
        label_zairu.textAlignment=NSTextAlignmentLeft;
        label_zairu.textColor=[UIColor colorWithRed:116/255.f green:120/255.f blue:133/255.f alpha:1];
        [self addSubview:label_zairu];
        
        UILabel *label_diandian=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+30, (self.frame.size.height/2)-10, 40, 20)];
        label_diandian.text=@"······";
        label_diandian.textAlignment=NSTextAlignmentLeft;
        label_diandian.textColor=[UIColor colorWithRed:116/255.f green:120/255.f blue:133/255.f alpha:1];
        [self addSubview:label_diandian];
        
        [activityIndicator release];
        [label_diandian release];
        [label_zairu release];
        
       // 145/190/217
        
    }
    return self;
}
-(void)hide{
    self.hidden=YES;
}
-(void)show{
    self.hidden=NO;
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
