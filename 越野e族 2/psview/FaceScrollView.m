//
//  FaceScrollView.m
//  FaceDemo
//
//  Created by user on 11-10-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FaceScrollView.h"
#import "FaceView.h"

@implementation FaceScrollView

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
        self.contentSize=CGSizeMake(320*3, 0);
        for (int i = 0;i < 3;i++)
        {
            FaceView *faceView = [[FaceView alloc] initWithFrame:CGRectMake(0+320*i,0,320,160)];
            
            faceView.backgroundColor = [UIColor colorWithPatternImage:[personal getImageWithName:@"20130502_line@2x"]];
            
            faceView.deletage = target;
            
            faceView.tag = 100 + i;
            
            [faceView createExpressionWithPage:0];
            
            //faceView.backgroundColor=[UIColor colorWithRed:227 green:229 blue:232 alpha:1];
            [self addSubview:faceView];
            
            [faceView release];
        }
        
    }
    
    return self;
}



@end