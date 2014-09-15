//
//  AlertRePlaceView.h
//  FbLife
//
//  Created by 史忠坤 on 13-6-20.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertRePlaceView;
@protocol AlertRePlaceViewDelegate <NSObject>

-(void)hidefromview;

@end
@interface AlertRePlaceView : UIImageView
- (id)initWithFrame:(CGRect)frame labelString:(NSString *)_string;

-(void)hide;
@property(assign,nonatomic)id<AlertRePlaceViewDelegate>delegate;
@end
