//
//  bottombarview.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "bottombarview.h"

@implementation bottombarview
@synthesize button_ahead=_button_ahead,button_comment=_button_comment,button_behind=_button_behind,button_refresh=_button_refresh,button_show=_button_show,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor=RGBCOLOR(244, 244, 246);
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        [self addSubview:lineView];
        lineView.backgroundColor=RGBCOLOR(188, 188, 188);
        
        [self.button_show.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.button_show.titleLabel setFont:[UIFont systemFontOfSize:10]];
        
        
        _button_refresh=[[UIButton alloc]initWithFrame:CGRectMake(12, (41-52/2)/2, 38/2, 52/2)];
        [_button_refresh setBackgroundImage:[UIImage imageNamed:@"louzhu38_52.png"] forState:UIControlStateNormal];
        [_button_refresh addTarget:self action:@selector(refreshdata:) forControlEvents:UIControlEventTouchUpInside];
        _button_refresh.tag=201;
        [self addSubview:_button_refresh];
        
        
        
        
        _button_ahead=[[UIButton alloc]initWithFrame:CGRectMake(70, 12, 20, 16)];
        [_button_ahead setBackgroundImage:[UIImage imageNamed:@"ios7_goback4032.png"] forState:UIControlStateNormal];
        [_button_ahead addTarget:self action:@selector(refreshdata:) forControlEvents:UIControlEventTouchUpInside];
        _button_ahead.tag=202;
        [self addSubview:_button_ahead];
        
        
        _button_show=[[UIButton alloc]initWithFrame:CGRectMake(110, 1, 100, 38)];
       // [_button_show setBackgroundImage:[UIImage imageNamed:@"bbs_mid@2x.png"] forState:UIControlStateNormal];
        [_button_show addTarget:self action:@selector(refreshdata:) forControlEvents:UIControlEventTouchUpInside];
        _button_show.tag=203;
        [_button_show setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_button_show];
        
        _button_behind=[[UIButton alloc]initWithFrame:CGRectMake(220, 12, 20, 16)];
        [_button_behind setBackgroundImage:[UIImage imageNamed:@"ios7_goahead4032.png"] forState:UIControlStateNormal];
        [_button_behind addTarget:self action:@selector(refreshdata:) forControlEvents:UIControlEventTouchUpInside];
        _button_behind.tag=204;
        [self addSubview:_button_behind];
        
        _button_comment=[[UIButton alloc]initWithFrame:CGRectMake(294-5-1, (40-39/2)/2, 38/2, 39/2)];
        [_button_comment addTarget:self action:@selector(refreshdata:) forControlEvents:UIControlEventTouchUpInside];
        _button_comment.tag=205;
        [self addSubview:_button_comment];
        // Initialization code
        
        for (int i=0; i<5; i++) {
            UIButton *button__=(UIButton *)[self viewWithTag:i+201];
            UIButton *buttoncoppy=[[UIButton alloc]initWithFrame:CGRectMake(button__.frame.origin.x, 0, 50, 40)];
            [buttoncoppy addTarget:self action:@selector(refreshdata:) forControlEvents:UIControlEventTouchUpInside];
            buttoncoppy.backgroundColor=[UIColor clearColor];
            buttoncoppy.tag=i+201;
            [self addSubview:buttoncoppy];
        }
        
        
    }
    return self;
}
-(void)refreshdata:(UIButton*)sender{
    
    [self.delegate clickbutton:sender];
    
}
-(void)setcommentimage1:(NSString *)commentnumber{
    
    if (![commentnumber isEqualToString:@"0"]) {
        _button_comment.frame=CGRectMake(285-5-1, (40-51/2)/2, 61/2, 51/2);
        [_button_comment setBackgroundImage:[UIImage imageNamed:@"cimment61_51@2x.png"] forState:UIControlStateNormal];
        
        if (!label_number) {
            label_number=[[UILabel alloc]initWithFrame:CGRectMake(292-5-1, 5, 30, 20)];
            [self addSubview:label_number];
            label_number.backgroundColor=[UIColor clearColor];
            label_number.font=[UIFont systemFontOfSize:11];
            label_number.textAlignment=UITextAlignmentCenter;
            label_number.textColor=[UIColor whiteColor];
            
        }

        label_number.text=[NSString stringWithFormat:@"%@",commentnumber];
    }else{
        
        _button_comment.frame=CGRectMake(285, (40-36/2)/2, 39/2, 36/2);
        [_button_comment setBackgroundImage:[UIImage imageNamed:@"ios7_bottomtalk_39_36.png"] forState:UIControlStateNormal];
    }
    
    UIButton *button_=[[UIButton alloc]initWithFrame:CGRectMake(275, 0, 40, 40)];
    button_.backgroundColor=[UIColor clearColor];
    [button_ addTarget:self action:@selector(refreshdata:) forControlEvents:UIControlEventTouchUpInside];
    button_.tag=205;
    [self addSubview:button_];
    
}
-(void)setcommentimage2{
    [_button_comment setBackgroundImage:[UIImage imageNamed:WRITE_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    
}

@end
