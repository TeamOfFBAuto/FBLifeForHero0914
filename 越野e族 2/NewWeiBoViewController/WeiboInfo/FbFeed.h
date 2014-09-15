//
//  FbFeed.h
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-17.
//  Copyright (c) 2012年 fblife. All rights reserved.
//
#import "BlogFeed.h"
#import "PhotoFeed.h"
#import "Extension.h"
#import "FbNewsFeed.h"

typedef enum {
    weibo,//0微博
    defualt1,//1保留
    blog,//2文集
    photo,//3图集
    bbsForward,//4论坛帖子转发为微博
    bbsSend,//5论坛分享
    newsReply,//6新闻评论
    defualt7,
    defualt8,
    defualt9,
    defualt10,//10论坛鼠标划过的分享，页面显示资源分享
    defualt11,//新闻鼠标划过的分享
} FbSort;

typedef enum
{
    first,
    reply,
    both,
    forward,
} Fbtype;

@interface FbFeed : NSObject
{
    NSString* _tid;
    NSString* _uid;
    NSString* _userName;
    NSString* _content;
    BOOL _imageFlg;//是否有图片标志
    NSString* _image_small_url;
    NSString* _image_original_url;
    NSString* _replys;//回复数
    NSString* _forwards;//转发数
    BOOL _rootFlg;//是否转发标志位
    NSString* _dateline;
    NSString* _from;//来自那里
    NSString* _sort;//微博类型说明
    NSString* _jing_lng;//精度
    NSString* _wei_lat;//维度
    NSString* _locality;//地点
    NSString* _face_small_url;
    NSString* _face_original_url;
    NSString* _type;
    NSString * title_content;
    
    
    BlogFeed* _blog;//文集信息
    PhotoFeed* _photo;//图集信息
    Extension* _exten;//宽展信息
    FbNewsFeed* _fbNews;//论坛帖子转发为微博
    
    ////////////////////一下是转发的信息////////////////////////
    
    
    NSString* _rtid;
    NSString* _ruid;
    NSString* _ruserName;
    NSString* _rcontent;
    BOOL _rimageFlg;//是否有图片标志
    NSString* _rimage_small_url;
    NSString* _rimage_original_url;
    NSString* _rreplys;//回复数
    NSString* _rforwards;//转发数
    BOOL _rrootFlg;//是否转发标志位
    NSString* _rdateline;
    NSString* _rfrom;//来自那里
    NSString* _rsort;//微博类型说明
    NSString* _rjing_lng;//精度
    NSString* _rwei_lat;//维度
    NSString* _rlocality;//地点
    NSString* _rface_small_url;
    NSString* _rface_original_url;
    NSString* _rtype;
    
    NSString * rtitle_content;
    
    
    BlogFeed* _rblog;//文集信息
    PhotoFeed* _rphoto;//图集信息
    Extension* _rexten;//宽展信息
    FbNewsFeed* _rfbNews;//论坛帖子转发为微博
    
    
    BOOL _hualangFlg;//是否是画廊标志位
    
}

@property(nonatomic,copy) NSString* tid;
@property(nonatomic,copy) NSString* uid;
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* content;
@property(nonatomic) BOOL imageFlg;//是否有图片标志
@property(nonatomic,copy) NSString* image_small_url;
@property(nonatomic,copy) NSString* image_original_url;
@property(nonatomic,copy) NSString * image_original_url_m;
@property(nonatomic,copy) NSString* image_small_url_m;
@property(nonatomic,copy) NSString* replys;//回复数
@property(nonatomic,copy) NSString* forwards;//转发数
@property(nonatomic) BOOL rootFlg;//是否转发标志位
@property(nonatomic,copy) NSString* dateline;
@property(nonatomic,copy) NSString* from;//来自那里
@property(nonatomic,strong) NSString* sort;//微博类型说明
@property(nonatomic,strong)NSString * sortId;
@property(nonatomic,copy) NSString* jing_lng;//精度
@property(nonatomic,copy) NSString* wei_lat;//维度
@property(nonatomic,copy) NSString* locality;//地点
@property(nonatomic,copy) NSString* face_small_url;
@property(nonatomic,copy) NSString* face_original_url;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString * totid;
@property(nonatomic,strong)NSString * title_content;

@property(nonatomic,strong)NSString * musicurl;//音频链接
@property(nonatomic,strong)NSString * olink;//视频链接

@property(nonatomic,copy) BlogFeed* blog;
@property(nonatomic,copy) PhotoFeed* photo;
@property(nonatomic,copy) Extension* exten;
@property(nonatomic,copy) FbNewsFeed* fbNews;

/////////////////////////////////一下是转发信息

@property(nonatomic,copy) NSString* rtid;
@property(nonatomic,copy) NSString* ruid;
@property(nonatomic,copy) NSString* ruserName;
@property(nonatomic,copy) NSString* rcontent;
@property(nonatomic) BOOL rimageFlg;//是否有图片标志
@property(nonatomic,copy) NSString* rimage_small_url;
@property(nonatomic,copy) NSString* rimage_original_url;
@property(nonatomic,copy) NSString * rimage_original_url_m;
@property(nonatomic,copy) NSString* rimage_small_url_m;
@property(nonatomic,copy) NSString* rreplys;//回复数
@property(nonatomic,copy) NSString* rforwards;//转发数
@property(nonatomic) BOOL rrootFlg;//是否转发标志位
@property(nonatomic,copy) NSString* rdateline;
@property(nonatomic,copy) NSString* rfrom;//来自那里
@property(nonatomic,strong) NSString* rsort;//微博类型说明
@property(nonatomic,strong)NSString * rsortId;
@property(nonatomic,copy) NSString* rjing_lng;//精度
@property(nonatomic,copy) NSString* rwei_lat;//维度
@property(nonatomic,copy) NSString* rlocality;//地点
@property(nonatomic,copy) NSString* rface_small_url;
@property(nonatomic,copy) NSString* rface_original_url;
@property(nonatomic,strong)NSString *rtype;
@property(nonatomic,strong)NSString * rtitle_content;

@property(nonatomic,strong)NSString * rmusicurl;//音频链接
@property(nonatomic,strong)NSString * rolink;//视频链接


@property(nonatomic,strong)NSString * photo_title;


@property(nonatomic,copy) BlogFeed* rblog;
@property(nonatomic,copy) PhotoFeed* rphoto;
@property(nonatomic,copy) Extension* rexten;
@property(nonatomic,copy) FbNewsFeed* rfbNews;

@property(nonatomic) BOOL hualangFlg;//是否是画廊标志位





-(void)setNsImageFlg:(NSString*)imageFlg;
-(void)setNsType:(NSString *)type;
//-(void)setNsSort:(NSString *)sort;
-(void)setNsRootFlg:(NSString*)rootFlg;


/////////////////////一下是转发信息
-(void)setRNsImageFlg:(NSString*)imageFlg;
-(void)setRNsType:(NSString *)type;
//-(void)setRNsSort:(NSString *)sort;
-(void)setRNsRootFlg:(NSString*)rootFlg;



//数据库

+(int)addWeiBoContentWithInfo:(FbFeed *)info WithType:(int)theType;


+(NSMutableArray *)findAll;
+(NSMutableArray *)findAllByType:(int)theType;

+(int)deleteAllByType:(int)theType;

+(int)deleteWeiBoBytId:(NSString *)thetId;

+(int)deleteWeiBoByContent:(NSString *)theContent;

+(int)updateReplys:(NSString *)theReplys WithTid:(NSString *)theTid;
+(int)updateForwards:(NSString *)theForwards WithTid:(NSString *)theTid;

@end


















