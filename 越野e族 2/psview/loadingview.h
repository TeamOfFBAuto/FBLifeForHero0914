//
//  loadingview.h
//  FblifeAll
//
//  Created by szk on 13-1-24.
//  Copyright (c) 2013年 fblife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadingview : UIView{
    UIActivityIndicatorView *activityIndicator;
}
-(void)hide;
-(void)show;
@end
