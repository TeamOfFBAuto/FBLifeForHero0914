//
//  zsnApi.m
//  FbLife
//
//  Created by soulnear on 13-4-2.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "zsnApi.h"
#include "sys/stat.h"
#include <dirent.h>
#import "FbFeed.h"
#import "Extension.h"
#import "FbNewsFeed.h"
#import "PhotoFeed.h"
#import "BlogFeed.h"


@implementation ZSNButton
@synthesize myDictionary = _myDictionary;


@end




@implementation zsnApi





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

+(NSString *)timechange1:(NSString *)placetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[placetime doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


+(NSString *)timeFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}


///输入的日期字符串形如：@"1992-05-21 13:08:08"
#pragma mark - 输入日期字符串如："1992-05-21 13:08:08" 返回NSDate
+(NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    dateFormatter = nil;
    return destDate;
}

#pragma mark - 返回时间 年、月、日、时、分、秒
+(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    dateFormatter = nil;
    return destDateString;
}



//获取文件大小
+(NSString *) fileSizeAtPath:(NSString*) filePath
{
    int sizez_b = (int)[self _folderSizeAtPath:[filePath cStringUsingEncoding:NSUTF8StringEncoding]]/10240;
    
    if (sizez_b < 1024)
    {
        return [NSString stringWithFormat:@"%dK",sizez_b];
    }else if (sizez_b < 1024*1024 && sizez_b >= 1024)
    {
        return [NSString stringWithFormat:@"%.1fM",sizez_b/1024.0];
    }else
    {
        return [NSString stringWithFormat:@"%.2fG",sizez_b/1048576.0];
    }
}


+ (long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}



+ (NSString*)imgreplace:(NSString*)imgSrc
{
    NSString* img=imgSrc;
    img= [img stringByReplacingOccurrencesOfString:@"[发呆]" withString:@"<img src=\"bundle://face1.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[无奈]" withString:@"<img src=\"bundle://face2.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[坏笑]" withString:@"<img src=\"bundle://face3.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[撇嘴]" withString:@"<img src=\"bundle://face4.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[可爱]" withString:@"<img src=\"bundle://face5.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[得意]" withString:@"<img src=\"bundle://face6.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[晕]" withString:@"<img src=\"bundle://face7.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大哭]" withString:@"<img src=\"bundle://face8.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[衰]" withString:@"<img src=\"bundle://face9.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难过]" withString:@"<img src=\"bundle://face10.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[微笑]" withString:@"<img src=\"bundle://face11.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[傻笑]" withString:@"<img src=\"bundle://face12.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[愤怒]" withString:@"<img src=\"bundle://face13.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[酷]" withString:@"<img src=\"bundle://face14.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[汗]" withString:@"<img src=\"bundle://face15.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[惊讶]" withString:@"<img src=\"bundle://face16.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鼻涕]" withString:@"<img src=\"bundle://face17.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[美女]" withString:@"<img src=\"bundle://face18.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[帅哥]" withString:@"<img src=\"bundle://face19.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[流泪]" withString:@"<img src=\"bundle://face20.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[囧]" withString:@"<img src=\"bundle://face21.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[生气]" withString:@"<img src=\"bundle://face22.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雷人]" withString:@"<img src=\"bundle://face23.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吓]" withString:@"<img src=\"bundle://face24.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大笑]" withString:@"<img src=\"bundle://face25.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吐]" withString:@"<img src=\"bundle://face26.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[尴尬]" withString:@"<img src=\"bundle://face27.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感动]" withString:@"<img src=\"bundle://face28.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[纠结]" withString:@"<img src=\"bundle://face29.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[宠物]" withString:@"<img src=\"bundle://face30.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[睡觉]" withString:@"<img src=\"bundle://face31.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[奋斗]" withString:@"<img src=\"bundle://face32.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[左哼]" withString:@"<img src=\"bundle://face33.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[右哼]" withString:@"<img src=\"bundle://face34.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[崩溃]" withString:@"<img src=\"bundle://face35.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face36.png\" width=\"20\" height=\"23\"/>" withString:@"[委屈]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[疑问]" withString:@"<img src=\"bundle://face37.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[太棒了]" withString:@"<img src=\"bundle://face38.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鄙视]" withString:@"<img src=\"bundle://face39.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[打哈欠]" withString:@"<img src=\"bundle://face40.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[无语]" withString:@"<img src=\"bundle://face41.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[亲亲]" withString:@"<img src=\"bundle://face42.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[恐惧]" withString:@"<img src=\"bundle://face43.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[骷髅]" withString:@"<img src=\"bundle://face44.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[俏皮]" withString:@"<img src=\"bundle://face45.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[爱财]" withString:@"<img src=\"bundle://face46.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[海盗]" withString:@"<img src=\"bundle://face47.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难受]" withString:@"<img src=\"bundle://face48.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[思考]" withString:@"<img src=\"bundle://face49.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感冒]" withString:@"<img src=\"bundle://face50.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[闭嘴]" withString:@"<img src=\"bundle://face51.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[菜刀]" withString:@"<img src=\"bundle://face52.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[礼物]" withString:@"<img src=\"bundle://face53.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[药水]" withString:@"<img src=\"bundle://face54.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雨天]" withString:@"<img src=\"bundle://face55.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[砸]" withString:@"<img src=\"bundle://face56.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[炸弹]" withString:@"<img src=\"bundle://face57.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[胜利]" withString:@"<img src=\"bundle://face58.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[发飙]" withString:@"<img src=\"bundle://face59.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[喜欢]" withString:@"<img src=\"bundle://face60.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[不错]" withString:@"<img src=\"bundle://face61.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大爱]" withString:@"<img src=\"bundle://face62.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[仰慕]" withString:@"<img src=\"bundle://face63.png\" width=\"20\" height=\"23\"/>"] ;
    
    //替换回车占位符
    img= [img stringByReplacingOccurrencesOfString:@"\n" withString:@" "] ;
    img= [img stringByReplacingOccurrencesOfString:@"\r" withString:@" "] ;
    
    //替换  &  这个符号
    img= [img stringByReplacingOccurrencesOfString:@"&" withString:@" "] ;
    return img;
}



