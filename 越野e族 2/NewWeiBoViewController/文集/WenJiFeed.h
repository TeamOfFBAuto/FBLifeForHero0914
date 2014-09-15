//
//  WenJiFeed.h
//  FbLife
//
//  Created by soulnear on 13-3-28.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WenJiFeed : NSObject
{
    
}

@property(nonatomic,strong)NSString * classid;
@property(nonatomic,strong)NSString * commentnum;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * dateline;
@property(nonatomic,strong)NSString * face_original;
@property(nonatomic,strong)NSString * face_small;
@property(nonatomic,strong)NSString * wid;
@property(nonatomic,strong)NSString * photo;
@property(nonatomic,strong)NSString * wpublic;
@property(nonatomic,strong)NSString * sortid;
@property(nonatomic,strong)NSString * tags;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * username;

-(id)initWithJson:( NSDictionary *)conentJson;


@end
