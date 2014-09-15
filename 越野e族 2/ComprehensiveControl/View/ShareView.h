//
//  ShareView.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-30.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ShareBloc)(NSInteger indexPath);

@interface ShareView : UIView

@property(nonatomic,strong)NSArray *arrray_title;//标题

@property(nonatomic,strong)NSArray *array_icon;//按钮的图片数组

@property(nonatomic,strong)UIView *touchView;

@property(nonatomic,strong)UIView *bgView;



@property(copy,nonatomic)ShareBloc mybloc;



- (id)initWithFrame:(CGRect)frame thebloc:(ShareBloc)sbloc;

-(void)shareviewHiden;

-(void)ShareViewShow;


@end
