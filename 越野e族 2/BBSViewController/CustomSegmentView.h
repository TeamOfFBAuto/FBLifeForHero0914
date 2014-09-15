//
//  CustomSegmentView.h
//  FbLife
//
//  Created by soulnear on 13-7-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@protocol CustomSegmentViewDelegate <NSObject>

-(void)buttonClick:(int)buttonSelected;

@end

#import <UIKit/UIKit.h>

@interface CustomSegmentView : UIView
{
    
}

@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)id<CustomSegmentViewDelegate>delegate;



-(void)setDelegate:(id<CustomSegmentViewDelegate>)delegate1;



-(void)setAllViewWithArray:(NSArray *)array;
-(void)settitleWitharray:(NSArray *)arrayname;


@end
