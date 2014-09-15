//
//  ChatInfo.m
//  FbLife
//
//  Created by soulnear on 13-8-4.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "ChatInfo.h"

@implementation ChatInfo
@synthesize msg_id = _msg_id;
@synthesize from_uid = _from_uid;
@synthesize to_uid = _to_uid;
@synthesize fuid_tuid = _fuid_tuid;
@synthesize date_now = _date_now;
@synthesize is_del = _is_del;
@synthesize from_username = _from_username;
@synthesize to_username = _to_username;
@synthesize zt = _zt;
@synthesize msg_message = _msg_message;



-(ChatInfo *)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.msg_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg_id"]];
        
        self.from_uid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"from_uid"]];
        
        self.to_uid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"to_uid"]];
        
        self.fuid_tuid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fuid_tuid"]];
        
        self.date_now = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date_now"]];

        
        self.from_username = [NSString stringWithFormat:@"%@",[dic objectForKey:@"from_username"]];
        
        self.to_username = [NSString stringWithFormat:@"%@",[dic objectForKey:@"to_username"]];

        self.zt = [NSString stringWithFormat:@"%@",[dic objectForKey:@"zt"]];

        self.is_del = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_del"]];
        
        self.msg_message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg_message"]];
        
        
        
       
    }
    
    return self;

}





@end