+ (NSString*)Eximgreplace:(NSString*)imgSrc
{
    NSString* img=imgSrc;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face1.png\" width=\"20\" height=\"23\"/>" withString:@"[发呆]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face2.png\" width=\"20\" height=\"23\"/>" withString:@"[无奈]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face3.png\" width=\"20\" height=\"23\"/>" withString:@"[坏笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face4.png\" width=\"20\" height=\"23\"/>" withString:@"[撇嘴]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face5.png\" width=\"20\" height=\"23\"/>" withString:@"[可爱]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face6.png\" width=\"20\" height=\"23\"/>" withString:@"[得意]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face7.png\" width=\"20\" height=\"23\"/>" withString:@"[晕]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face8.png\" width=\"20\" height=\"23\"/>" withString:@"[大哭]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face9.png\" width=\"20\" height=\"23\"/>" withString:@"[衰]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face10.png\" width=\"20\" height=\"23\"/>" withString:@"[难过]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face11.png\" width=\"20\" height=\"23\"/>" withString:@"[微笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face12.png\" width=\"20\" height=\"23\"/>" withString:@"[傻笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face13.png\" width=\"20\" height=\"23\"/>" withString:@"[愤怒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face14.png\" width=\"20\" height=\"23\"/>" withString:@"[酷]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face15.png\" width=\"20\" height=\"23\"/>" withString:@"[汗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face16.png\" width=\"20\" height=\"23\"/>" withString:@"[惊讶]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face17.png\" width=\"20\" height=\"23\"/>" withString:@"[鼻涕]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face18.png\" width=\"20\" height=\"23\"/>" withString:@"[美女]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face19.png\" width=\"20\" height=\"23\"/>" withString:@"[帅哥]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face20.png\" width=\"20\" height=\"23\"/>" withString:@"[流泪]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face21.png\" width=\"20\" height=\"23\"/>" withString:@"[囧]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face22.png\" width=\"20\" height=\"23\"/>" withString:@"[生气]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face23.png\" width=\"20\" height=\"23\"/>" withString:@"[雷人]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face24.png\" width=\"20\" height=\"23\"/>" withString:@"[吓]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face25.png\" width=\"20\" height=\"23\"/>" withString:@"[大笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face26.png\" width=\"20\" height=\"23\"/>" withString:@"[吐]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face27.png\" width=\"20\" height=\"23\"/>" withString:@"[尴尬]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face28.png\" width=\"20\" height=\"23\"/>" withString:@"[感动]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face29.png\" width=\"20\" height=\"23\"/>" withString:@"[纠结]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face30.png\" width=\"20\" height=\"23\"/>" withString:@"[宠物]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face31.png\" width=\"20\" height=\"23\"/>" withString:@"[睡觉]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face32.png\" width=\"20\" height=\"23\"/>" withString:@"[奋斗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face33.png\" width=\"20\" height=\"23\"/>" withString:@"[左哼]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face34.png\" width=\"20\" height=\"23\"/>" withString:@"[右哼]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face35.png\" width=\"20\" height=\"23\"/>" withString:@"[崩溃]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[委屈]" withString:@"<img src=\"bundle://face36.png\" width=\"20\" height=\"23\"/>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face37.png\" width=\"20\" height=\"23\"/>" withString:@"[疑问]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face38.png\" width=\"20\" height=\"23\"/>" withString:@"[太棒了]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face39.png\" width=\"20\" height=\"23\"/>" withString:@"[鄙视]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face40.png\" width=\"20\" height=\"23\"/>" withString:@"[打哈欠]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face41.png\" width=\"20\" height=\"23\"/>" withString:@"[无语]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face42.png\" width=\"20\" height=\"23\"/>" withString:@"[亲亲]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face43.png\" width=\"20\" height=\"23\"/>" withString:@"[恐惧]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face44.png\" width=\"20\" height=\"23\"/>" withString:@"[骷髅]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face45.png\" width=\"20\" height=\"23\"/>" withString:@"[俏皮]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face46.png\" width=\"20\" height=\"23\"/>" withString:@"[爱财]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face47.png\" width=\"20\" height=\"23\"/>" withString:@"[海盗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face48.png\" width=\"20\" height=\"23\"/>" withString:@"[难受]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face49.png\" width=\"20\" height=\"23\"/>" withString:@"[思考]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face50.png\" width=\"20\" height=\"23\"/>" withString:@"[感冒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face51.png\" width=\"20\" height=\"23\"/>" withString:@"[闭嘴]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face52.png\" width=\"20\" height=\"23\"/>" withString:@"[菜刀]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face53.png\" width=\"20\" height=\"23\"/>" withString:@"[礼物]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face54.png\" width=\"20\" height=\"23\"/>" withString:@"[药水]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face55.png\" width=\"20\" height=\"23\"/>" withString:@"[雨天]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face56.png\" width=\"20\" height=\"23\"/>" withString:@"[砸]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face57.png\" width=\"20\" height=\"23\"/>" withString:@"[炸弹]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face58.png\" width=\"20\" height=\"23\"/>" withString:@"[胜利]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face59.png\" width=\"20\" height=\"23\"/>" withString:@"[发飙]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face60.png\" width=\"20\" height=\"23\"/>" withString:@"[喜欢]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face61.png\" width=\"20\" height=\"23\"/>" withString:@"[不错]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face62.png\" width=\"20\" height=\"23\"/>" withString:@"[大爱]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"bundle://face63.png\" width=\"20\" height=\"23\"/>" withString:@"[仰慕]"] ;
    
    //替换回车占位符
    img= [img stringByReplacingOccurrencesOfString:@"\n" withString:@" "] ;
    img= [img stringByReplacingOccurrencesOfString:@"\r" withString:@" "] ;
    
    //替换  &  这个符号
    img= [img stringByReplacingOccurrencesOfString:@"&" withString:@" "] ;
    return img;
}




+(NSString *)exchangeString:(NSString *)string
{
    NSString * font_string = @"";

    if ([string rangeOfString:@"<a id=\""].location != 0)
    {
        font_string = [string substringToIndex:[string rangeOfString:@"<a id=\""].location];
    }
    
    
    NSString * temp_string = [string substringFromIndex:[string rangeOfString:@"<a id=\""].location+7];
    
    NSString * the_id = [temp_string substringToIndex:[temp_string rangeOfString:@"\""].location];
    
    temp_string = [temp_string substringFromIndex:[temp_string rangeOfString:@">"].location + 1];
    
    return [NSString stringWithFormat:@"%@<a href=\"fb://PhotoDetail/id=%@\">%@",font_string,the_id,temp_string];
}


