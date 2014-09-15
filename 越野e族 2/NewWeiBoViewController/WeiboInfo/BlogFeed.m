//
//  BlogFeed.m
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-17.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import "BlogFeed.h"
#import "DefaultConstant.h"

@implementation BlogFeed

@synthesize blogid=_blogid;
@synthesize title=_title;
@synthesize content=_content;
@synthesize dateline=_dateline;
@synthesize photo=_photo;
@synthesize photoFlg=_photoFlg;



-(id)initWithJson:( NSDictionary *)conentJson
{
    if ([self init]) {
        _blogid=[conentJson objectForKey:BLOG_ID];
        _title=[personal strReplace:[conentJson objectForKey:BLOG_TITLE]];
        _content= [personal strReplace:[conentJson objectForKey:BLOG_CONTENT]==nil||[@"" isEqualToString:[conentJson objectForKey:BLOG_CONTENT]]?@"...":[conentJson objectForKey:BLOG_CONTENT]];
        _dateline=  [personal timestamp:[conentJson objectForKey:BLOG_DATELINE]];
        _photo=[conentJson objectForKey:BLOG_PHOTO];
        
        if (![[conentJson objectForKey:BLOG_PHOTO] isEqual:[NSNull null]] ) {
            _photoFlg=YES;
        }else{
            _photoFlg=NO;
        }
        
    }
    return self;
}

//用于copy  bean时调用
-(id)copyWithZone:(NSZone *)zone{
    BlogFeed *newBolgFeed=[[BlogFeed allocWithZone:zone]init];
    [newBolgFeed setBlogid:_blogid];
    [newBolgFeed setTitle:_title];
    [newBolgFeed setContent:_content];
    [newBolgFeed setDateline:_dateline];
    [newBolgFeed setPhoto:_photo];
    [newBolgFeed setPhotoFlg:_photoFlg];
    
    return newBolgFeed;
    
}


//- (void)dealloc {
//    [_blogid release];
//    [_title release];
//    [_content release];
//    [_dateline release];
//    [_photo release];
//    
//    [super dealloc];
//}

@end
