//
//  personal.m
//  ZixunDetail
//
//  Created by szk on 13-1-10.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#include <AudioToolbox/AudioToolbox.h>
#include <CoreFoundation/CFURL.h>
#include <OpenAL/al.h>
#include <OpenAL/alc.h>
#include <pthread.h>
#include <mach/mach.h>

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

@implementation personal
+(NSString *)chulizifuchuan:(NSString *)yuanzifuchuan{
    
    NSString *string_=yuanzifuchuan;
    return string_;
    
}
+(int)returnrightnumber:(int)number{
    int mm=0;
    if (number%3==0) {
        mm=number/3;
    }else{
        mm=number/3+1;
    }
    return mm;
}

//月日十分
+(NSString *)timechange:(NSString *)placetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[placetime doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

//年月日
+(NSString *)timchange:(NSString *)placetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[placetime doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}
+(NSString*)testtime:(NSString *)test{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[test doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    NSLog(@"-----%@---",confromTimespStr);
    
    return test;
}

+(NSString*)timestamp:(NSString*)myTime{
    
    NSString *timestamp;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now,  [myTime integerValue]);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d%@", distance, @"秒钟前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d%@", distance,@"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d%@", distance,@"天前"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, @"周前"];
    }else
    {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970: [myTime integerValue]];
        
        timestamp = [dateFormatter stringFromDate:date];
    }
    
    return timestamp;
}
+ (NSString*)imgreplace:(NSString*)imgSrc{
    NSString* img=imgSrc;
    img= [img stringByReplacingOccurrencesOfString:@"[发呆]" withString:@"face1.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[无奈]" withString:@"face2.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[坏笑]" withString:@"face3.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[撇嘴]" withString:@"face4.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[可爱]" withString:@"face5.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[得意]" withString:@"face6.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[晕]" withString:@"face7.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大哭]" withString:@"face8.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[衰]" withString:@"face9.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难过]" withString:@"face10.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[微笑]" withString:@"face11.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[傻笑]" withString:@"face12.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[愤怒]" withString:@"face13.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[酷]" withString:@"face14.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[汗]" withString:@"face15.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[惊讶]" withString:@"face16.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鼻涕]" withString:@"face17.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[美女]" withString:@"face18.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[帅哥]" withString:@"face19.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[流泪]" withString:@"face20.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[囧]" withString:@"face21.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[生气]" withString:@"face22.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雷人]" withString:@"face23.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吓]" withString:@"face24.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大笑]" withString:@"face25.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吐]" withString:@"face26.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[尴尬]" withString:@"face27.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感动]" withString:@"face28.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[纠结]" withString:@"face29.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[宠物]" withString:@"face30.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[睡觉]" withString:@"face31.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[奋斗]" withString:@"face32.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[左哼]" withString:@"face33.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[右哼]" withString:@"face34.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[崩溃]" withString:@"face35.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[委屈]" withString:@"face36.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[疑问]" withString:@"face37.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[太棒了]" withString:@"face38.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鄙视]" withString:@"face39.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[打哈欠]" withString:@"face40.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[无语]" withString:@"face41.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[亲亲]" withString:@"face42.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[恐惧]" withString:@"face43.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[骷髅]" withString:@"face44.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[俏皮]" withString:@"face45.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[爱财]" withString:@"face46.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[海盗]" withString:@"face47.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难受]" withString:@"face48.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[思考]" withString:@"face49.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感冒]" withString:@"face50.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[闭嘴]" withString:@"face51.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[菜刀]" withString:@"face52.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[礼物]" withString:@"face53.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[药水]" withString:@"face54.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雨天]" withString:@"face55.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[砸]" withString:@"face56.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[炸弹]" withString:@"face57.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[胜利]" withString:@"face58.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[发飙]" withString:@"face59.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[喜欢]" withString:@"face60.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[不错]" withString:@"face61.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大爱]" withString:@"face62.png"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[仰慕]" withString:@"face63.png"] ;
    //替换回车占位符
    img= [img stringByReplacingOccurrencesOfString:@"\n" withString:@" "] ;
    img= [img stringByReplacingOccurrencesOfString:@"\r" withString:@" "] ;
    //替换  &  这个符号
    img= [img stringByReplacingOccurrencesOfString:@"&" withString:@" "] ;
    return img;
}
+(NSString *)place:(NSString *)category_string
{
    NSString *placecategorey=category_string;
    NSArray *array_chinese=[NSArray arrayWithObjects:@"最新",@"新闻",@"品车",@"改装",@"导购",@"摄影",@"赛事",@"房车",@"铁骑",@"旅行",@"活动",@"户外",@"公益",nil];
    NSArray *array_pinyin=[NSArray
                           arrayWithObjects:@"zuixin",@"xinwen",@"pinche",@"gaizhuang",@"daogou",@"sheying",@"saishi",@"fangche",@"tieqi",@"lvxing",@"huodong",@"huwai",@"gongyi",nil];
    
    for (int i=0; i<array_chinese.count; i++) {
        if ([placecategorey isEqualToString:[array_chinese objectAtIndex:i]]) {
            placecategorey=[NSString stringWithFormat:@"%@",[array_pinyin objectAtIndex:i]];
        }
    }
    
    return placecategorey;
    
}

+(BOOL)islastpage:(int)total pagenumber:(int)willshangchuanpage{
    BOOL islastpage;
    if (total%20==0)
    {
        if (willshangchuanpage>(total/20))
        {
            NSLog(@"应该返回no");
            islastpage=NO;
        }else{
            islastpage=YES;
            NSLog(@"应该返回yes");
            
        }
    }else{
        if (willshangchuanpage>((total/20)+1)) {
            islastpage=NO;
            NSLog(@"应该返回no");
        }else{
            islastpage=YES;
            NSLog(@"应该返回yes");
            
        }
    }
    return islastpage;
}
+(BOOL)isiphone5
{
    BOOL is5;
    CGRect frame = [UIScreen mainScreen].bounds;
    NSInteger height = (NSInteger)frame.size.height;
    if (height%568 == 0)
    {
        is5=YES;
    }else
    {
        is5=NO;
    }
    return is5;
}
+(UIFont*)commentcount:(NSString *)string_count
{
    UIFont *fount_;
    int mm=[string_count integerValue];
    if (mm<100&&mm>0)
    {
        fount_=[UIFont systemFontOfSize:17];
    }else if (mm>100&&mm<1000)
    {
        fount_=[UIFont systemFontOfSize:15];
    }else
    {
        fount_=[UIFont systemFontOfSize:12];
    }
    return fount_;
}
+(UIImage *)getImageWithName:(NSString *)imageName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage * aImage = [UIImage imageWithContentsOfFile:path];
    return aImage;
}

