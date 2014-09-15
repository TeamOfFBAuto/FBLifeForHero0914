//
//  FbNewsFeed.m
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-20.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import "FbNewsFeed.h"
#import "DefaultConstant.h"

@implementation FbNewsFeed

@synthesize title=_title;
@synthesize content=_content;
@synthesize bbsid=_bbsid;
@synthesize uid=_uid;
@synthesize username=_username;
@synthesize photo=_photo;
@synthesize photoFlg=_photoFlg;


-(id)initWithJson:( NSDictionary *)conentJson
{
    if ([self init])
    {
        _title=[personal strReplace:[conentJson objectForKey:FB_BBS_TITLE] ];
        
        _content=[personal strReplace:[conentJson objectForKey:FB_BBS_CONTENT]==nil||[@"" isEqualToString:[conentJson objectForKey:BLOG_CONTENT]]?@"...":[conentJson objectForKey:FB_BBS_CONTENT]];
        
        _bbsid=[conentJson objectForKey:FB_BBS_BBSID];
        
        _uid= [conentJson objectForKey:FB_BBS_UID];
        
        _username=[conentJson objectForKey:FB_BBS_USERNAME];
        
        _photo=[conentJson objectForKey:FB_BBS_PHOTO];
        
        
        NSString * string = [NSString stringWithFormat:@"%@",[conentJson objectForKey:FB_BBS_PHOTO]];
                
        if (string.length > 30)
        {
            _photoFlg=YES;
        }else
        {
            _photoFlg=NO;
        }
        
       
        
//        NSLog(@"title:%@=====content:%@=====bbsid:%@======uid:%@======username:%@======photo:%@",_title,_content,_bbsid,_uid,_username,_photo);
        
    }
    return self;
}

//用于copy  bean时调用
-(id)copyWithZone:(NSZone *)zone{
    FbNewsFeed *newBolgFeed=[[FbNewsFeed allocWithZone:zone]init];
    [newBolgFeed setTitle:_title];
    [newBolgFeed setContent:_content];
    [newBolgFeed setBbsid:_bbsid];
    [newBolgFeed setUid:_uid];
    [newBolgFeed setPhoto:_photo];
    [newBolgFeed setPhotoFlg:_photoFlg];
    [newBolgFeed setUsername:_username];
    
    return newBolgFeed;
}


//- (void)dealloc {
//    [_title release];
//    [_content release];
//    [_bbsid release];
//    [_uid release];
//    [_photo release];
//    [_username release];
//    
//    [super dealloc];
//}

@end