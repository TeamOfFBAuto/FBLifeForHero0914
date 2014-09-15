//
//  Extension.m
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-20.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import "Extension.h"
#import "DefaultConstant.h"

@implementation Extension

@synthesize title=_title;
@synthesize forum_content=_forum_content;
@synthesize author=_author;
@synthesize authorid=_authorid;
@synthesize photo=_photo;
@synthesize time=_time;
@synthesize photoFlg=_photoFlg;



-(id)initWithJson:( NSDictionary *)conentJson
{
    if ([self init])
    {
        _title=[NSString stringWithFormat:@"%@",[conentJson objectForKey:FB_EX_TITLE]];
        _forum_content = [NSString stringWithFormat:@"%@",[conentJson objectForKey:FB_EX_FORUM_CONTENT]];
        
        _author=[NSString stringWithFormat:@"%@",[conentJson objectForKey:FB_EX_AUTHOR]];
        _authorid= [NSString stringWithFormat:@"%@",[conentJson objectForKey:FB_EX_AUTHORID]];
        _photo=[conentJson objectForKey:FB_EX_PHOTO];
        _time=[personal timestamp:[conentJson objectForKey:FB_EX_TIME]];
        
//        NSLog(@"========%@",_photo);
        if (![_photo isEqual:[NSNull null]] &&_photo.length!=0) {
            _photoFlg=YES;
        }else{
            _photoFlg=NO;
        }
        
    }
    return self;
}

//用于copy  bean时调用
-(id)copyWithZone:(NSZone *)zone{
    Extension *newFeed=[[Extension allocWithZone:zone]init];
    
    [newFeed setTitle:_title];
    [newFeed setForum_content:_forum_content];
    [newFeed setAuthor:_author];
    [newFeed setAuthorid:_authorid];
    [newFeed setPhoto:_photo];
    [newFeed setTime:_time];
    [newFeed setPhotoFlg:_photoFlg];
    
    return newFeed;
    
}


//- (void)dealloc {
//    [_title release];
//    [_forum_content release];
//    [_author release];
//    [_authorid release];
//    [_photo release];
//    [_time release];
//    
//    [super dealloc];
//}

@end