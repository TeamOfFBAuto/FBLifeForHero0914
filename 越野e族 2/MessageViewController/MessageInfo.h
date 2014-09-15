//
//  MessageInfo.h
//  FbLife
//
//  Created by soulnear on 13-8-4.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageInfo : NSObject
{
    
}


@property(nonatomic,strong)NSString * date_now;
@property(nonatomic,strong)NSString * from_message;
@property(nonatomic,strong)NSString * from_uid;
@property(nonatomic,strong)NSString * from_username;
@property(nonatomic,strong)NSString * fromunread;

@property(nonatomic,strong)NSString * idtype;
@property(nonatomic,strong)NSString * is_del;
@property(nonatomic,strong)NSString * news_id;
@property(nonatomic,strong)NSString * to_message;
@property(nonatomic,strong)NSString * to_uid;
@property(nonatomic,strong)NSString * to_username;
@property(nonatomic,strong)NSString * tounread;
@property(nonatomic,strong)NSString * zt;
@property(nonatomic,strong)NSString * selfunread;//表示自己是否已经读过
@property(nonatomic,strong)NSString * othername;//另外一方的名字
@property(nonatomic,strong)NSString * otheruid;//另外一方的名字




-(MessageInfo *)initWithDictionary:(NSDictionary *)dic;




@end
