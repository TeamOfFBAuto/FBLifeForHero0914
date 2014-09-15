//
//  MessageInfo.m
//  FbLife
//
//  Created by soulnear on 13-8-4.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "MessageInfo.h"

@implementation MessageInfo
@synthesize date_now = _date_now;
@synthesize from_message = _from_message;
@synthesize from_uid = _from_uid;
@synthesize from_username = _from_username;
@synthesize fromunread = _fromunread;

@synthesize idtype = _idtype;
@synthesize is_del = _is_del;
@synthesize to_message = _to_message;
@synthesize to_uid = _to_uid;
@synthesize to_username = _to_username;
@synthesize tounread = _tounread;
@synthesize zt = _zt;
@synthesize news_id = _news_id;
@synthesize othername=_othername;
@synthesize selfunread=_selfunread;
@synthesize otheruid=_otheruid;



-(MessageInfo *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.date_now = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date_now"]];
        
        self.from_message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"from_message"]];
        
        self.from_uid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"from_uid"]];
        
        self.from_username = [NSString stringWithFormat:@"%@",[dic objectForKey:@"from_username"]];
        
        self.fromunread = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fromunread"]];
        
        self.idtype = [NSString stringWithFormat:@"%@",[dic objectForKey:@"idtype"]];
        
        self.is_del = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_del"]];
        
        self.to_message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"to_message"]];
        
        self.to_uid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"to_uid"]];
        
        self.to_username = [NSString stringWithFormat:@"%@",[dic objectForKey:@"to_username"]];
        
        self.tounread = [NSString stringWithFormat:@"%@",[dic objectForKey:@"tounread"]];
        
        self.zt = [NSString stringWithFormat:@"%@",[dic objectForKey:@"zt"]];
        
        self.news_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"new_id"]];
        
        NSString *string_myuid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_UID]];
        if ([string_myuid isEqualToString:self.from_uid]) {
            self.othername=self.to_username;
        }else{
            self.othername=self.from_username;
        }
        
        NSString *string_uid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_UID]];
        if ([string_uid isEqualToString:self.from_uid]) {
            self.selfunread=self.fromunread;
            self.otheruid=self.to_uid;
            
        }else{
            self.selfunread=self.tounread;
            self.otheruid=self.from_uid;
            
            
        }
        
        
    }
    
    return self;
}


@end






















