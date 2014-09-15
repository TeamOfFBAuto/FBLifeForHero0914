//
//  ReplysFeed.h
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-26.
//  Copyright (c) 2012年 fblife. All rights reserved.
//


@interface ReplysFeed : NSObject{
    
    //本条微博信息
    NSString* _tid; //微博Id
    NSString* _uid; //用户id
    NSString* _username;//用户昵称
    NSString* _content;//微博内容
    NSString* _imageid;//是否有图片(0,没有图片 其他，有图片)
    NSString* _replys;//回复数
    NSString* _forwards;//转法数
    NSString* _roottid;//转发跟微博id
    NSString* _totid;//转发微博id
    NSString* _touid;//转发用户id
    NSString* _tousername;//转发用户名
    NSString* _dateline;//微博时间
    NSString* _from;//微博的来源（web,ipad,iphone,android）
    NSString* _sort;//微博类型(2是文集，3是画廊，1是活动,0是其他)
    NSString* _sortid;//具体的id
    NSString* _imageSmall;//小图路径
    NSString* _imageOriginal;//大图路径
    NSString* _faceSmall;//小头像
    NSString* _faceOriginal;//大头像
    
}

@property(nonatomic,copy) NSString* tid;
@property(nonatomic,copy) NSString* uid;
@property(nonatomic,copy) NSString* content;
@property(nonatomic,copy) NSString* username;
@property(nonatomic,copy) NSString* imageid;
@property(nonatomic,copy) NSString* replys;
@property(nonatomic,copy) NSString* forwards;
@property(nonatomic,copy) NSString* roottid;
@property(nonatomic,copy) NSString* totid;
@property(nonatomic,copy) NSString* touid;
@property(nonatomic,copy) NSString* tousername;
@property(nonatomic,copy) NSString* dateline;
@property(nonatomic,copy) NSString* from;
@property(nonatomic,copy) NSString* sort;
@property(nonatomic,copy) NSString* sortid;
@property(nonatomic,copy) NSString* imageSmall;
@property(nonatomic,copy) NSString* imageOriginal;
@property(nonatomic,copy) NSString* faceSmall;
@property(nonatomic,copy) NSString* faceOriginal;

@end