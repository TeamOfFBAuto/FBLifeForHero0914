//
//  PhotoFeed.m
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-19.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import "PhotoFeed.h"
#import "DefaultConstant.h"

@implementation PhotoFeed

@synthesize aid=_aid;
@synthesize title=_title;
@synthesize dateline=_dateline;
@synthesize image=_image;
@synthesize image_string = _image_string;


-(id)initWithJson:( NSDictionary *)conentJson{
    if ([self init]) {
        
        _aid=[NSString stringWithFormat:@"%@",[conentJson objectForKey:PHOTO_AID]];
        
        _title=[NSString stringWithFormat:@"%@",[conentJson objectForKey:PHOTO_TITLE]];
        _dateline=[personal timestamp:[conentJson objectForKey:PHOTO_DATELINE]];
        _image= [[conentJson objectForKey:PHOTO_CONTENT] componentsSeparatedByString:@"|"];
        
        _image_string = [conentJson objectForKey:PHOTO_CONTENT];
    }
    return self;
}

//用于copy  bean时调用
-(id)copyWithZone:(NSZone *)zone
{
    PhotoFeed *newFeed=[[PhotoFeed allocWithZone:zone]init];
    
    [newFeed setAid:_aid];
    [newFeed setTitle:_title];
    [newFeed setDateline:_dateline];
    [newFeed setImage:_image];
    
    return newFeed;
    
}


//- (void)dealloc {
//    [_aid release];
//    [_title release];
//    [_dateline release];
//    [_image release];
//
//    [super dealloc];
//}

@end