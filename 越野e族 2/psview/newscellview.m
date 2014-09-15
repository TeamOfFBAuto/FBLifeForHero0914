//
//  newscellview.m
//  FbLife
//
//  Created by 史忠坤 on 13-2-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#define WEIGTHOFDISCRIBE ALL_FRAME.size.width-85-24-10
#import "newscellview.h"
@implementation newscellview
@synthesize imagev=_imagev,title_label=_title_label,date_label=_date_label;
@synthesize imv_string=_imv_string,title_string=_title_string,date_string=_date_string,discribe_string=_discribe_string,grayorblack;
- (id)initWithFrame:(CGRect)frame
{
    ///自动生成注释？
    
    self = [super initWithFrame:frame];
    if (self) {
        _imagev=[[AsyncImageView alloc]initWithFrame:CGRectMake( 12, 13, 90, 60)];
        [self addSubview:_imagev];
        _title_label=[[UILabel alloc]init];
        [self addSubview:_title_label];
        _date_label=[[UILabel alloc]initWithFrame:CGRectMake(ALL_FRAME.size.width-10-60-3,55+6,61.5-3, 10)];
        _date_label.textAlignment=UITextAlignmentRight;
        
        self.title_label.font=[UIFont systemFontOfSize:16.0];
        self.title_label.textColor=RGBCOLOR(49, 49, 49);
        self.title_label.backgroundColor=[UIColor clearColor];
        
        self.date_label.font=[UIFont systemFontOfSize:10];
        
        UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 76+10.5, 320-24, 0.5)];
        viewline.backgroundColor=RGBCOLOR(223, 223, 223);
        [self addSubview:viewline];
        
    }
    return self;
}
-(void)setImv_string:(NSString *)imv_string{
    _imv_string=imv_string;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_imagev loadImageFromURL:_imv_string withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
            });
        }
    });
}
-(void)setTitle_string:(NSString *)title_string{
    if (title_string.length!=0) {
        _title_string=title_string;
        
        NSString *cellText = _title_string;
        self.title_label.text=_title_string;
        self.title_label.numberOfLines=0;
        self.title_label.textColor=[UIColor blackColor];
        self.title_label.font=[UIFont systemFontOfSize:16.f];
        UIFont *cellFont = [UIFont systemFontOfSize:16.f];
        CGSize constraintSize = CGSizeMake(ALL_FRAME.size.width-85-22-12, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        self.title_label.frame = CGRectMake(101+7, 11,ALL_FRAME.size.width-85-22-12, labelSize.height);
        
    }
    
}
-(void)setDate_string:(NSString *)date_string{
    _date_string=date_string;
    
    self.date_label.text=[personal timchange:_date_string];
    
    self.date_label.textColor=RGBCOLOR(193, 192, 192);
    
}
-(void)setDiscribe_string:(NSString *)discribe_string{
    
    _discribe_string=discribe_string;
    NSArray *arraytest =[NSArray arrayWithObject:_discribe_string];
    
    UIView *aview1=[self assembleMessageAtIndex:arraytest];
        aview1.backgroundColor=[UIColor clearColor];
    aview1.frame=CGRectMake(101+8, 32+8,WEIGTHOFDISCRIBE, 40);
    aview1.backgroundColor=[UIColor clearColor];
    [self addSubview:aview1];
    [self addSubview:_date_label];
    
    
    
    
}

-(void)setGrayorblack:(int)_grayorblack{
    
    self.title_label.textColor=_grayorblack?[UIColor grayColor]:[UIColor blackColor];
    
}

#pragma mark-有关图文混排的，返回view和高度

-(UIView *)assembleMessageAtIndex:(NSArray *)arr
{
#define KFacialSizeWidth 18
#define KFacialSizeHeight 18
    UIView *returnView = [[UIView alloc] init];
    
    NSArray *data = [[NSArray alloc]initWithArray:arr];
    UIFont *fon= [UIFont systemFontOfSize:11];
	CGFloat upX=0;
    CGFloat upY=0;
    BOOL isdote=0;
    NSLog(@"data===%@",data);
	if (data) {
		for (int i=0;i<[data count];i++) {
            
            
            
            
            
            
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                
                
                
                if (upX > WEIGTHOFDISCRIBE-10)
                {
                    upY = upY + KFacialSizeHeight+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[personal imgreplace:yaoxi];
                
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, 19, 20);
                [returnView addSubview:img];
				upX=KFacialSizeWidth+upX+3;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > WEIGTHOFDISCRIBE-10)
                    {
                        upY = upY + KFacialSizeHeight+1;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(WEIGTHOFDISCRIBE, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    if (j%2==0) {
                        la.backgroundColor=[UIColor clearColor];
                        
                    }else{
                        la.backgroundColor=[UIColor clearColor];
                    }
                    la.font = fon;
                    la.text = temp;
                    la.textColor=RGBCOLOR(124, 124, 124);
                
                    if (upY<10) {
                        [returnView addSubview:la];
                        
                    }else if(upY==19&&upX<130){
                        [returnView addSubview:la];
                        
                    }else if(upY==19&&isdote==0){
                        isdote=!isdote;
                        UILabel *label_dote=[[UILabel alloc] initWithFrame:CGRectMake(upX, 17, 40, 20)];
                        label_dote.font=[UIFont systemFontOfSize:11];
                        label_dote.backgroundColor=[UIColor clearColor];
                        label_dote.text=@"...";
                        label_dote.textColor=RGBCOLOR(123, 123, 123);
                        [returnView addSubview:label_dote];
                        
                    }
                    
                    upX=upX+size.width;
                }
			}
        }
	}
    
    NSLog(@"UPX=====%f\n.....UPY=====%f",upX,upY);
    
    
    
    
    return returnView;
    
    
    
    
}
-(CGFloat)qugaodu:(NSArray*)arr{
    
    UIView *returnView = [[UIView alloc] init];
    
    NSArray *data = [[NSArray alloc]initWithArray:arr];
    
    UIFont *fon=   [UIFont fontWithName:@"Helvetica" size:11];
    
	CGFloat upX=0;
    CGFloat upY=0;
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                if (upX > WEIGTHOFDISCRIBE)
                {
                    upY = upY + KFacialSizeHeight+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[personal imgreplace:yaoxi];
                
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, 19, 20);
                [returnView addSubview:img];
				upX=KFacialSizeWidth+upX+3;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > WEIGTHOFDISCRIBE-10)
                    {
                        upY = upY + KFacialSizeHeight+3;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(WEIGTHOFDISCRIBE, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    upX=upX+size.width;
                }
			}
        }
	}
    
    return upY+25 ;
}



@end
