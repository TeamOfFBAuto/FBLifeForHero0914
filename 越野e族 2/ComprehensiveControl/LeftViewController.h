//
//  LeftViewController.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-7.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RESideMenu.h"

#import "ComprehensiveViewController.h"

@interface LeftViewController : UIViewController {
    NSArray *titles;
    NSArray *imageArr;
    int currentSelectButtonIndex;

}

@property(nonatomic,strong)ComprehensiveViewController *firstVC;

@end