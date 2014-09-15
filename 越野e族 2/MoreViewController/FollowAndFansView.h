//
//  FollowAndFansView.h
//  越野e族
//
//  Created by 史忠坤 on 13-12-28.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FollowAndFansView;
@protocol FollowAndFansViewDelegate <NSObject>
-(void)fuzhiWithfollow:(NSString *)_flownumber fansN:(NSString *)_fansnumber;

@end
@interface FollowAndFansView : UIView

@property(nonatomic,assign)id<FollowAndFansViewDelegate>delegate;

@end
