//
//  HintView.h
//  mytubo_iphone
//
//  Created by user on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface HintView : UILabel 

+(id)HintViewWithText:(NSString *)text;
-(void)show;
-(void)showAutoDestory;
-(void)destroy;

@end
