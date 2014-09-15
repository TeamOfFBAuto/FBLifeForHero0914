//
//  PersonInfo.m
//  FbLife
//
//  Created by szk on 13-3-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "PersonInfo.h"

@implementation PersonInfo
@synthesize aboutme = _aboutme;
@synthesize album_count = _album_count;
@synthesize blog_count = _blog_count;
@synthesize circle_createcount = _circle_createcount;
@synthesize city = _city;
@synthesize email = _email;
@synthesize face_original = _face_original;
@synthesize face_small = _face_small;
@synthesize fans_count = _fans_count;
@synthesize follow_count = _follow_count;
@synthesize gender = _gender;
@synthesize image_count = _image_count;
@synthesize isbuddy = _isbuddy;
@synthesize nickname = _nickname;
@synthesize province = _province;
@synthesize topic_count = _topic_count;
@synthesize uid = _uid;
@synthesize username = _username;
@synthesize isboth = _isboth;
@synthesize isfriend = _isfriend;
@synthesize _sectionNum;
@synthesize is_shangjia = _is_shangjia;
@synthesize userface = _userface;


//new

@synthesize fb_flag = _fb_flag;
@synthesize bbsposts = _bbsposts;
@synthesize service_address = _service_address;
@synthesize service_lng = _service_lng;
@synthesize service_lat = _service_lat;
@synthesize service_sernum = _service_sernum;
@synthesize service_shopname = _service_shopname;
@synthesize service_simpcontent = _service_simpcontent;
@synthesize service_telphone = _service_telphone;
@synthesize service_content = _service_content;
@synthesize service_fid = _service_fid;



-(PersonInfo *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _aboutme = [NSString stringWithFormat:@"%@",[dic objectForKey:@"aboutme"]];
        
        _album_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"album_count"]];
        
        _blog_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"blog_count"]];
        
        _circle_createcount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"circle_createcount"]];
        
        _city = [NSString stringWithFormat:@"%@",[dic objectForKey:@"city"]];
        
        _email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"email"]];
        
        _face_original = [NSString stringWithFormat:@"%@",[dic objectForKey:@"face_original"]];
        
        _face_small = [NSString stringWithFormat:@"%@",[dic objectForKey:@"face_small"]];
        
        _fans_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fans_count"]];
        
        _follow_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"follow_count"]];
        
        _gender = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gender"]];
        
        _image_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"image_count"]];
        
        _isbuddy = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isbuddy"]];
        
        _nickname = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickname"]];
        
        _province = [NSString stringWithFormat:@"%@",[dic objectForKey:@"province"]];
        
        _topic_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"topic_count"]];
        
        _uid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"uid"]];
        
        _username = [NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]];
        
        _isfriend = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isfriend"]];
        
        _isboth = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isboth"]];
        
        _is_shangjia = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_shangjia"]];
        
        _userface = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userface"]];
        
        //new
        
        _fb_flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FB_flag"]];
        
        _bbsposts = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bbsposts"]];
        
        _service_address = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_address"]];
        
        _service_lng = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_lng"]];
        
        _service_lat = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_lat"]];
        
        _service_sernum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_sernum"]];
        
        _service_shopname = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_shopname"]];
        _service_simpcontent = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_simpcontent"]];
        
        _service_telphone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_telphone"]];
        
        _service_content = [NSString stringWithFormat:@"%@",[dic objectForKey:@"service_content"]];
        
        _service_fid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fid"]];
    }
    return self;
}

- (NSString *) getFirstName
{
    NSString * firstName;
    if ([[[self.username substringToIndex:1] substringFromIndex:0] canBeConvertedToEncoding: NSASCIIStringEncoding])
    {
        //如果是英语
        firstName = self.username;
    }
    else
    {
        //如果是非英语
        firstName = [NSString stringWithFormat:@"%c",pinyinFirstLetter([[[self.username substringToIndex:1] substringFromIndex:0] characterAtIndex:0])];
    }
    
    return firstName;
    
}


@end