//给数组降序
+(NSArray *)DownKeys:(NSArray *)array
{
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    NSArray *arr1 = [array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    return arr1;
}


//内容特殊字符处理包括图片
+(NSMutableString * )cutStr:(NSString*)content withArray:(NSMutableArray *)array
{
    content = [content stringByReplacingOccurrencesOfString:@"<<" withString:@" "];
    
    content = [content stringByReplacingOccurrencesOfString:@">>" withString:@" "];
    NSMutableString *astring = [[NSMutableString alloc] initWithString:content];
    //删除标签
    
    NSMutableArray * temp_array = [NSMutableArray arrayWithArray:array];
    
    while ([astring rangeOfString:@"<img"].length != 0)
    {
        NSRange range1 = [astring rangeOfString:@"<img"];
        
        NSString * string = [astring substringFromIndex:range1.location];
        
        NSRange range2 = [string rangeOfString:@">"];
        
        BOOL isReplace = NO;
        
        for (int i = 0;i < temp_array.count;i++)
        {
            NSString * face = [temp_array objectAtIndex:i];
            NSString * mafan = [NSString stringWithString:astring];
            
            if ([string rangeOfString:face].length)
            {
                NSString * theString = [string substringToIndex:range2.location+1];
                mafan = [mafan stringByReplacingOccurrencesOfString:theString withString:face];
                isReplace = YES;
                astring = [NSMutableString stringWithString:mafan];
                [temp_array removeObjectAtIndex:i];
                break;
            }
        }
        
        
        
        if (!isReplace)
        {
            [astring deleteCharactersInRange:NSMakeRange(range1.location,range2.location+1)];
        }
    }
    
    //    //替换/
    //    while ([astring rangeOfString:@"/"].length!=0)
    //    {
    //        [astring replaceCharactersInRange:[astring rangeOfString:@"/"] withString:@"|"];
    //    }
    return astring;
}


//内容特殊字符处理
+(NSString*)cutStr:(NSString*)content
{
    content = [content stringByReplacingOccurrencesOfString:@"<<" withString:@" "];
    content = [content stringByReplacingOccurrencesOfString:@">>" withString:@" "];
    NSMutableString *astring = [[NSMutableString alloc] initWithString:content];
    //删除标签
    while ([astring rangeOfString:@"<"].length!=0 && [astring rangeOfString:@">"].length!=0)
    {
        NSRange range1 = [astring rangeOfString:@"<"];
        NSRange range2 = [astring rangeOfString:@">"];
        [astring deleteCharactersInRange:NSMakeRange(range1.location, range2.location-range1.location+1)];
    }
    //替换/
    while ([astring rangeOfString:@"/"].length!=0)
    {
        [astring replaceCharactersInRange:[astring rangeOfString:@"/"] withString:@"|"];
    }
    return astring;
}



//计算laebl最后一个字符的位置
+(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label font:(UIFont *)thefont
{
    CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    CGPoint lastPoint;
    
    CGSize sz = [string sizeWithFont:thefont constrainedToSize:CGSizeMake(MAXFLOAT,40)];
    
    CGSize linesSz = [string sizeWithFont:thefont constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if(sz.width <= linesSz.width) //判断是否折行
    {
        lastPoint = CGPointMake(label.frame.origin.x + sz.width,titleSize.height + 2);
    }else
    {
        lastPoint = CGPointMake(label.frame.origin.x + (int)sz.width % (int)linesSz.width,titleSize.height);
    }
    
    return lastPoint;
}


+(UIImage *)scaleToSizeWithImage:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}



//图片质量

+(UIImage *)fixOrientation:(UIImage *)aImage
{
    if (aImage == nil) {
        return nil;
    }
    
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
        {
            transform = CGAffineTransformIdentity;
            break;
        }
        case UIImageOrientationUpMirrored: //EXIF = 2
        {
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        }
        case UIImageOrientationDown: //EXIF = 3
        {
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
        case UIImageOrientationDownMirrored: //EXIF = 4
        {
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        }
        case UIImageOrientationLeftMirrored: //EXIF = 5
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationLeft: //EXIF = 6
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationRightMirrored: //EXIF = 7
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        }
        case UIImageOrientationRight: //EXIF = 8
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        }
        default:
        {
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
        }
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}




+(NSArray *)CutString:(NSString *)sender
{
    //    if ([sender rangeOfString:@"<img"].length)
    //    {
    //
    //    }
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    NSMutableArray * allFaceArray = [[NSMutableArray alloc] init];
    
    NSArray * array1 = [[NSArray alloc] init];
    
    
    array1 = [sender componentsSeparatedByString:@"face"];
    
    for (int i = 0;i < array1.count;i++)
    {
        NSString * string = [array1 objectAtIndex:i];
        if ([string rangeOfString:@".png"].length)
        {
            NSRange theRange = [string rangeOfString:@".png"];
            
            string = [NSString stringWithFormat:@"face%@.png",[string substringToIndex:theRange.location]];
            
            [allFaceArray addObject:string];
        }
    }
    
    NSMutableString * theContent = [self cutStr:sender withArray:allFaceArray];
    
    
    for (int i = 0;i < allFaceArray.count;i++)
    {
        NSString * face_string = [allFaceArray objectAtIndex:i];
        
        NSRange range = [theContent rangeOfString:face_string];
        
        NSString * temp_string = [theContent substringToIndex:range.location];
        
        if (![temp_string isEqualToString:@""] && ![temp_string isEqualToString:@" "])
        {
            [array addObject:temp_string];
        }
        
        [array addObject:face_string];
        
        
        NSString * string = [theContent substringFromIndex:[theContent rangeOfString:face_string].location+face_string.length];
        
        if (![string rangeOfString:@"face"].length && ![string isEqualToString:@""]&& ![string isEqualToString:@" "])
        {
            [array addObject:string];
        }else
        {
            theContent = [NSMutableString stringWithString:[[NSString stringWithString:theContent] substringFromIndex:range.location+face_string.length]];
        }
    }
    
    
    return array;
}
+(NSString*)strReplace:(NSString*)str
{
    
    NSString* img=str;
    img= [img stringByReplacingOccurrencesOfString:@"</T></T>" withString:@""] ;
    img= [img stringByReplacingOccurrencesOfString:@"<T><T>" withString:@""] ;
    return img;
    
}

+(NSString *)deleteSpace:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"   " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string= [string stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    return string;
}

+(int)returnHeight:(NSArray *)array
{
    int row = 0;
    
    float theWidth = 0;
    
    int num = 0;
    
    for (int i = 0;i <array.count;i++)
    {
        NSString *string_name=[array objectAtIndex:i];
        
        CGSize size = [string_name sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        
        if (30+theWidth + num*15 + size.width > 240)
        {
            theWidth = 0;
            row++;
            num = 0;
        }
        
        theWidth += size.width;
        
        num++;
        
    }
    
    
    
    return (row+1)*45+5;
}
+(void)mycategoryname:(NSString *)_name category_dic:(NSDictionary*)_dic{
    NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
    [standarduser setObject:_dic forKey:_name];
    [standarduser synchronize];
    
}
+(void)bycategoryname:(NSString *)_name myimage_dic:(NSDictionary *)_dic{
    NSString *string_imagename=[NSString stringWithFormat:@"%@img",_name];
    NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
    [standarduser setObject:_dic forKey:string_imagename];
    [standarduser synchronize];
    NSDictionary *   dic=[[NSDictionary alloc]init];
    dic=[[NSUserDefaults standardUserDefaults]objectForKey:string_imagename];
    
    NSLog(@"%stringimg==%@",__FUNCTION__,string_imagename);
    
    
}

+(NSString *)mycurrenttime{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *   timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeNow);
    return timeNow;
    
}
+(NSString*)receivemutablearray:(NSMutableArray *)_mutablearray index:(int)selectatindex{
    NSString *returnstring;
    
    
    returnstring=[_mutablearray objectAtIndex:selectatindex];
    return returnstring;
}
+(NSString *)getwanwithstring:(NSString *)stringproce{
    
    
    NSString *finalprice;
    float temp=[stringproce floatValue];
    
    
    
    temp=temp/10000;
    
    
    finalprice=[NSString stringWithFormat:@"%.2f",temp];
    
    
    
    
    return finalprice;
}
+(NSString *)getdouhaowithstring:(NSString *)stringprice{
    NSString *stringfinalprice;
    NSMutableString *stringtemp=[[NSMutableString alloc]initWithString:stringprice];
    if (stringprice.length>=7) {
        [stringtemp insertString:@"," atIndex:3];
        [stringtemp insertString:@"," atIndex:7];
        
    }
    if (stringprice.length==6) {
        [stringtemp insertString:@"," atIndex:3];
        
    }
    stringfinalprice=[NSString stringWithFormat:@"%@",stringtemp];
    
    
    
    return stringfinalprice;
    
}

+(float)celllength:(float)length lablefont:(UIFont*)font labeltext:(NSString *)text{
    CGSize constraintSize = CGSizeMake(length, MAXFLOAT);
    CGSize labelSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    return labelSize.height;
}
+(NSString *)getuidwithstring:(NSString *)stringsymbaldata{
    NSString *string_place=[stringsymbaldata substringFromIndex:4];
    NSString *   string_return=[NSString stringWithFormat:@"%d",[string_place integerValue]];
    NSLog(@"............uid====%@",string_return);
    
    
    return string_return;
}


#pragma mark-MD5加密

- (NSString *)mds:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

+(NSString *)getMyAuthkey{


    NSString *str_authkey=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    return str_authkey;


}


//
//#pragma mark--播放系统声音
//+(void)playsysy{
//    SystemSoundID pmph;
//    id sndpath = [[NSBundle mainBundle]
//                  pathForResource:@"valley"
//                  ofType:@"mp3"
//                  inDirectory:@"/"];
//    
//    CFURLRef baseURL = (__bridge_retained CFURLRef) [[NSURL alloc] initFileURLWithPath:sndpath];
//    AudioServicesCreateSystemSoundID (baseURL, &pmph);
//    AudioServicesPlaySystemSound(pmph);
//
//    
//}
@end








