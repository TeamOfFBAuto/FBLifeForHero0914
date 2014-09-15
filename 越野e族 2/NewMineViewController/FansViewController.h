//
//  FansViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-6.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^hiddenNavgationBlock)(void);


@interface FansViewController : UIViewController
{
    hiddenNavgationBlock hiddennavigation_block;
}


-(void)setNavigationHiddenWith:(BOOL)isHidden WithBlock:(hiddenNavgationBlock)theBlock;



@end
