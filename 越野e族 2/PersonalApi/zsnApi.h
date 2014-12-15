//
//  zsnApi.h
//  FbLife
//
//  Created by soulnear on 13-4-2.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface ZSNButton : UIButton
{
    
}


@property(nonatomic,strong)NSDictionary * myDictionary;

@end




@interface zsnApi : NSObject

+(NSString *)timechange:(NSString *)placetime;
+(NSString *)timechange1:(NSString *)placetime;

+(NSString *)timeFromDate:(NSDate *)date;

/// 输入日期字符串如："1992-05-21 13:08:08" 返回NSDate
+(NSDate *)dateFromString:(NSString *)dateString;
///返回时间 年、月、日、时、分、秒
+(NSString *)stringFromDate:(NSDate *)date;


+ (NSString*)imgreplace:(NSString*)imgSrc;

+ (NSString*)Eximgreplace:(NSString*)imgSrc;


+(NSString *)exchangeString:(NSString *)string;

+ (float)theHeight:(NSString *)content withHeight:(CGFloat)theheight WidthFont:(UIFont *)font;

+(NSString *)exchangeFrom:(NSString *)from;

+(NSString *) fileSizeAtPath:(NSString*) filePath;

+(UIImage *)fitSmallImage:(UIImage *)image withSize:(CGSize)theSize;

+(NSString *)returnUrl:(NSString *)theUrl;

+(NSArray *)stringExchange:(NSString *)string;


+(float)calculateheight:(NSArray *)array;


+(NSMutableArray *)conversionFBContent:(NSDictionary *)userinfo isSave:(BOOL)isSave WithType:(int)theType;

//微博资源分享类型内容转换

+(NSString *)ShareResourceContent:(NSString *)theResource;

+(float)boolLabelLength:(NSString *)strString withFont:(int)theFont wihtWidth:(float)theWidth;

+(NSString*)FBImageChange:(NSString*)imgSrc;

+ (NSString*)FBEximgreplace:(NSString*)imgSrc;

+(BOOL) validateEmail: (NSString *) candidate;

+(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label font:(UIFont *)thefont linebreak:(NSLineBreakMode)linebreak;

//字符串转换，防止出现<null>

+(NSString *)exchangeStringForDeleteNULL:(id)sender;

///裁剪图片
+(UIImage *)scaleToSizeWithImage:(UIImage *)img size:(CGSize)size;

///pragma mark - 弹出提示框
+ (MBProgressHUD *)showMBProgressWithText:(NSString *)text addToView:(UIView *)aView;

///pragma mark - 弹出提示框，1.5秒后消失
+ (void)showAutoHiddenMBProgressWithText:(NSString *)text addToView:(UIView *)aView;
///弹出提示框（包含标题，内容），1.5秒后消失
+(void)showautoHiddenMBProgressWithTitle:(NSString *)title WithContent:(NSString *)content addToView:(UIView *)aView;

@end






