//
//  CarPortSeg.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarPortSeg;
@protocol CarPortSegDelegate <NSObject>

-(void)TapbuttonWithindex:(int)buttonondex type:(int)__segtype whichseg:(CarPortSeg *)_seg;

@optional

-(void)setDataViewHidden:(int)buttonindex;

@end
@interface CarPortSeg : UIView{
    int selectindex;
    
    int selectindex1;
    int mytype;
    UIImageView *imagerow;
    
    int identifier[255];
}
@property(nonatomic,strong)NSArray *NameArray;
@property(assign,nonatomic)int type;
@property(assign,nonatomic)id<CarPortSegDelegate>delegate;




-(void)setCountryName:(NSString *)theName;

-(void)cancelButtonState;





@end
