//
//  NotificationInfo.h
//  FbLife
//
//  Created by 史忠坤 on 13-8-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "downloadtool.h"
@protocol NotificationInfoDelegate <NSObject>

-(void)finishloadNotificationInfo:(NSArray *)arrayinfo errcode:(NSString *)string_codeerror errordata :(NSString *)errorinfodata withUrl:(NSString *)theUrl;

-(void)failedtoloaddata;

@end
#import "downloadtool.h"
@interface NotificationInfo : NSObject<downloaddelegate>
{
    downloadtool *allnotificationtool;
    
    NSString * the_url;
}
@property(nonatomic,strong)NSMutableArray *array_info;
@property(nonatomic,strong)NSString *string_errcode;
@property(nonatomic,strong)NSString *string_errdata;
@property(assign,nonatomic)id<NotificationInfoDelegate>delegate;
-(void)startloadnotificationwithpage:(int)page pagenumber:(NSString *)pageN withUrl:(NSString *)theUrl;
-(void)stoploadnotification;

@end