+ (float)theHeight:(NSString *)content withHeight:(CGFloat)theheight WidthFont:(UIFont *)font
{
    return 0;
}

+(NSString *)exchangeFrom:(NSString *)from
{
    NSString * theFrom;
    
    if ([from isEqualToString:@"iphone"])
    {
        theFrom = @"iPhone";
    }else if ([from isEqualToString:@"web"])
    {
        theFrom = @"网页";
    }else if ([from isEqualToString:@"bbs"])
    {
        theFrom = @"论坛";
    }else if([from isEqualToString:@"news"])
    {
        theFrom = @"新闻";
    }else if ([from isEqualToString:@"android"])
    {
        theFrom = @"安卓";
    }
    
    return [NSString stringWithFormat:@"来自 %@",theFrom];
}


+(UIImage *)fitSmallImage:(UIImage *)image withSize:(CGSize)theSize
{
    if (nil == image)
    {
        return nil;
    }
    if (image.size.width<100 && image.size.height<100)
    {
        return image;
    }
    UIGraphicsBeginImageContext(theSize);
    CGRect rect = CGRectMake(0, 0, theSize.width, theSize.height);
    [image drawInRect:rect];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newing;
}





+(NSString *)returnUrl:(NSString *)theUrl
{
    NSString * uid = theUrl;
    
    if (uid.length !=0 && uid.length < 9)
    {
        for (int i = 0;i < uid.length -9;i++)
        {
            uid = [NSString stringWithFormat:@"%d%@",0,uid];
        }
    }
    
    NSString * string;
    if (uid.length ==0)
    {
        string = @"";
    }else
    {
        string =  [NSString stringWithFormat:@"http://avatar.fblife.com/%@/%@/%@/%@_avatar_small.jpg",[[uid substringToIndex:3] substringFromIndex:0],[[uid substringToIndex:5] substringFromIndex:3],[[uid substringToIndex:7] substringFromIndex:5],[[uid substringToIndex:9] substringFromIndex:7]];
    }
    
    return string;
}


+(NSArray *)stringExchange:(NSString *)string
{
    while ([string rangeOfString:@"[b]"].length || [string rangeOfString:@"[/b]"].length || [string rangeOfString:@"[i]"].length || [string rangeOfString:@"[/i]"].length || [string rangeOfString:@"[u]"].length || [string rangeOfString:@"[/u]"].length||[string rangeOfString:@"&nbsp;"].length)
    {
        string = [string stringByReplacingOccurrencesOfString:@"[b]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[/b]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[i]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[/i]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[u]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[/u]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        
    }
    
    while ([string rangeOfString:@"\r"].length)
    {
        NSLog(@"去掉r");
        string = [string stringByReplacingOccurrencesOfString: @"\r" withString:@""];
    }
    
    
    string = [string stringByReplacingOccurrencesOfString:@"[/img]" withString:@"[/img]|@|"];
    
    
    string = [string stringByReplacingOccurrencesOfString:@"[img]" withString:@"|@|[img]"];
    
    NSArray * arr = [string componentsSeparatedByString:@"|@|"];
    
    return arr;
}






+(float)calculateheight:(NSArray *)array
{
    
    float height = 0.0;
    for (NSString * string in array)
    {
        if (string.length > 0)
        {
            if ([string rangeOfString:@"[img]"].length && [string rangeOfString:@"[/img]"].length)
            {
                height += 90;
                
            }else
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,50)];
                CGPoint point = [personal LinesWidth:string Label:label font:[UIFont systemFontOfSize:16]];
                
                height += point.y;
            }
        }
    }
    return height;
}

+ (NSString*)FBImageChange:(NSString*)imgSrc
{
    NSString* img=imgSrc;
    img= [img stringByReplacingOccurrencesOfString:@"[发呆]" withString:@"<img src=\"face1.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[无奈]" withString:@"<img src=\"face2.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[坏笑]" withString:@"<img src=\"face3.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[撇嘴]" withString:@"<img src=\"face4.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[可爱]" withString:@"<img src=\"face5.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[得意]" withString:@"<img src=\"face6.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[晕]" withString:@"<img src=\"face7.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大哭]" withString:@"<img src=\"face8.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[衰]" withString:@"<img src=\"face9.png\">  </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难过]" withString:@"<img src=\"face10.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[微笑]" withString:@"<img src=\"face11.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[傻笑]" withString:@"<img src=\"face12.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[愤怒]" withString:@"<img src=\"face13.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[酷]" withString:@"<img src=\"face14.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[汗]" withString:@"<img src=\"face15.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[惊讶]" withString:@"<img src=\"face16.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鼻涕]" withString:@"<img src=\"face17.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[美女]" withString:@"<img src=\"face18.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[帅哥]" withString:@"<img src=\"face19.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[流泪]" withString:@"<img src=\"face20.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[囧]" withString:@"<img src=\"face21.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[生气]" withString:@"<img src=\"face22.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雷人]" withString:@"<img src=\"face23.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吓]" withString:@"<img src=\"face24.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大笑]" withString:@"<img src=\"face25.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吐]" withString:@"<img src=\"face26.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[尴尬]" withString:@"<img src=\"face27.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感动]" withString:@"<img src=\"face28.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[纠结]" withString:@"<img src=\"face29.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[宠物]" withString:@"<img src=\"face30.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[睡觉]" withString:@"<img src=\"face31.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[奋斗]" withString:@"<img src=\"face32.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[左哼]" withString:@"<img src=\"face33.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[右哼]" withString:@"<img src=\"face34.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[崩溃]" withString:@"<img src=\"face35.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[委屈]" withString:@"<img src=\"face36.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[疑问]" withString:@"<img src=\"face37.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[太棒了]" withString:@"<img src=\"face38.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鄙视]" withString:@"<img src=\"face39.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[打哈欠]" withString:@"<img src=\"face40.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[无语]" withString:@"<img src=\"face41.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[亲亲]" withString:@"<img src=\"face42.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[恐惧]" withString:@"<img src=\"face43.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[骷髅]" withString:@"<img src=\"face44.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[俏皮]" withString:@"<img src=\"face45.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[爱财]" withString:@"<img src=\"face46.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[海盗]" withString:@"<img src=\"face47.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难受]" withString:@"<img src=\"face48.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[思考]" withString:@"<img src=\"face49.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感冒]" withString:@"<img src=\"face50.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[闭嘴]" withString:@"<img src=\"face51.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[菜刀]" withString:@"<img src=\"face52.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[礼物]" withString:@"<img src=\"face53.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[药水]" withString:@"<img src=\"face54.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雨天]" withString:@"<img src=\"face55.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[砸]" withString:@"<img src=\"face56.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[炸弹]" withString:@"<img src=\"face57.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[胜利]" withString:@"<img src=\"face58.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[发飙]" withString:@"<img src=\"face59.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[喜欢]" withString:@"<img src=\"face60.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[不错]" withString:@"<img src=\"face61.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大爱]" withString:@"<img src=\"face62.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[仰慕]" withString:@"<img src=\"face63.png\">    </img>"] ;
    //替换回车占位符
    img= [img stringByReplacingOccurrencesOfString:@"\n" withString:@" "] ;
    img= [img stringByReplacingOccurrencesOfString:@"\r" withString:@" "] ;
    //替换  &  这个符号
    img= [img stringByReplacingOccurrencesOfString:@"&" withString:@" "] ;
    return img;
}


