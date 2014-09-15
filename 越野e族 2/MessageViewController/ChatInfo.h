//
//  ChatInfo.h
//  FbLife
//
//  Created by soulnear on 13-8-4.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBase.h"


@interface ChatInfo : NSObject


@property(nonatomic,strong)NSString * msg_id;
@property(nonatomic,strong)NSString * from_uid;
@property(nonatomic,strong)NSString * to_uid;
@property(nonatomic,strong)NSString * fuid_tuid;
@property(nonatomic,strong)NSString * date_now;
@property(nonatomic,strong)NSString * is_del;
@property(nonatomic,strong)NSString * from_username;
@property(nonatomic,strong)NSString * to_username;
@property(nonatomic,strong)NSString * zt;
@property(nonatomic,strong)NSString * msg_message;




-(ChatInfo *)initWithDic:(NSDictionary *)dic;




@end
