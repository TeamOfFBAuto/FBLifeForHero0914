//
//  SSWBViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-8-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialDataService.h"
@interface SSWBViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,AlertRePlaceViewDelegate>{
    UIButton * wordsNumber_button;//显示还可以输入的字数限制文字
    UIView * options_view;
    UIButton *    button_send;

}
@property(nonatomic,strong)UITextView * myTextView;
@property(nonatomic,strong)NSString * string_text;
@property(nonatomic,strong)UIImage * _shareimg;


@end
