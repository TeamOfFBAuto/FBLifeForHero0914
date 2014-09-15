//
//  WenJiFeed.m
//  FbLife
//
//  Created by soulnear on 13-3-28.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "WenJiFeed.h"

@implementation WenJiFeed
@synthesize username;
@synthesize uid;
@synthesize title;
@synthesize tags;
@synthesize sortid;
@synthesize public;
@synthesize photo;
@synthesize id;
@synthesize face_small;
@synthesize face_original;
@synthesize dateline;
@synthesize content;
@synthesize commentnum;
@synthesize classid;


-(id)initWithJson:( NSDictionary *)conentJson
{
    if ([self init])
    {
        self.classid = [conentJson objectForKey:@"classid"];
        self.commentnum = [conentJson objectForKey:@"commentnum"];
        self.content = [self replaceStr:[conentJson objectForKey:@"content"]];
        self.dateline = [personal timechange:[conentJson objectForKey:@"dateline"]];
        self.face_original = [conentJson objectForKey:@"face_original"];
        self.face_small = [conentJson objectForKey:@"face_small"];
        self.id = [conentJson objectForKey:@"id"];
        self.photo = [conentJson objectForKey:@"photo"];
        self.public = [conentJson objectForKey:@"public"];
        self.sortid = [conentJson objectForKey:@"sortid"];
        self.tags = [conentJson objectForKey:@"tags"];
        self.title = [conentJson objectForKey:@"title"];
        self.uid = [conentJson objectForKey:@"uid"];
        self.username = [conentJson objectForKey:@"username"];
        
    }
    return self;
}


-(NSString *)replaceStr:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@"> <br />"];
    
    NSMutableString * temp = [NSMutableString stringWithString:string];
    
    [temp insertString:@"<p style=\"text-align:center;\">" atIndex:0];
    [temp insertString:@"</p>" atIndex:temp.length];
    
    return [NSString stringWithString:temp];
}

@end




