+ (NSString*)FBEximgreplace:(NSString*)imgSrc
{
    NSString* img=imgSrc;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face1.png\">    </img>" withString:@"[发呆]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face2.png\">    </img>" withString:@"[无奈]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face3.png\">    </img>" withString:@"[坏笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face4.png\">    </img>" withString:@"[撇嘴]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face5.png\">    </img>" withString:@"[可爱]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face6.png\">    </img>" withString:@"[得意]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face7.png\">    </img>" withString:@"[晕]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face8.png\">    </img>" withString:@"[大哭]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face9.png\">    </img>" withString:@"[衰]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face10.png\">    </img>" withString:@"[难过]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face11.png\">    </img>" withString:@"[微笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face12.png\">    </img>" withString:@"[傻笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face13.png\">    </img>" withString:@"[愤怒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face14.png\">    </img>" withString:@"[酷]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face15.png\">    </img>" withString:@"[汗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face16.png\">    </img>" withString:@"[惊讶]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face17.png\">    </img>" withString:@"[鼻涕]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face18.png\">    </img>" withString:@"[美女]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face19.png\">    </img>" withString:@"[帅哥]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face20.png\">    </img>" withString:@"[流泪]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face21.png\">    </img>" withString:@"[囧]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face22.png\">    </img>" withString:@"[生气]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face23.png\">    </img>" withString:@"[雷人]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face24.png\">    </img>" withString:@"[吓]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face25.png\">    </img>" withString:@"[大笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face26.png\">    </img>" withString:@"[吐]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face27.png\">    </img>" withString:@"[尴尬]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face28.png\">    </img>" withString:@"[感动]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face29.png\">    </img>" withString:@"[纠结]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face30.png\">    </img>" withString:@"[宠物]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face31.png\">    </img>" withString:@"[睡觉]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face32.png\">    </img>" withString:@"[奋斗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face33.png\">    </img>" withString:@"[左哼]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face34.png\">    </img>" withString:@"[右哼]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face35.png\">    </img>" withString:@"[崩溃]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face36.png\">    </img>" withString:@"[委屈]"];
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face37.png\">    </img>" withString:@"[疑问]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face38.png\">    </img>" withString:@"[太棒了]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face39.png\">    </img>" withString:@"[鄙视]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face40.png\">    </img>" withString:@"[打哈欠]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face41.png\">    </img>" withString:@"[无语]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face42.png\">    </img>" withString:@"[亲亲]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face43.png\">    </img>" withString:@"[恐惧]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face44.png\">    </img>" withString:@"[骷髅]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face45.png\">    </img>" withString:@"[俏皮]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face46.png\">    </img>" withString:@"[爱财]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face47.png\">    </img>" withString:@"[海盗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face48.png\">    </img>" withString:@"[难受]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face49.png\">    </img>" withString:@"[思考]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face50.png\">    </img>" withString:@"[感冒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face51.png\">    </img>" withString:@"[闭嘴]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face52.png\">    </img>" withString:@"[菜刀]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face53.png\">    </img>" withString:@"[礼物]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face54.png\">    </img>" withString:@"[药水]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face55.png\">    </img>" withString:@"[雨天]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face56.png\">    </img>" withString:@"[砸]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face57.png\">    </img>" withString:@"[炸弹]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face58.png\">    </img>" withString:@"[胜利]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face59.png\">    </img>" withString:@"[发飙]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face60.png\">    </img>" withString:@"[喜欢]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face61.png\">    </img>" withString:@"[不错]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face62.png\">    </img>" withString:@"[大爱]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face63.png\">    </img>" withString:@"[仰慕]"] ;
    
    //替换回车占位符
    img= [img stringByReplacingOccurrencesOfString:@"\n" withString:@" "] ;
    img= [img stringByReplacingOccurrencesOfString:@"\r" withString:@" "] ;
    
    //替换  &  这个符号
    img= [img stringByReplacingOccurrencesOfString:@"&" withString:@" "] ;
    return img;
}




