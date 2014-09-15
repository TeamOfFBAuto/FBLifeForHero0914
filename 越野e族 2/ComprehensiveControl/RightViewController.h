//
//  RightViewController.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-7.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListViewController.h"
#import "downloadtool.h"


@interface RightViewController : UIViewController<FriendListViewControllerDelegate,downloaddelegate>
{
    AsyncImageView * headerImageView;//头像
    
    UILabel * LogIn_label;//用户名
    
    downloadtool * allnotificationtool;
    
    BOOL NewsMessageNumber;//消息数
    
    UIView * notification_view;//消息提醒，小红点
    
    NSTimer * timer;
}

@end
