//
//  WeiBoFaceScrollView.m
//  越野e族
//
//  Created by soulnear on 13-12-27.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "WeiBoFaceScrollView.h"
#import "NewFaceView.h"

@implementation WeiBoFaceScrollView

- (id)initWithFrame:(CGRect)rect target:(id)target
{
    self = [super initWithFrame:rect];
    if (self)
    {
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        // Initialization code here.
        self.backgroundColor=[UIColor colorWithRed:237/255.f green:237/255.f  blue:237/255.f  alpha:1];
        //        self.backgroundColor = [UIColor colorWithPatternImage:[personal getImageWithName:@""]];
        self.pagingEnabled=YES;
        self.bounces = YES;
        self.contentSize=CGSizeMake(320*3, 0);
        for (int i = 0;i < 3;i++)
        {
            NewFaceView *faceView = [[NewFaceView alloc] initWithFrame:CGRectMake(0+320*i,0,320,215)];
            
            faceView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"WriteBlog_face_image.png"]];
            
            faceView.deletage = target;
            
            faceView.tag = 100 + i;
            
            [faceView createExpressionWithPage:0];
            
            //faceView.backgroundColor=[UIColor colorWithRed:227 green:229 blue:232 alpha:1];
            [self addSubview:faceView];
            
        }
    }
    
    return self;
}

@end
