//
//  CarPortSeg.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "CarPortSeg.h"
#define NUMBEROFBUTTON self.NameArray.count
#define SELECTEDCOLOR RGBCOLOR(49, 49, 49)
#define UNSELECTCOLOR RGBCOLOR(102, 102, 102)
#define UNTYPECOLOR RGBCOLOR(102,102,102)
#define TYPECOLOR RGBCOLOR(49,49,49)

@implementation CarPortSeg
@synthesize NameArray,type,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selectindex=0;
        
        selectindex1 = 10;
    
        // Initialization code
    }
    return self;
}
-(void)setType:(int)__type{
    UIButton *button_;
   // self.type=__type;
    
    mytype=__type;
    NSLog(@"type===%d",self.type);
    if (__type==0) {
        UIImageView *imgvline=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, 320, 0.5)];
        imgvline.image=[UIImage imageNamed:@"line-2.png"];
        [self addSubview:imgvline];
        self.backgroundColor=RGBCOLOR(247, 247, 247);

        
        NSLog(@"firstttttt");
        for (int i=0; i<NUMBEROFBUTTON; i++) {
            button_=[[UIButton alloc]initWithFrame:CGRectMake(i*320/NUMBEROFBUTTON, 0, 320/NUMBEROFBUTTON, 33)];
            button_.tag=i+1000;
            [button_ setTitle:[self.NameArray objectAtIndex:i] forState:UIControlStateNormal];
            button_.titleLabel.font=[UIFont systemFontOfSize:14];
            [button_ addTarget:self action:@selector(whichbuttonselected:) forControlEvents:UIControlEventTouchUpInside];
            button_.backgroundColor=[UIColor clearColor];
            [self addSubview:button_];
            
            UIImageView *imgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"carlineios7.png"]];
            imgv.frame=CGRectMake(320*(i+1)/4, 0, 0.5, 32);
            [self addSubview:imgv];
            
            if (button_.tag==1000) {
                button_.titleLabel.font=[UIFont boldSystemFontOfSize:14];


               // [button_ setBackgroundImage:[UIImage imageNamed:@"hover1.png"] forState:UIControlStateNormal];
                [button_ setTitleColor:SELECTEDCOLOR forState:UIControlStateNormal];
                
            }else{
              //  [button_ setBackgroundImage:[UIImage imageNamed:@"link1.png"] forState:UIControlStateNormal];
                [button_ setTitleColor:UNSELECTCOLOR forState:UIControlStateNormal];
                button_.titleLabel.font=[UIFont systemFontOfSize:14];


            }

        }
  
         
    }
    if (__type==1)
    {
        UIImageView *imgvline=[[UIImageView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-1, 320,1)];
        imgvline.image=[UIImage imageNamed:@"line-2.png"];
        [self addSubview:imgvline];
        
        for (int i=0; i<NUMBEROFBUTTON; i++)
        {
            
            NSString * title = [self.NameArray objectAtIndex:i];
            
            float theWidth = [zsnApi boolLabelLength:title withFont:14 wihtWidth:320/NUMBEROFBUTTON];
            
            button_=[[UIButton alloc]initWithFrame:CGRectMake(i*320/NUMBEROFBUTTON, 0, 320/NUMBEROFBUTTON, 33)];
            button_.tag=i+10000000;
            
            
            [button_ setTitle:[self.NameArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [button_ setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,12)];
            
            [button_ addTarget:self action:@selector(whichbuttonselected:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button_];
            
            button_.titleLabel.font = [UIFont systemFontOfSize:14];
            
            button_.showsTouchWhenHighlighted = YES;
            
            [button_ setTitleColor:UNTYPECOLOR forState:UIControlStateNormal];
            
            
            UIImageView * icon_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,17/2,11/2)];
            
            icon_view.image = [UIImage imageNamed:@"unselectsanjiao.png"];
            
            icon_view.tag = 100;
            
            icon_view.center = CGPointMake((320/NUMBEROFBUTTON)/2+theWidth/2 + 10 - 5,33/2+1);
            
            [button_ addSubview:icon_view];
            
            UIImageView *imgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"carlineios7.png"]];
            imgv.frame=CGRectMake(320*(i+1)/4, 0,0.5,32);
            [self addSubview:imgv];
        }
        
    }
    if (__type==2) {
        
//        self.backgroundColor=RGBCOLOR(255, 255, 255);
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios_7carportpicselect608_57.png"]];
        NSLog(@"firstttttt");
        for (int i=0; i<NUMBEROFBUTTON; i++) {
                button_=[[UIButton alloc]initWithFrame:CGRectMake(i*304/NUMBEROFBUTTON+0.5, 0, 303/NUMBEROFBUTTON, 57/2)];

  
            button_.tag=i+1000;
            button_.backgroundColor=[UIColor clearColor];
  

            [button_ setTitle:[self.NameArray objectAtIndex:i] forState:UIControlStateNormal];
            [button_ addTarget:self action:@selector(whichbuttonselected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button_];
            
            if (button_.tag==1000) {
                button_.titleLabel.font=[UIFont boldSystemFontOfSize:13];

                [button_ setTitleColor:SELECTEDCOLOR forState:UIControlStateNormal];
                
                
            }else{
                button_.titleLabel.font=[UIFont systemFontOfSize:13];

                [button_ setTitleColor:UNSELECTCOLOR forState:UIControlStateNormal];
            }
            
        }

        

        
        imagerow=[[UIImageView alloc]initWithFrame:CGRectMake(145/2, 12, 17/2, 11/2)];
        imagerow.image=[UIImage imageNamed:@"jjjiantou1711.png"];
        [self addSubview:imagerow];
        

        
        
    }
    
   

}
-(void)whichbuttonselected:(UIButton *)sender
{
    if (mytype==0)
    {
        
        NSLog(@"sender.tag===%d",sender.tag);
        UIButton *prebutton=(UIButton *)[self viewWithTag:selectindex+1000];
       // [prebutton setBackgroundImage:[UIImage imageNamed:@"link1.png"] forState:UIControlStateNormal];
        [prebutton setTitleColor:UNSELECTCOLOR forState:UIControlStateNormal];
        prebutton.titleLabel.font=[UIFont systemFontOfSize:14];
        
       // [sender setBackgroundImage:[UIImage imageNamed:@"hover1.png"] forState:UIControlStateNormal];
        [sender setTitleColor:SELECTEDCOLOR forState:UIControlStateNormal];
        sender.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        selectindex=sender.tag-1000;
        
        [self.delegate TapbuttonWithindex:selectindex type:self.type whichseg:self];

    }
    if (mytype==1)
    {
        if (sender.tag -10000000 == selectindex1)
        {
            if (!identifier[selectindex1])
            {
                
            }else
            {
                if (delegate && [delegate respondsToSelector:@selector(setDataViewHidden:)])
                {
                    
                    [self cancelButtonState];
                    [self setCountryName:@"国家"];
                    [delegate setDataViewHidden:sender.tag-10000000];
                }
                
                [sender setTitleColor:UNTYPECOLOR forState:UIControlStateNormal];
                
                UIImageView * imageView2 = (UIImageView *)[sender viewWithTag:100];
                
                imageView2.image = [UIImage imageNamed:@"unselectsanjiao.png"];
                
                identifier[selectindex1] = 0;
                
                return;
            }
        }
        
        UIButton *prebutton=(UIButton *)[self viewWithTag:selectindex1+10000000];
        
        UIImageView * imageView1 = (UIImageView *)[prebutton viewWithTag:100];
        
        [prebutton setTitleColor:UNTYPECOLOR forState:UIControlStateNormal];
        
        imageView1.image = [UIImage imageNamed:@"unselectsanjiao.png"];
        
        [sender setTitleColor:TYPECOLOR forState:UIControlStateNormal];
        
        UIImageView * imageView = (UIImageView *)[sender viewWithTag:100];
        
        imageView.image = [UIImage imageNamed:@"selectedsanjia.png"];
        
        identifier[selectindex1] = 0;
        
        identifier[sender.tag-10000000] = 1;
        
        selectindex1=sender.tag-10000000;
        
        [self.delegate TapbuttonWithindex:selectindex1 type:self.type whichseg:self];
    }
    
    if (mytype==2) {
        UIButton *prebutton=(UIButton *)[self viewWithTag:selectindex+1000];
        [prebutton setTitleColor:UNSELECTCOLOR forState:UIControlStateNormal];
        prebutton.titleLabel.font=[UIFont systemFontOfSize:13];
        
//        prebutton.backgroundColor=RGBCOLOR(245, 245, 245);
//        sender.backgroundColor=RGBCOLOR(218, 218, 218);

        [sender setTitleColor:SELECTEDCOLOR forState:UIControlStateNormal];
        sender.titleLabel.font=[UIFont boldSystemFontOfSize:13];
        
        selectindex=sender.tag-1000;
        
        
        imagerow.frame=CGRectMake(sender.frame.origin.x+145/2, 12, 17/2, 11/2);
        
        
        
        //        UIButton *prebutton=(UIButton *)[self viewWithTag:selectindex+2000];
        //        [prebutton setBackgroundColor:RGBCOLOR(218, 218, 218)];
        //        [prebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //
        //        [sender setBackgroundColor:RGBCOLOR(225, 225, 225)];
        //        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //
        //        selectindex=sender.tag-2000;
        
        [self.delegate TapbuttonWithindex:selectindex type:self.type whichseg:self];

    }

}


-(void)setCountryName:(NSString *)theName
{
    UIButton * button = (UIButton *)[self viewWithTag:10000002];
    
    if (theName.length > 2)
    {
        
        theName = [theName substringToIndex:2];
        
        theName = [NSString stringWithFormat:@"%@··",theName];
      
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,15)];
    }else
    {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,12)];
    }
    
    [button setTitle:theName forState:UIControlStateNormal];
}

-(void)cancelButtonState
{
    UIButton * sender = (UIButton *)[self viewWithTag:selectindex1+10000000];
    
    identifier[selectindex1] = 0;
    
    [sender setTitleColor:UNTYPECOLOR forState:UIControlStateNormal];
    
    UIImageView * imageView2 = (UIImageView *)[sender viewWithTag:100];
    
    imageView2.image = [UIImage imageNamed:@"unselectsanjiao.png"];
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
