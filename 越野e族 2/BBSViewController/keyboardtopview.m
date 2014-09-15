//
//  keyboardtopview.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-19.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import "keyboardtopview.h"

@implementation keyboardtopview
@synthesize KeyboardButton=_KeyboardButton,CammeraButton=_CammeraButton,PhotoButton=_PhotoButton,delegate,imV=_imV,image_=_image_,changeimage=_changeimage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     //   self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"640x82.png"]];
        self.backgroundColor=RGBCOLOR(244, 244, 246);
        
    }
    return self;
}

-(UIButton *)KeyboardButton{
    
    
    if (!_KeyboardButton) {
        _KeyboardButton=[[UIButton alloc]initWithFrame:CGRectMake(150, 10, 43/2, 43/2)];
        [_KeyboardButton setBackgroundImage:[UIImage imageNamed:@"ios7_face43_43.png"] forState:UIControlStateNormal];
        [_KeyboardButton addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        [_KeyboardButton setTag:301];
    }
    return _KeyboardButton;
}

-(UIButton*)CammeraButton{
    if (!_CammeraButton) {
        _CammeraButton=[[UIButton alloc]initWithFrame:CGRectMake(25, 10, 51/2, 37/2)];
        [_CammeraButton setBackgroundImage:[UIImage imageNamed:@"ios7_camerom_write51_37.png"] forState:UIControlStateNormal];
        [_CammeraButton addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        [_CammeraButton setTag:302];
    }
    return _CammeraButton;
}
-(UIButton*)PhotoButton{
    
    if (!_PhotoButton) {
        _PhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(85, 10, 53/2, 36/2)];
        [_PhotoButton setBackgroundImage:[UIImage imageNamed:@"ios7_photo_write53_36.png"] forState:UIControlStateNormal];
        [_PhotoButton addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        [_PhotoButton setTag:303];
    }
    return _PhotoButton;
}
//-(UIImageView*)imV{
//    if (_imV) {
//        _imV=[[UIImageView alloc]initWithFrame:CGRectMake(205, 2.5, 35, 35)];
//    }
//    return _imV;
//}
-(void)FaceAndKeyBoard:(int)isface{
    if (isface==1) {
        _KeyboardButton.frame=CGRectMake(150, 10, 43/2, 43/2);
        [_KeyboardButton setBackgroundImage:[UIImage imageNamed:@"ios7_face43_43.png"] forState:UIControlStateNormal];
    }else{
        _KeyboardButton.frame=CGRectMake(150, 10, 48/2, 35/2);
        [_KeyboardButton setBackgroundImage:[UIImage imageNamed:@"ios7_keyboard_48_35.png"] forState:UIControlStateNormal];
    }
    
}

-(void)setImage_:(UIImage *)image_{
    
    NSLog(@"有木有图片===%@",image_);
    Bottom_View=[[UIView alloc]initWithFrame:CGRectMake(190, 0, 65, 40)];
    Bottom_View.backgroundColor=[UIColor clearColor];
    [self addSubview:Bottom_View];
    
    _imV=[[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 35, 24)];
    _imV.image=image_;
    CALayer *l = [_imV layer];   //获取ImageView的层
    [l setMasksToBounds:YES];
    [l setCornerRadius:5.0];
    _imV.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    lpress.minimumPressDuration = 1;
    [Bottom_View addGestureRecognizer:lpress];
    
    Delete_Button=[[UIButton alloc]initWithFrame:CGRectMake(0,0, 23, 23)];
    [Delete_Button setBackgroundImage:[UIImage imageNamed:@"error46X46.png"] forState:UIControlStateNormal];
    Delete_Button.hidden=YES;
    
    [Bottom_View addSubview:_imV];
    [Bottom_View addSubview:Delete_Button];
    
    UITapGestureRecognizer *OneTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taptap)];
    [OneTap setNumberOfTapsRequired:1];
    [Bottom_View addGestureRecognizer:OneTap];
 
    
}
-(void)layoutSubviews{
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    lineView.backgroundColor=RGBCOLOR(183, 183, 183);
    [self addSubview:lineView];
    [self addSubview:self.KeyboardButton];
    [self addSubview:self.CammeraButton];
    [self addSubview:self.PhotoButton];
}

-(void)longPress{
//    [self.delegate removeimage];
//    [_imV removeFromSuperview];
//    _imV = nil;
    CGFloat rotation = 0.06;
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(Bottom_View.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(Bottom_View.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    Delete_Button.hidden=NO;
    [Bottom_View.layer addAnimation:shake forKey:@"shakeAnimation"];
    [Delete_Button addTarget:self action:@selector(Deleteimage) forControlEvents:UIControlEventTouchUpInside];

}
-(void)taptap
{
    Delete_Button.hidden=YES;
    [Bottom_View.layer removeAllAnimations];
}
-(void)Deleteimage{
    
    [_imV removeFromSuperview];
    _imV=nil;
    
    [Delete_Button removeFromSuperview];
    Delete_Button=nil;
    
    [self.delegate removeimage];
}
-(void)dianji:(UIButton *)sender{
    [self.delegate clickbutton:sender];
}
-(void)bottoming{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self setFrame:CGRectMake(0,iPhone5? [UIScreen mainScreen].bounds.size.height-40+88:[UIScreen mainScreen].bounds.size.height-40, 320, 40)];
    [UIView commitAnimations];
}
-(void)uping{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (IOS_VERSION>=7) {
        [self setFrame:CGRectMake(0,iPhone5?205+88+20:205+20, 320, 40)];

        
    }else{
        [self setFrame:CGRectMake(0,iPhone5?205+88:205, 320, 40)];

    }
    [UIView commitAnimations];
}
-(void)chinesekeyuping{
    NSLog(@"中文状态");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (IOS_VERSION>=7) {
        [self setFrame:CGRectMake(0,iPhone5? 168+88+20:168+20, 320, 40)];

        
    }else{
        [self setFrame:CGRectMake(0,iPhone5? 168+88:168, 320, 40)];

    }
    
    [UIView commitAnimations];
}
-(void)jiugonggechineseuping{
    
    NSLog(@"中文状态");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (IOS_VERSION>=7) {
        [self setFrame:CGRectMake(0,iPhone5? 168+88+20:168+20, 320, 40)];
        
        
    }else{
        [self setFrame:CGRectMake(0,iPhone5? 168+88:168, 320, 40)];
        
    }
    
    [UIView commitAnimations];
    
}
-(void)jiugonggepinyinuping{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (IOS_VERSION>=7) {
        [self setFrame:CGRectMake(0,iPhone5?205+88+20+216-184:205+20+216-184, 320, 40)];
        
        
    }else{
        [self setFrame:CGRectMake(0,iPhone5?205+88+216-184:205+216-184, 320, 40)];
        
    }
    [UIView commitAnimations];
    
}
-(void)WhenfaceviewFram{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (IOS_VERSION>=7) {
        [self setFrame:CGRectMake(0,iPhone5? 263+88+20-55:263+20-55, 320, 40)];

        
    }else{
        [self setFrame:CGRectMake(0,iPhone5? 263+88-55:263-55, 320, 40)];

    }
    [UIView commitAnimations];
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
