//
//  ShareView.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-30.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

- (id)initWithFrame:(CGRect)frame thebloc:(ShareBloc)sbloc{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.array_icon=[NSArray arrayWithObjects:@"shareziliudi.png",@"sharefriendquan.png",@"shareweixin.png",@"shareweibo.png",@"sharemail.png", nil];
        
        self.arrray_title=[NSArray arrayWithObjects:@"自留地",@"微信好友",@"微信朋友圈",@"新浪微博",@"邮箱", nil];
        
        self.touchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568:480)];
        
        self.touchView.hidden=YES;
        
        self.touchView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.4];
        
        self.frame=CGRectMake(0, self.touchView.frame.size.height-268, 320, 268);

        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareviewHiden)];
        
        [self.touchView addGestureRecognizer:tap];
        
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.touchView];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.touchView];
        
        [self.touchView addSubview:self];
        
        
        _mybloc=sbloc;
        
        //title
        
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(34, 20, 200, 20)];
        titleLabel.text=@"分享到";
        titleLabel.textColor=RGBCOLOR(44, 44, 44);
        titleLabel.font=[UIFont systemFontOfSize:15];
        
        [self addSubview:titleLabel];
        
        
        for (int i=0; i<self.arrray_title.count; i++) {
            
            UIButton *thebutton=[[UIButton alloc]initWithFrame:CGRectMake(34+100*(i%3), 50+80*(i/3), 50, 50)];
            
            [thebutton setImage:[UIImage imageNamed:[self.array_icon objectAtIndex:i]] forState:UIControlStateNormal];
            
            thebutton.tag=i+100;
            
            [thebutton addTarget:self action:@selector(doshareButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:thebutton];
            
            UILabel *thelabel=[[UILabel alloc]initWithFrame:CGRectMake(24+100*(i%3), thebutton.frame.origin.y+55, 70, 20)];
            
            thelabel.font=[UIFont systemFontOfSize:12];
            
            thelabel.textColor=RGBCOLOR(44, 44, 44);
            
            thelabel.textAlignment=NSTextAlignmentCenter;
            
            thelabel.backgroundColor=[UIColor whiteColor];
            
            thelabel.text=[self.arrray_title objectAtIndex:i];
            
            [self addSubview:thelabel];
            
            
            
        }
        //分割线
        UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(0, 220, 320, 1)];
        
        viewLine.backgroundColor=RGBCOLOR(173, 173, 173);
        
        [self addSubview:viewLine];
        
        UIButton *cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 221, 320, 50)];
        
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        
        cancelButton.titleLabel.font=[UIFont systemFontOfSize:17];
        
        [cancelButton setTitleColor:RGBCOLOR(27, 27, 27) forState:UIControlStateNormal];
        
        cancelButton.backgroundColor=[UIColor clearColor];
        cancelButton.tag=self.array_icon.count+100;
        
        [cancelButton addTarget:self action:@selector(shareviewHiden) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:cancelButton];
        
        
        
        
        
        
        
    }
    return self;
}


-(void)doshareButton:(UIButton *)sender{

    [self shareviewHiden];
    _mybloc(sender.tag-100);

}



-(void)shareviewHiden{
    
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame=CGRectMake(0, self.touchView.frame.size.height, 320, 268);
//        self.touchView.alpha=0;

        
    } completion:^(BOOL finished) {
    
        self.touchView.hidden=YES;
        
//        self.touchView.alpha=1;


    }];
    
//    sleep(0.3);
//    
//    [UIView animateWithDuration:0.1 animations:^{
//        
//        self.touchView.alpha=0;
//        
//        
//    } completion:^(BOOL finished) {
//        
//        self.touchView.hidden=YES;
//        
//        self.touchView.alpha=1;
//        
//        
//    }];
//


}

-(void)ShareViewShow{
    
    self.touchView.hidden=NO;


    [UIView animateWithDuration:0.3 animations:^{
        

        self.frame=CGRectMake(0, self.touchView.frame.size.height-268, 320, 268);


    } completion:^(BOOL finished) {
        
        
    }];



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
