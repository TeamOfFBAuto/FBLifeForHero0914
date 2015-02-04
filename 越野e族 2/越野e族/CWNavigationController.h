//
//  CWNavigationController.h
//  CWProject
//
//  Created by Lichaowei on 14-4-4.
//  Copyright (c) 2014年 Chaowei LI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    AnimationMove = 0, //滑动返回有缩放效果,default
    AnimationZoom = 1 //滑动返回平移效果
}AnimationStyle;

@interface CWNavigationController : UINavigationController

// Enable the drag to back interaction, Default is YES.
@property (nonatomic,assign) BOOL canDragBack;
@property (nonatomic,assign) AnimationStyle animationStyle;//动画效果
@property (nonatomic,retain) UIPanGestureRecognizer *panGesture;

@end
