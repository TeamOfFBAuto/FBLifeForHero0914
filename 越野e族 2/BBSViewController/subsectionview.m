//
//  subsectionview.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-6.
//  Copyright (c) 2013年 szk. All rights reserved.
#import "subsectionview.h"

@implementation subsectionview
@synthesize array_name=_array_name,array_id=_array_id,buttonselectdelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBCOLOR(252, 252, 252);
    }
    return self;
}
-(void)layoutSubviews{
//    NSLog(@"what is your name");
//    NSLog(@"array_name==%@",self.array_name);
//      for (int i=0; i<[_array_name count]; i++)
//      {
//        UIButton *button_=[[UIButton alloc]initWithFrame:CGRectMake(20+i%3*75, i/3*45, 60, 40)];
//        [self addSubview:button_];
//        button_.tag=[[_array_id objectAtIndex:i] integerValue];
//        button_.backgroundColor=[UIColor clearColor];
//      //  button_.titleLabel.font=[UIFont systemFontOfSize:13];
//          NSString *string_name=[_array_name objectAtIndex:i];
//          if (string_name.length>4) {
//              string_name=[string_name substringToIndex:4];
//          }
//        [button_ setTitle:string_name forState:UIControlStateNormal];
//         [button_ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button_ addTarget:self action:@selector(touchbutton:) forControlEvents:UIControlEventTouchUpInside];
//      }
    
    int row = 0;
    
    float theWidth = 0;
    
    int num = 0;

    for (int i = 0;i <_array_name.count;i++)
    {
        NSString *string_name=[_array_name objectAtIndex:i];
        
        CGSize size= [string_name sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        
        NSLog(@"怎么就换行了呢 ----  %f",20+theWidth + num*15 + size.width);
        if (36+theWidth + num*15 + size.width > 240)
        {
            theWidth = 0;
            row++;
            num = 0;
        }
        
        
        
     }
    int row1 = 0;
    
    float theWidth1 = 0;
    
    int num1 = 0;

    
    if (row==0) {
        for (int i = 0;i <_array_name.count;i++)
        {
            NSString *string_name=[_array_name objectAtIndex:i];
            
            CGSize size= [string_name sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            
            
            UIButton * button_ = [[UIButton alloc] init];//WithFrame:CGRectMake(20+i%3*75,i/3*45,size.width,40)];
         //  [ button_ setFont:[UIFont systemFontOfSize:13]];
            [button_.titleLabel setFont:[UIFont systemFontOfSize:13]];
            NSLog(@"一共就一行----  %f",20+theWidth1 + num1*15 + size.width);
            if (36+theWidth1 + num1*15 + size.width > 240)
            {
                theWidth1 = 0;
                row1++;
                num1 = 0;
            }
            
            
            
            button_.frame = CGRectMake(36+theWidth1+num1*15,row1*45+5.5,size.width,40);
            
            theWidth1 += size.width;
            
            num1++;
            
            [self addSubview:button_];
            button_.tag=[[_array_id objectAtIndex:i] integerValue];
            NSLog(@"wolegequ zes  ----  %d",[[_array_id objectAtIndex:i] integerValue]);
            button_.backgroundColor=[UIColor clearColor];
           // button_.titleLabel.font=[UIFont systemFontOfSize:13];
            //          if (string_name.length>4) {
            //              string_name=[string_name substringToIndex:4];
            //          }
            [button_ setTitle:string_name forState:UIControlStateNormal];
            [button_ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_ addTarget:self action:@selector(touchbutton:) forControlEvents:UIControlEventTouchUpInside];
        }
        

    }else{
        for (int i = 0;i <_array_name.count;i++)
        {
            NSString *string_name=[_array_name objectAtIndex:i];
            
            CGSize size   = [string_name sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            
            
            UIButton * button_ = [[UIButton alloc] init];//WithFrame:CGRectMake(20+i%3*75,i/3*45,size.width,40)];
        //    NSLog(@"怎么就换行了呢 ----  %f",20+theWidth1 + num1*15 + size.width);
            if (36+theWidth1 + num1*15 + size.width > 240)
            {
                theWidth1 = 0;
                row1++;
                num1 = 0;
            }
            
            
            
            button_.frame = CGRectMake(36+theWidth1+num1*15,row1*45,size.width,40);
            
            theWidth1 += size.width;
            
            num1++;
            
            [self addSubview:button_];
            button_.tag=[[_array_id objectAtIndex:i] integerValue];
            NSLog(@"wolegequ zes  ----  %d",[[_array_id objectAtIndex:i] integerValue]);
            button_.backgroundColor=[UIColor clearColor];
           // button_.titleLabel.font=[UIFont systemFontOfSize:13];
        
            //          if (string_name.length>4) {
            //              string_name=[string_name substringToIndex:4];
            //          }
            [button_ setTitle:string_name forState:UIControlStateNormal];
            [button_ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_ addTarget:self action:@selector(touchbutton:) forControlEvents:UIControlEventTouchUpInside];
        }
        

        
        
    }
    
    
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,(row1+1)*45+5);
    
    
    NSLog(@"多少航了呢 -==---  %d",row);
    
    UIImageView *imagexian=[[UIImageView alloc]initWithFrame:CGRectMake(0,(row1+1)*45+5-1, 320-70, 0.5)];
    imagexian.image=[UIImage imageNamed:@"1-478-1.png"];
    [self addSubview:imagexian];
}
-(void)touchbutton:(UIButton *)sender{
    [self.buttonselectdelegate selectbuttontag:sender.tag];
}
//对应ios6下的横竖屏问题
- (BOOL)shouldAutorotate{
    return  NO;
}
@end
