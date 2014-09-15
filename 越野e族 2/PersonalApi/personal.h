//
//  personal.h
//  ZixunDetail
//
//  Created by szk on 13-1-10.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface personal : NSObject
+(NSString *)chulizifuchuan:(NSString *)yuanzifuchuan;
+(NSString*)timestamp:(NSString*)myTime;
+ (NSString*)imgreplace:(NSString*)imgSrc;
+(BOOL)islastpage:(int)total pagenumber:(int)willshangchuanpage;
+(BOOL)isiphone5;
+(UIFont*)commentcount:(NSString *)string_count;
+(NSString *)place:(NSString *)category_string;
+(NSString *)timchange:(NSString *)placetime;
+(NSString *)timechange:(NSString *)placetime;
+(UIImage *)getImageWithName:(NSString *)imageName;
+(int)returnrightnumber:(int)number;



+(NSArray *)DownKeys:(NSArray *)array;

+(NSString*)cutStr:(NSString*)content;
+(NSMutableString * )cutStr:(NSString*)content withArray:(NSMutableArray *)array;


+(NSString*)strReplace:(NSString*)str;

+(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label font:(UIFont *)thefont;

+(UIImage *)scaleToSizeWithImage:(UIImage *)img size:(CGSize)size;


+(UIImage *)fixOrientation:(UIImage *)aImage;


//截取字符串
+(NSArray *)CutString:(NSString *)sender;

+(NSString *)deleteSpace:(NSString *)string;
+(int)returnHeight:(NSArray *)array;

+(void)mycategoryname:(NSString *)_name category_dic:(NSDictionary*)_dic;
+(void)bycategoryname:(NSString *)_name myimage_dic:(NSDictionary *)_dic;

//返回当前的时间

+(NSString *)mycurrenttime;
+(NSString*)receivemutablearray:(NSMutableArray *)_mutablearray index:(int)selectatindex;


+(NSString *)getwanwithstring:(NSString *)stringproce;
+(NSString *)getdouhaowithstring:(NSString *)stringprice;
//获取高度
+(float)celllength:(float)length lablefont:(UIFont*)font labeltext:(NSString *)text;
+(NSString *)getuidwithstring:(NSString *)stringsymbaldata;
+(NSString*)testtime:(NSString *)test;
//MD5加密字符串

-(NSString *)mds:(NSString *)str;

//获取自己的authoeky

+(NSString *)getMyAuthkey;


/**
 *  播放系统声音
 */

//

//+(void)playsysy;
@end
