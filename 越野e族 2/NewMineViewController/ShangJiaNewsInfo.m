//
//  ShangJiaNewsInfo.m
//  FbLife
//
//  Created by soulnear on 13-12-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "ShangJiaNewsInfo.h"

@implementation ShangJiaNewsInfo
@synthesize link = _link;
@synthesize photo = _photo;
@synthesize title = _title;


-(ShangJiaNewsInfo *)initWithDic:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        self.link = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"link"]];
        self.photo = [NSString stringWithFormat:@"http://fb.cn/%@",[dictionary objectForKey:@"photo"]];
        self.title = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"title"]];
    }
    
    return self;
}





@end
