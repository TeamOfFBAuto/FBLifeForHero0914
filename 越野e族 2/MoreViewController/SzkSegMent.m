//
//  SzkSegMent.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-18.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SzkSegMent.h"

@implementation SzkSegMent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor blackColor];
        LeftButton=[[UIButton alloc]initWithFrame:CGRectMake(1, 1, self.frame.size.width/2-3, self.frame.size.height/2-2)];
        [self addSubview:LeftButton];
        
        RigthButton=[[UIButton alloc]initWithFrame:CGRectMake(1, self.frame.size.width/2+1, self.frame.size.width/2-3, self.frame.size.height/2-2)];
        [self addSubview:LeftButton];
        
    }
    return self;
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
