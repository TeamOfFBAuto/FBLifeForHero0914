//
//  ZkingNavigationView.h
//  RESideMenuExample
//
//  Created by 史忠坤 on 14-3-18.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZkingNavigationView;
@protocol ZkingNavigationViewDelegate <NSObject>

-(void)NavigationbuttonWithtag:(int)tag;

@end
@interface ZkingNavigationView : UIView{
    
}
@property(nonatomic,strong)UIButton *leftbutton;
@property(nonatomic,strong)UIButton *rightbutton;
@property(nonatomic,strong)UIImageView *centerlabel;
@property(assign,nonatomic)id<ZkingNavigationViewDelegate>delegate;
@end
