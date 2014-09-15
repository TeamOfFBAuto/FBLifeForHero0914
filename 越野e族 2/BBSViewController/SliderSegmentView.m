//
//  SliderSegmentView.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-3.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#define SHANGGAO (44-57/2)/2

#import "SliderSegmentView.h"

@implementation SliderSegmentView{
    NSArray *array_img;
}
@synthesize currentpage,type,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.currentpage=0;
    self.type=@"bk";
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

-(void)loadContent:(NSArray *)array_
{
    // Initialization code
    //    NSArray *array_=[NSArray arrayWithObjects:@"搜索论坛", @"搜索帖子",nil];
    array_img=[NSArray arrayWithObjects:@"searchbbs297_57.png",@"selectbbsright297_57.png",@"selectsearchbbsleft295_55.png",@"selectsearchright295_55.png", nil];
    for (int i=0; i<2; i++)
    {
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doslider:)];
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12+i*297/2, SHANGGAO, 297/2, 57/2-1)];
//        label.text=[NSString stringWithFormat:@"%@",[array_ objectAtIndex:i]];
//        label.textAlignment=UITextAlignmentCenter;
//        [self addSubview:label];
//        label.tag=i+1000;
//        [label addGestureRecognizer:tap];
//        label.userInteractionEnabled=YES;
//        label.backgroundColor=[UIColor whiteColor];
//        label.font=[UIFont systemFontOfSize:14.f];
//        if (i==0) {
//            [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]]]];
//        }else{
//             [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:1]]]]];
//            
//        }
        UIButton *button__=[[UIButton alloc]initWithFrame:CGRectMake(12+i*297/2, SHANGGAO, 297/2, 57/2)];
        
        if (i==0) {
            [button__ setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]]]];
            [button__ setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]] forState:UIControlStateNormal];
        }else{
                    [button__ setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:1]]] forState:UIControlStateNormal];
            
        }
        button__.tag=i+1000;

        [button__ setTitle:[NSString stringWithFormat:@"%@",[array_ objectAtIndex:i]] forState:UIControlStateNormal];
        [button__ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button__.titleLabel.font=[UIFont systemFontOfSize:14];
        [button__ addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button__];
        
        
    }

}

-(void)NewloadContent:(NSArray *)array_
{
    // Initialization code
    //    NSArray *array_=[NSArray arrayWithObjects:@"搜索论坛", @"搜索帖子",nil];
    array_img=[NSArray arrayWithObjects:@"searchbbs150_57.png",@"selectbbsright150_57.png",@"selectsearchbbsleft150_55.png",@"selectsearchright150_55.png", nil];
    for (int i=0; i<2; i++)
    {
        //        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doslider:)];
        //        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12+i*297/2, SHANGGAO, 297/2, 57/2-1)];
        //        label.text=[NSString stringWithFormat:@"%@",[array_ objectAtIndex:i]];
        //        label.textAlignment=UITextAlignmentCenter;
        //        [self addSubview:label];
        //        label.tag=i+1000;
        //        [label addGestureRecognizer:tap];
        //        label.userInteractionEnabled=YES;
        //        label.backgroundColor=[UIColor whiteColor];
        //        label.font=[UIFont systemFontOfSize:14.f];
        //        if (i==0) {
        //            [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]]]];
        //        }else{
        //             [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:1]]]]];
        //
        //        }
        UIButton *button__=[[UIButton alloc]initWithFrame:CGRectMake(12+i*150/2, SHANGGAO, 150/2, 57/2)];
        
        if (i==0) {
            [button__ setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]]]];
            [button__ setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]] forState:UIControlStateNormal];
        }else{
            [button__ setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:1]]] forState:UIControlStateNormal];
            
        }
        button__.tag=i+1000;
        
        [button__ setTitle:[NSString stringWithFormat:@"%@",[array_ objectAtIndex:i]] forState:UIControlStateNormal];
        [button__ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button__.titleLabel.font=[UIFont systemFontOfSize:14];
        [button__ addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button__];
        
        
    }
    
}

-(void)dobutton:(UIButton *)sender{
    if (sender.tag==1000)
    {
        self.currentpage=0;
        
        
  [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]] forState:UIControlStateNormal];
     
        UIButton *otherbutton=(UIButton *)[self viewWithTag:1001];
 [otherbutton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:1]]] forState:UIControlStateNormal];
        
        
        
        self.type=@"bk";
        
    }else
    {
        self.currentpage=1;
        self.type=@"tiezi";
        
        
        UIButton *otherbutton=(UIButton *)[self viewWithTag:1000];
        [otherbutton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:0]]] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:3]]] forState:UIControlStateNormal];
        
        
    }
    [self.delegate searchreaultbythetype:self.type];
}


-(void)doslider:(UITapGestureRecognizer *)sender
{
    if (sender.view.tag==1000)
    {
        self.currentpage=0;
        
 
                [[self viewWithTag:1001]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:1]]]]];
        [[self viewWithTag:1000]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:2]]]]];
        
        
        self.type=@"bk";
    }else
    {
        self.currentpage=1;
        self.type=@"tiezi";

        

        [[self viewWithTag:1001]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:3]]]]];
        [[self viewWithTag:1000]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array_img objectAtIndex:0]]]]];
        
    }
    [self.delegate searchreaultbythetype:self.type];
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