+(NSMutableArray *)conversionFBContent:(NSDictionary *)userinfo isSave:(BOOL)isSave WithType:(int)theType
{
    NSMutableArray * data_array = [[NSMutableArray alloc] init];
    
    NSArray *keys;
    int i, count;
    id key, value;
    keys = [userinfo allKeys];
    
    //给keys排序降序
    NSMutableArray *arr11 = [[NSMutableArray alloc]init];
    for (int i=0; i<keys.count; i++)
    {
        [arr11 addObject:[NSNumber numberWithInt:[[keys objectAtIndex: i] intValue]]];
    }
    
    NSArray * arr1 = [NSArray arrayWithArray:arr11];
    arr1=  [ arr1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
            {
                return [obj2 compare:obj1];
            } ];
    
    count = [arr1 count];
    
    
    
    for (i = 0; i < count; i++)
    {
        FbFeed *obj = [[FbFeed alloc] init];
        
        key = [NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]];
        
        value = [userinfo objectForKey:key];
        
        
        //解析微博内容
        obj.photo_title = @"";
        [obj setTid:[value objectForKey:FB_TID]];
        [obj setUid:[value objectForKey:FB_UID]];
        [obj setUserName:[value objectForKey:FB_USERNAME]];
        [obj setContent: [self FBImageChange:[value objectForKey:FB_CONTENT]]];
        
        if ([[value objectForKey:FB_IMAGEID] isEqualToString:@"0"])
        {
            [obj setNsImageFlg:@"0"];
        }else
        {
            [obj setNsImageFlg:@"1"];
        }
        
        obj.image_original_url_m = [value objectForKey:@"image_original_m"];
        
        obj.image_small_url_m = [value objectForKey:@"image_small_m"];
        
        //是否有图片
        if ([obj imageFlg])
        {
            [obj setImage_original_url:[value objectForKey:FB_IMAGE_ORIGINAL]];
            [obj setImage_small_url:[value objectForKey:FB_IMAGE_SMALL]];
        }
        
        [obj setFrom:[zsnApi exchangeFrom:[value objectForKey:FB_FROM]]];
        [obj setNsType:[value objectForKey:FB_TYPE]];
        obj.sort = [value objectForKey:FB_SORT];
        obj.sortId = [value objectForKey:FB_SORTID];
        
        [obj setMusicurl:[NSString stringWithFormat:@"%@",[value objectForKey:@"musicurl"]]];
        
        if ([obj.musicurl isEqual:[NSNull null]] || [obj.musicurl isEqualToString:@"(null)"] || obj.musicurl.length == 0 || [obj.musicurl isEqualToString:@"<null>"])
        {
            [obj setMusicurl:@""];
        }
        
        [obj setOlink:[NSString stringWithFormat:@"%@",[value objectForKey:@"videolink"]]];
        
        if ([obj.olink isEqual:[NSNull null]] || [obj.olink isEqualToString:@"(null)"] || obj.olink.length == 0 || [obj.olink isEqualToString:@"<null>"])
        {
            [obj setOlink:@""];
        }
        
        
        
        [obj setJing_lng:[value objectForKey:FB_JING_LNG]];
        [obj setWei_lat:[value objectForKey:FB_WEI_LAT]];
        [obj setLocality:[value objectForKey:FB_LOCALITY]];
        [obj setFace_original_url:[value objectForKey:FB_FACE_ORIGINAL]];
        [obj setFace_small_url:[value objectForKey:FB_FACE_SMALL]];
        [obj setNsRootFlg:[value objectForKey:FB_ROOTTID]];
        [obj setDateline:[value objectForKey:FB_DATELINE]];//[personal timestamp:[value objectForKey:FB_DATELINE]]];
        [obj setReplys:[value objectForKey:FB_REPLYS]];
        [obj setForwards:[value objectForKey:FB_FORWARDS]];
        [obj setRootFlg:NO];
        
        //解析其他类型
        
        if([obj.sort isEqualToString:@"3"]&&[obj.type isEqualToString:@"first"])
        {
            //解析图集
            NSDictionary *photojson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
            
            PhotoFeed * photo=[[PhotoFeed alloc]initWithJson:photojson];
            
            [obj setPhoto:photo];
            
            obj.content = [NSString stringWithFormat:@"<a href=\"fb://PhotoDetail/%@\">%@</a>",photo.aid,photo.title];
            
            obj.photo_title = photo.title;
            
            [obj setImageFlg:YES];
            
            [obj setImage_small_url_m: photo.image_string];
            
            [obj setImage_original_url_m:photo.image_string];
            
        }else if([obj.sort isEqualToString:@"2"]&&[obj.type isEqualToString:@"first"])
        {
            //解析文集
            NSDictionary *blogjson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
            
            BlogFeed * blog=[[BlogFeed alloc]initWithJson:blogjson];
            
            [obj setBlog:blog];
            
            obj.title_content = [NSString stringWithFormat:@"<a href=\"fb://BlogDetail/%@\">%@</a>",blog.blogid,blog.title];
            
            obj.content = blog.content;
            
            obj.photo_title = blog.title;
            
            [obj setImageFlg:blog.photoFlg];
            
            if (blog.photoFlg)
            {
                [obj setImage_small_url_m:blog.photo];
                [obj setImage_original_url_m:blog.photo];
            }
            
            
        }else if([obj.sort isEqualToString:@"4"]&&[obj.type isEqualToString:@"first"])
        {
            //论坛帖子转发为微博
            NSDictionary * newsForwoadjson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
            
            FbNewsFeed * fbnews= [[FbNewsFeed alloc] initWithJson:newsForwoadjson];
            
            [obj setFbNews:fbnews];
            
            
            obj.title_content = [NSString stringWithFormat:@"<a href=\"fb://tieziDetail/%@/%@\">%@</a>",fbnews.bbsid,fbnews.bbsid,fbnews.title];
            
            obj.content = fbnews.content;
            
            obj.photo_title = fbnews.title;
            
            [obj setImageFlg:fbnews.photoFlg];
            
            if (fbnews.photoFlg)
            {
                [obj setImage_small_url_m:fbnews.photo];
                [obj setImage_original_url_m:fbnews.photo];
            }
            
        }else if([obj.sort isEqualToString:@"5"]&&[obj.type isEqualToString:@"first"])
        {
            //论坛分享
            NSDictionary *newsSendjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
            
            Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
            
            [obj setExten:ex];
            
            [obj setRootFlg:YES];
            
            
            obj.rtitle_content = [NSString stringWithFormat:@"<a href=\"fb://atSomeone@/%@\">@%@</a>:<a href=\"fb://BlogDetail/%@\">%@</a>",ex.authorid,ex.author,ex.authorid,ex.title];
            
            obj.rcontent = ex.forum_content;
            
            obj.photo_title = ex.title;
            
            [obj setSort:@"0"];
            
            [obj setRsort:@"5"];
            [obj setRsortId:ex.authorid];
            [obj setRimageFlg:ex.photoFlg];
            [obj setRimage_small_url_m:ex.photo];
            [obj setRimage_original_url_m:ex.photo];
        }else if (([obj.sort isEqualToString:@"8"] || [obj.sort isEqualToString:@"7"] || [obj.sort isEqualToString:@"6"])&&[obj.type isEqualToString:@"first"])
        {
            NSDictionary *exjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
            Extension * ex=[[Extension alloc]initWithJson:exjson];
            [obj setExten:ex];
            
            obj.rsort = obj.sort;
            
            obj.rsortId = obj.sortId;
            
            obj.sort = @"0";
            
            obj.rootFlg = YES;
            
            [obj setRimageFlg:ex.photoFlg];
            
            [obj setRimage_small_url_m:ex.photo];
            
            [obj setRimage_original_url_m:ex.photo];
            
            obj.rtitle_content = [NSString  stringWithFormat:@"<a href=\"fb.news://PhotoDetail/id=%@/sort=%@\">%@</a>",obj.sortId,obj.sort,ex.title];
            
            obj.rcontent = [exjson objectForKey:@"intro"];
            
            obj.photo_title = ex.title;
            
        }else if([obj.sort isEqualToString:@"10"]&&[obj.type isEqualToString:@"first"])
        {
            //资源分享
            NSDictionary *newsSendjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
            
            Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
            
            [obj setExten:ex];
            
            [obj setRootFlg:YES];
            
            obj.sort = @"0";
            
            [obj setRcontent:[zsnApi ShareResourceContent:ex.forum_content]];
            
            [obj setRsort:@"10"];
            
            [obj setRsortId:ex.authorid];
            
            [obj setRimageFlg:ex.photoFlg];
            
            [obj setRimage_small_url_m:[NSString stringWithFormat:@"http://fb.cn%@",ex.photo]];
            
            [obj setRimage_original_url_m:[NSString stringWithFormat:@"http://fb.cn%@",ex.photo]];
        }else if (([obj.sort isEqualToString:@"9"]&&[obj.type isEqualToString:@"first"]))
        {
            //商城分享
            NSDictionary *newsSendjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
            
            Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
            
            [obj setExten:ex];
            
            [obj setRootFlg:YES];
            
            obj.sort = @"0";
            
            obj.rtitle_content = [NSString stringWithFormat:@"<a href=\"fb://shareshop\">%@</a>",[zsnApi ShareResourceContent:ex.title]];
            
            obj.photo_title = ex.title;
            
            [obj setRsort:@"9"];
            
            [obj setRsortId:ex.authorid];
            
            [obj setRimageFlg:ex.photoFlg];
            
            [obj setRimage_small_url_m:ex.photo];
            
            [obj setRimage_original_url_m:ex.photo];
        }else if ([obj.sort isEqualToString:@"15"]&&[obj.type isEqualToString:@"first"])
        {
            NSDictionary * atlas_dic = [[value objectForKey:FB_EXTENSION] objectFromJSONString];
            
            NSString * title = [zsnApi exchangeStringForDeleteNULL:[atlas_dic objectForKey:@"title"]];
            
            NSString * photo = [zsnApi exchangeStringForDeleteNULL:[atlas_dic objectForKey:@"photo"]];
            
            NSString * intro = [zsnApi exchangeStringForDeleteNULL:[atlas_dic objectForKey:@"intro"]];
            
            obj.sort = @"0";
            
            obj.rootFlg = YES;
            
            obj.rsort = @"15";
            
            obj.rsortId = obj.sortId;
            
            if (photo.length > 0)
            {
                obj.rimageFlg = YES;
                
                obj.rimage_original_url_m = photo;
                
                obj.rimage_small_url_m = photo;
            }
            
            if (title.length > 0)
            {
                obj.rtitle_content = [NSString stringWithFormat:@"<a href=\"fb://tieziDetail/%@/%@\">%@</a>",obj.sortId,obj.sortId,title];
            }
            
            obj.rcontent = intro;
            
            
            
            
                        
        }
        
        
        while ([obj.content rangeOfString:@"&nbsp;"].length)
        {
            obj.content = [obj.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        }
        
        
        
        NSMutableString * tempString = [NSMutableString stringWithFormat:@"%@",obj.content];
        
        if ([tempString rangeOfString:@"<a>#"].length)
        {
            NSString * insertString = [NSString stringWithFormat:@"href=\"fb://BlogDetail/%@\"",obj.tid];
            [tempString insertString:insertString atIndex:[obj.content rangeOfString:@"<a>#"].location+2];
            obj.content = [NSString stringWithString:tempString];
        }
        
        
        while ([obj.content rangeOfString:@"<a id="].length)
        {
            obj.content = [zsnApi exchangeString:obj.content];
        }
        
        
        
        //解析转发内容
        if (![[value objectForKey:@"roottid"] isEqualToString:@"0"] )
        {
            [obj setRootFlg:YES];
            
            NSDictionary * followinfo= [value objectForKey:@"followinfo"];
            
            if (followinfo==nil)
            {
                //原微博已删除
                [obj setRcontent:NS_WEIBO_DEL];
            }else
            {
                //解析转发的微博内容
                [obj setRtid:[followinfo objectForKey:FB_TID]];
                [obj setRuid:[followinfo objectForKey:FB_UID]];
                [obj setRuserName:[followinfo objectForKey:FB_USERNAME]];
                
                [obj setRcontent:[ NSString stringWithFormat:@"<a href=\"fb://atSomeone@/%@\">@%@</a>:%@",obj.ruid,obj.ruserName,[zsnApi imgreplace:[followinfo objectForKey:FB_CONTENT]]]];
                
                if ([[followinfo objectForKey:FB_IMAGEID] isEqualToString:@"0"])
                {
                    [obj setRNsImageFlg:@"0"];
                }else
                {
                    [obj setRNsImageFlg:@"1"];
                }
                
                
                obj.rimage_original_url_m = [followinfo objectForKey:@"image_original_m"];
                
                obj.rimage_small_url_m = [followinfo objectForKey:@"image_small_m"];
                
                
                if ([obj rimageFlg])
                {
                    [obj setRimage_original_url:[followinfo objectForKey:FB_IMAGE_ORIGINAL]];
                    [obj setRimage_small_url:[followinfo objectForKey:FB_IMAGE_SMALL]];
                }
                [obj setRfrom:[followinfo objectForKey:FB_FROM]];
                [obj setRNsType:[followinfo objectForKey:FB_TYPE]];
                obj.rsort = [followinfo objectForKey:FB_SORT];
                obj.rsortId = [followinfo objectForKey:FB_SORTID];
                
                [obj setRmusicurl:[NSString stringWithFormat:@"%@",[followinfo objectForKey:@"musicurl"]]];
                
                if ([obj.rmusicurl isEqual:[NSNull null]] || [obj.rmusicurl isEqualToString:@"(null)"] || obj.rmusicurl.length == 0 || [obj.rmusicurl isEqualToString:@"<null>"])
                {
                    [obj setRmusicurl:@""];
                }
                
                
                
                [obj setRolink:[NSString stringWithFormat:@"%@",[followinfo objectForKey:@"videolink"]]];
                
                if ([obj.rolink isEqual:[NSNull null]] || [obj.rolink isEqualToString:@"(null)"] || obj.rolink.length == 0 || [obj.rolink isEqualToString:@"<null>"])
                {
                    [obj setRolink:@""];
                }
                
                [obj setRjing_lng:[followinfo objectForKey:FB_JING_LNG]];
                [obj setRwei_lat:[followinfo objectForKey:FB_WEI_LAT]];
                [obj setRlocality:[followinfo objectForKey:FB_LOCALITY]];
                [obj setRface_original_url:[followinfo objectForKey:FB_FACE_ORIGINAL]];
                [obj setRface_small_url:[followinfo objectForKey:FB_FACE_SMALL]];
                [obj setRNsRootFlg:[followinfo objectForKey:FB_ROOTTID]];
                [obj setRdateline:[followinfo objectForKey:FB_DATELINE]];
                [obj setRreplys:[followinfo objectForKey:FB_REPLYS]];
                [obj setRforwards:[followinfo objectForKey:FB_FORWARDS]];
                //解析其他类型
                
                if([obj.rsort isEqualToString:@"3"]&&[obj.rtype isEqualToString:@"first"])
                {
                    //解析图集
                    NSDictionary * photojson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                    
                    PhotoFeed * photo = [[PhotoFeed alloc]initWithJson:photojson];
                    
                    [obj setRphoto:photo];
                    
                    obj.rcontent = [NSString stringWithFormat:@"<a href=\"fb://atSomeone@/%@\">@%@</a>:我在图集<a href=\"fb:forwardingStyle//PhotoDetail/%@\">%@</a>上传了新图片",obj.ruid,obj.ruserName,photo.aid,photo.title];
                    
                    obj.photo_title = photo.title;
                    
                    [obj setRimageFlg:YES];
                    
                    [obj setRimage_small_url_m:photo.image_string];
                    
                    [obj setRimage_original_url_m:photo.image_string];
                    
                }else if([obj.rsort isEqualToString:@"2"]&&[obj.rtype isEqualToString:@"first"])
                {
                    //解析文集
                    NSDictionary *blogjson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                    BlogFeed * blog=[[BlogFeed alloc]initWithJson:blogjson];
                    [obj setRblog:blog];
                    obj.rtitle_content = blog.title;
                    obj.rcontent = blog.content;
                    obj.photo_title = blog.title;
                    [obj setRimageFlg:blog.photoFlg];
                    if (blog.photoFlg) {
                        [obj setRimage_small_url_m:blog.photo];
                        [obj setRimage_original_url_m:blog.photo];
                    }
                }else if([obj.rsort isEqualToString:@"4"]&&[obj.rtype isEqualToString:@"first"])
                {
                    //论坛帖子转发为微博
                    NSDictionary *newsForwoadjson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                    FbNewsFeed * fbnews=[[FbNewsFeed alloc]initWithJson:newsForwoadjson];
                    [obj setRfbNews:fbnews];
                    
                    
                    obj.rtitle_content = [NSString stringWithFormat:@"<a href=\"fb://atSomeone@/%@\">@%@</a>:<a href=\"fb:forwardingStyle//tieziDetail/%@/%@/%@/\">%@</a>",fbnews.uid,obj.ruserName,fbnews.bbsid,fbnews.title,fbnews.bbsid,fbnews.title];
                    
                    obj.rcontent = fbnews.content;
                    
                    obj.photo_title = fbnews.title;
                    
                    
                    [obj setRimageFlg:fbnews.photoFlg];
                    if (fbnews.photoFlg)
                    {
                        [obj setRimage_small_url_m:fbnews.photo];
                        
                        [obj setRimage_original_url_m:fbnews.photo];
                    }
                }else if([obj.rsort isEqualToString:@"5"]&&[obj.rtype isEqualToString:@"first"])
                {
                    //论坛分享
                    
                    NSDictionary *newsSendjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                    Extension * ex=[[Extension alloc]initWithJson:newsSendjson];
                    [obj setRexten:ex];
                    
                    obj.rtitle_content = ex.title;
                    
                    obj.rcontent = ex.forum_content;
                    
                    obj.photo_title = ex.title;
                    
                    [obj setRimageFlg:ex.photoFlg];
                    [obj setRimage_small_url_m:ex.photo];
                    [obj setRimage_original_url_m:ex.photo];
                }else if (([obj.rsort isEqualToString:@"8"] || [obj.rsort isEqualToString:@"7"] || [obj.rsort isEqualToString:@"6"])&&[obj.rtype isEqualToString:@"first"])
                {
                    NSDictionary *exjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                    Extension * ex=[[Extension alloc]initWithJson:exjson];
                    [obj setExten:ex];
                    
                    
                    [obj setRimageFlg:ex.photoFlg];
                    
                    [obj setRimage_small_url_m:ex.photo];
                    
                    [obj setRimage_original_url_m:ex.photo];
                    
                    obj.rtitle_content = [NSString  stringWithFormat:@"<a href=\"fb.news://PhotoDetail/id=%@/sort=%@\">%@</a>",obj.sortId,obj.sort,ex.title];
                    
                    obj.rcontent = [exjson objectForKey:@"intro"];
                    
                    obj.photo_title = ex.title;
                    
                }else if([obj.rsort isEqualToString:@"10"]&&[obj.rtype isEqualToString:@"first"])
                {
                    //资源分享
                    NSDictionary *newsSendjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                    
                    Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                    
                    [obj setExten:ex];
                    
                    [obj setRcontent:[zsnApi ShareResourceContent:ex.forum_content]];
                    
                    [obj setRsortId:ex.authorid];
                    
                    [obj setRimageFlg:ex.photoFlg];
                    
                    [obj setRimage_small_url_m:[NSString stringWithFormat:@"http://fb.cn%@",ex.photo]];
                    
                    [obj setRimage_original_url_m:[NSString stringWithFormat:@"http://fb.cn%@",ex.photo]];
                }else if (([obj.sort isEqualToString:@"9"]&&[obj.type isEqualToString:@"first"]))
                {
                    //商城分享
                    NSDictionary *newsSendjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                    
                    Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                    
                    [obj setExten:ex];
                    
                    obj.rtitle_content = [NSString stringWithFormat:@"<a href=\"fb://shareshop\">%@</a>",[zsnApi ShareResourceContent:ex.title]];
                    
                    obj.photo_title = ex.title;
                    
                    [obj setRsortId:ex.authorid];
                    
                    [obj setRimageFlg:ex.photoFlg];
                    
                    [obj setRimage_small_url_m:ex.photo];
                    
                    [obj setRimage_original_url_m:ex.photo];
                }
            }
        }
        
        while ([obj.rcontent rangeOfString:@"&nbsp;"].length)
        {
            obj.rcontent = [obj.rcontent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        }
        
        
        
        NSMutableString * RtempString = [NSMutableString stringWithFormat:@"%@",obj.rcontent];
        
        if ([RtempString rangeOfString:@"<a>#"].length)
        {
            NSString * insertString = [NSString stringWithFormat:@" href=\"fb:forwardingStyle//BlogDetail/%@\"",obj.rtid];
            [RtempString insertString:insertString atIndex:[obj.rcontent rangeOfString:@"<a>#"].location+2];
            obj.rcontent = [NSString stringWithString:RtempString];
        }
        
        while ([obj.rcontent rangeOfString:@"<a id="].length)
        {
            obj.rcontent = [zsnApi exchangeString:obj.rcontent];
        }
        
        
        obj.content = [obj.content stringByReplacingOccurrencesOfString:@"<a>" withString:@"<a href=\"fb://shareshop\">"];
        
        obj.rcontent = [obj.rcontent stringByReplacingOccurrencesOfString:@"<a>" withString:@"<a href=\"fb://shareshop\">"];
        
        obj.title_content = [obj.title_content stringByReplacingOccurrencesOfString:@"<a>" withString:@"<a href=\"fb://shareshop\">"];
        
        obj.rtitle_content = [obj.rtitle_content stringByReplacingOccurrencesOfString:@"<a>" withString:@"<a href=\"fb://shareshop\">"];
        
        
        obj.content = [obj.content stringByReplacingOccurrencesOfString:@"<ahref" withString:@"<a href"];
        
        obj.rcontent = [obj.rcontent stringByReplacingOccurrencesOfString:@"<ahref" withString:@"<a href"];
        
        obj.title_content = [obj.title_content stringByReplacingOccurrencesOfString:@"<ahref" withString:@"<a href"];
        
        obj.rtitle_content = [obj.rtitle_content stringByReplacingOccurrencesOfString:@"<ahref" withString:@"<a href"];
        
        
        [data_array addObject:obj];
        
        
        
        if (isSave)
        {
            int result = [FbFeed addWeiBoContentWithInfo:obj WithType:theType];
            
            NSLog(@"微博添加数据结果 ----  %d",result);
        }
        
        
    }
    
    return data_array;
    
}



+(NSString *)ShareResourceContent:(NSString *)theResource
{
    while ([theResource rangeOfString:@"&lt;"].length || [theResource rangeOfString:@"&gt;"].length)
    {
        theResource = [theResource stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        theResource = [theResource stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    }
    
    while([theResource rangeOfString:@"<b>"].length || [theResource rangeOfString:@"</b>"].length || [theResource rangeOfString:@"</br>"].length)
    {
        theResource = [theResource stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        theResource = [theResource stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        theResource = [theResource stringByReplacingOccurrencesOfString:@"</br>" withString:@"\n"];
    }
    
    theResource = [theResource stringByReplacingOccurrencesOfString:@"<a href=" withString:@"<a href=\""];
    
    theResource = [theResource stringByReplacingOccurrencesOfString:@"target=_blank" withString:@"target=_blank\""];
    
    while ([theResource rangeOfString:@"target=_blank"].length)
    {
        theResource = [theResource stringByReplacingOccurrencesOfString:@"  target=_blank" withString:@""];
    }
    
    return theResource;
}



+(float)boolLabelLength:(NSString *)strString withFont:(int)theFont wihtWidth:(float)theWidth
{
    CGSize labsize = [strString sizeWithFont:[UIFont systemFontOfSize:theFont] constrainedToSize:CGSizeMake(theWidth,9999) lineBreakMode:NSLineBreakByCharWrapping];
    return labsize.width;
}


#pragma mark-判断是否是邮箱


+(BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}



//计算laebl最后一个字符的位置
+(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label font:(UIFont *)thefont linebreak:(NSLineBreakMode)linebreak
{
    CGSize titleSize = [string sizeWithFont:thefont constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:linebreak];
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



+(NSString *)exchangeStringForDeleteNULL:(id)sender
{
    NSString * temp = [NSString stringWithFormat:@"%@",sender];
    
    if (temp.length == 0 || [temp isEqualToString:@"<null>"] || [temp isEqualToString:@"null"] || [temp isEqualToString:@"(null)"])
    {
        temp = @"";
    }
    
    return temp;
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


#pragma mark - 弹出提示框
+ (MBProgressHUD *)showMBProgressWithText:(NSString *)text addToView:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 15.f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
#pragma mark - 弹出提示框，1.5秒后消失
+ (void)showAutoHiddenMBProgressWithText:(NSString *)text addToView:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 15.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}
#pragma mark - 弹出提示框（包含标题，内容），1.5秒后消失
+(void)showautoHiddenMBProgressWithTitle:(NSString *)title WithContent:(NSString *)content addToView:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.detailsLabelText = content;
    hud.margin = 15.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}


#pragma mark - 解码特殊字符
+(NSString *)decodeSpecialCharactersString:(NSString *)input
{
    input = [input stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    input = [input stringByReplacingOccurrencesOfString:@"quot;" withString:@"\""];
    input = [input stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
    input = [input stringByReplacingOccurrencesOfString:@"&lt;" withString:@"&lt"];
    input = [input stringByReplacingOccurrencesOfString:@"&gt;" withString:@"&gt"];
    
    input = [input stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    input = [input stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    return input;
}

#pragma mark - 返回适配后的宽度
+(float)returnAutoWidthWith:(float)aWith
{
    return aWith*DEVICE_WIDTH/320;
}
#pragma mark - 返回适配后的高度
+(float)returnAutoHeightWith:(float)aHeight WithWidth:(float)aWidth
{
    return aHeight*(aWidth*DEVICE_WIDTH/320)/aWidth;
}

@end













