//
//  WeiBoInfo.h
//  FbLife
//
//  Created by szk on 13-2-26.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoFeed.h"
#import "Extension.h"
#import "FbNewsFeed.h"
#import "BlogFeed.h"

@interface WeiBoInfo : NSObject
{
    
}

@property(nonatomic,strong)NSString * info_tid;
@property(nonatomic,strong)NSString * info_uid;
@property(nonatomic,strong)NSString * info_username;
@property(nonatomic,strong)NSString * info_extension;
@property(nonatomic,strong)NSString * info_content_bbsId;
@property(nonatomic,strong)NSString * info_content_title;
@property(nonatomic,strong)NSString * info_content_content;
@property(nonatomic,strong)NSString * info_content_blogid;
@property(nonatomic,strong)NSString * info_content_dataline;
@property(nonatomic,strong)NSString * info_content_photo;
@property(nonatomic,strong)NSString * info_imageid;
@property(nonatomic,strong)NSString * info_replys;//回复数
@property(nonatomic,copy) NSString* info_jing_lng;//精度
@property(nonatomic,copy) NSString* info_wei_lat;//维度
@property(nonatomic,copy) NSString* info_locality;//地点
@property(nonatomic,strong)NSString * info_forwards;//转发数
@property(nonatomic,strong)NSString * info_roottid;
@property(nonatomic,strong)NSString * info_totid;
@property(nonatomic,strong)NSString * info_touid;
@property(nonatomic,strong)NSString * info_tousername;
@property(nonatomic,strong)NSString * info_dateline;
@property(nonatomic,strong)NSString * info_from;
@property(nonatomic,strong)NSString * info_type;
@property(nonatomic,strong)NSString * info_sort;
@property(nonatomic,strong)NSString * info_sortid;
@property(nonatomic,strong)NSString * info_cid;
@property(nonatomic,strong)NSString * info_image_small;
@property(nonatomic,strong)NSString * info_image_original;
@property(nonatomic,strong)NSString * info_face_small;
@property(nonatomic,strong)NSString * info_face_original;
@property(nonatomic,strong)WeiBoInfo * info_follow_info;
@property(nonatomic,strong)PhotoFeed * info_photoFeed;
@property(nonatomic,strong)Extension * info_extensionFeed;
@property(nonatomic,strong)FbNewsFeed * info_fbnewFeed;
@property(nonatomic)BOOL info_ImageFlg;
@property(nonatomic,strong)BlogFeed * info_blogFeed;
@property(nonatomic) BOOL info_rootFlg;//是否转发标志位



//回复
@property(nonatomic,strong)NSString * info_rcontent;
@property(nonatomic)BOOL info_RimageFlg;
@property(nonatomic,strong)NSString * info_Rimage_small_url;
@property(nonatomic,strong)NSString * info_Rimage_original_url;
@property(nonatomic,strong)NSString * info_rtid;
@property(nonatomic,strong)NSString * info_Ruid;
@property(nonatomic,strong)NSString * info_RuserName;
@property(nonatomic,strong)NSString * info_RNsImageFlg;
@property(nonatomic,strong)NSString * info_Rfrom;
@property(nonatomic,strong)NSString * info_RNsType;
@property(nonatomic,strong)NSString * info_RNsSort;
@property(nonatomic,strong)NSString * info_Rjing_lng;
@property(nonatomic,strong)NSString * info_Rwei_lat;
@property(nonatomic,strong)NSString * info_Rlocality;
@property(nonatomic,strong)NSString * info_Rface_original_url;
@property(nonatomic,strong)NSString * info_Rface_small_url;
@property(nonatomic)BOOL info_RNsRootFlg;
@property(nonatomic,strong)NSString * info_Rdateline;
@property(nonatomic,strong)NSString * info_Rreplys;
@property(nonatomic,strong)NSString * info_Rforwards;
@property(nonatomic,strong)NSString * info_rsort;
@property(nonatomic,strong)Extension * info_Rexten;
@property(nonatomic,strong)PhotoFeed * info_Rphoto;
@property(nonatomic,strong)BlogFeed * info_Rblog;
@property(nonatomic,strong)FbNewsFeed * info_RfbNews;




-(WeiBoInfo *)initWithTid:(NSString *)thetid Uid:(NSString *)theuid Username:(NSString *)theUserName Extension:(NSString *)theExtension Content:(NSString *)theContent Imageid:(NSString *)theImageId Replys:(NSString *)theReplys Forwards:(NSString *)theForwards Roottid:(NSString *)theRoottid Totid:(NSString *)theTotid Touid:(NSString *)theTouid Tousername:(NSString *)theTousername DateLine:(NSString *)theDateLine From:(NSString *)theFrom Type:(NSString *)theType Sort:(NSString *)theSort Sortid:(NSString *)theSortId Cid:(NSString *)theCid ImageSmall:(NSString *)theImageSmall imageOriginal:(NSString *)theImageOriginal FaceSmall:(NSString *)theFaceSmall FaceOriginal:(NSString *)theFaceOriginal;


-(WeiBoInfo *)initWithDictionary:(NSDictionary *)dictionary;



-(void)setNsImageFlg:(NSString*)imageFlg;
-(void)setNsRootFlg:(NSString*)rootFlg;
//-(void)setFrom:(NSString *)from;
-(void)setNsType:(NSString *)type;
//---------------------------------------


-(void)setRNsImageFlg:(NSString*)imageFlg;
-(void)setRNsRootFlg:(NSString*)rootFlg;
//-(void)setRFrom:(NSString *)rfrom;
-(void)setRNsType:(NSString *)type;

@end







