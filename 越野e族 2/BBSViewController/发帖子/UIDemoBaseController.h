//
//  UIDemoBaseController.h
//  MSC20Demo
//
//  Created by msp on 12-9-12.
//  Copyright 2012 IFLYTEK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>	

// 文本框坐标
// the textview coordinates
#define H_BACK_TEXTVIEW_FRAME		CGRectMake(6, 0, 308, 187)

#define H_TEXTVIEW_FRAME			CGRectMake(6, 0, 308, 185)

// 图片名称
// the image name
#define PNG_CONTENT_BACK	@"editbox.png"

#define H_CONTROL_ORIGIN CGPointMake(20, 70)

//此appid为您所申请,请勿随意修改
//this APPID for your application,do not arbitrarily modify
#define APPID @"515988e5"
#define ENGINE_URL @"http://dev.voicecloud.cn:1028/index.htm"

typedef enum _IsrType
{
	IsrText = 0,        // 转写,recognition
	IsrKeyword,	        // 关键字识别,keyword recognition
	IsrUploadKeyword    // 关键字上传,keyword upload
}IsrType;

@interface UIDemoBaseController : UITableViewController <UITextViewDelegate>
{
	UITextView	*_textView;     //文本显示框,the textview
}

/*
 @function: addTextViewWithFrame
 @abstract: 为view添加文本显示框, add textview for view
 @discussion:
 @return:    
 */
- (UITextView *)addTextViewWithFrame:(CGRect)frame theText:(NSString *)text;

/*
@function: addButton
@abstract: 为view添加button,add button for view
@discussion:
@return:    
 */
- (UIButton *)addButton:(CGRect)frame theTitle:(NSString *)title 
		 theNomarlImage:(UIImage *)nomarlImage 
		thePressedImage:(UIImage *)pressedImgae
		theDisableImage:(UIImage *)disableImage
				 target:(SEL)action;

@end
