//
//  PersonInfo.h
//  FbLife
//
//  Created by szk on 13-3-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"

@interface PersonInfo : NSObject
{
    
}



@property(nonatomic,strong)NSString * aboutme;
@property(nonatomic,strong)NSString * album_count;
@property(nonatomic,strong)NSString * blog_count;
@property(nonatomic,strong)NSString * circle_createcount;
@property(nonatomic,strong)NSString * city;
@property(nonatomic,strong)NSString * email;
@property(nonatomic,strong)NSString * face_original;
@property(nonatomic,strong)NSString * face_small;
@property(nonatomic,strong)NSString * fans_count;
@property(nonatomic,strong)NSString * follow_count;
@property(nonatomic,strong)NSString * gender;
@property(nonatomic,strong)NSString * image_count;
@property(nonatomic,strong)NSString * isbuddy;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * province;
@property(nonatomic,strong)NSString * topic_count;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * username;
@property(nonatomic,strong)NSString * isfriend;
@property(nonatomic,strong)NSString * isboth;
@property(nonatomic,assign)int _sectionNum;

@property(nonatomic,strong)NSString * is_shangjia;
@property(nonatomic,strong)NSString * userface;


//new

@property(nonatomic,strong)NSString * fb_flag;
@property(nonatomic,strong)NSString * bbsposts;
@property(nonatomic,strong)NSString * service_address;
@property(nonatomic,strong)NSString * service_lng;
@property(nonatomic,strong)NSString * service_lat;
@property(nonatomic,strong)NSString * service_sernum;
@property(nonatomic,strong)NSString * service_shopname;
@property(nonatomic,strong)NSString * service_simpcontent;
@property(nonatomic,strong)NSString * service_telphone;
@property(nonatomic,strong)NSString * service_content;
@property(nonatomic,strong)NSString * service_fid;









-(PersonInfo *)initWithDictionary:(NSDictionary *)dic;


- (NSString *) getFirstName;

@end
