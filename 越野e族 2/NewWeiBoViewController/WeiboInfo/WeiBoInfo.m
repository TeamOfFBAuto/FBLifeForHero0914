//
//  WeiBoInfo.m
//  FbLife
//
//  Created by szk on 13-2-26.
//  Copyright (c) 2013年 szk. All rights reserved.
//



#import "WeiBoInfo.h"
#import "JSONKit.h"

@implementation WeiBoInfo
@synthesize info_cid,info_dateline,info_extension,info_face_original,info_face_small,info_forwards,info_from,info_image_original,info_image_small,info_imageid,info_replys,info_roottid,info_sort,info_sortid,info_tid,info_totid,info_touid,info_tousername,info_type,info_uid,info_username,info_content_bbsId,info_content_content,info_content_title;
@synthesize info_follow_info,info_RfbNews,info_Rface_small_url,info_Rface_original_url,info_Rexten,info_Rdateline,info_Rblog,info_Rimage_small_url,info_Rimage_original_url,info_RimageFlg,info_RuserName,info_Ruid,info_rtid,info_RNsImageFlg,info_rcontent,info_rootFlg,info_content_photo,info_content_dataline,info_content_blogid,info_blogFeed,info_extensionFeed,info_fbnewFeed,info_ImageFlg,info_photoFeed,info_Rforwards;
@synthesize info_Rfrom,info_Rjing_lng,info_Rlocality,info_RNsRootFlg,info_RNsSort,info_RNsType,info_Rphoto,info_Rreplys,info_rsort,info_Rwei_lat;
@synthesize info_jing_lng,info_locality,info_wei_lat;


-(WeiBoInfo *)initWithTid:(NSString *)thetid
                      Uid:(NSString *)theuid
                 Username:(NSString *)theUserName
                Extension:(NSString *)theExtension
                  Content:(NSString *)theContent
                  Imageid:(NSString *)theImageId
                   Replys:(NSString *)theReplys
                 Forwards:(NSString *)theForwards
                  Roottid:(NSString *)theRoottid
                    Totid:(NSString *)theTotid
                    Touid:(NSString *)theTouid
               Tousername:(NSString *)theTousername
                 DateLine:(NSString *)theDateLine
                     From:(NSString *)theFrom
                     Type:(NSString *)theType
                     Sort:(NSString *)theSort
                   Sortid:(NSString *)theSortId
                      Cid:(NSString *)theCid
               ImageSmall:(NSString *)theImageSmall
            imageOriginal:(NSString *)theImageOriginal
                FaceSmall:(NSString *)theFaceSmall
             FaceOriginal:(NSString *)theFaceOriginal
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

-(WeiBoInfo *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.info_tid = [dictionary objectForKey:@"tid"];
        self.info_uid = [dictionary objectForKey:@"uid"];
        self.info_username = [dictionary objectForKey:@"username"];
        self.info_extension = [[[dictionary objectForKey:@"extension"] objectFromJSONString] objectForKey:@"title"];
        self.info_content_title = [[[dictionary objectForKey:@"content"] objectFromJSONString] objectForKey:@"title"];
        self.info_content_bbsId = [[[dictionary objectForKey:@"content"] objectFromJSONString] objectForKey:@"bbsid"];
        self.info_content_content =  [personal imgreplace:[dictionary objectForKey:FB_CONTENT]];
        self.info_content_blogid = [[[dictionary objectForKey:@"content"] objectFromJSONString] objectForKey:@"blogid"];
        self.info_content_dataline = [[[dictionary objectForKey:@"content"] objectFromJSONString] objectForKey:@"dateline"];
        self.info_content_photo = [[[dictionary objectForKey:@"content"] objectFromJSONString] objectForKey:@"photo"];
        self.info_imageid = [dictionary objectForKey:@"imageid"];
        self.info_replys = [dictionary objectForKey:@"replys"];
        self.info_forwards = [dictionary objectForKey:@"forwards"];
        self.info_roottid = [dictionary objectForKey:@"roottid"];
        self.info_totid = [dictionary objectForKey:@"totid"];
        self.info_touid = [dictionary objectForKey:@"touid"];
        self.info_tousername = [dictionary objectForKey:@"tousername"];
        self.info_dateline = [personal timestamp:[dictionary objectForKey:@"dateline"]];
        self.info_from = [dictionary objectForKey:@"from"];
        self.info_type = [dictionary objectForKey:@"type"];
        self.info_sort = [dictionary objectForKey:@"sort"];
        self.info_sortid = [dictionary objectForKey:@"sortid"];
        self.info_cid = [dictionary objectForKey:@"cid"];
        self.info_image_small = [dictionary objectForKey:@"image_small"];
        self.info_image_original = [dictionary objectForKey:@"image_original"];
        self.info_face_small = [dictionary objectForKey:@"face_small"];
        self.info_face_original = [dictionary objectForKey:@"face_original"];
    }
    return self;
}




-(void)setNsImageFlg:(NSString*)imageFlg
{
    if ([@"0" isEqualToString:imageFlg])
    {
        
        info_ImageFlg=NO;
    }else{
        info_ImageFlg=YES;
    }
}
-(void)setNsRootFlg:(NSString*)rootFlg
{
    if ([@"0" isEqualToString:rootFlg])
    {
        info_rootFlg=NO;
    }else{
        info_rootFlg=YES;
    }
}
//-(void)setFrom:(NSString *)from{
//    
//    if (info_from != from) {
//        info_from = [[NSString stringWithFormat:@"来自 %@",from] copy];
//    }
//}

-(void)setNsType:(NSString *)type
{
    if ([@"first" isEqualToString:type])
    {
        info_type=@"first";
    }else  if ([@"both" isEqualToString:type])
    {
        info_type=@"both";
    }else  if ([@"reply" isEqualToString:type])
    {
        info_type=@"reply";
    }
}






//----------------------------------------------
-(void)setRNsImageFlg:(NSString*)imageFlg{
    if ([@"0" isEqualToString:imageFlg]) {
        
        info_RimageFlg=NO;
    }else{
        info_RimageFlg=YES;
    }
}
-(void)setRNsRootFlg:(NSString*)rootFlg{
    if ([@"0" isEqualToString:rootFlg]) {
        info_RNsRootFlg=NO;
    }else{
        info_RNsRootFlg=YES;
    }
}
//-(void)setRFrom:(NSString *)rfrom{
//    if (info_Rfrom != rfrom) {
//        info_Rfrom = [[NSString stringWithFormat:@"来自 %@",rfrom] copy];
//    }
//    
//}
-(void)setRNsType:(NSString *)type{
    if ([@"first" isEqualToString:type]) {
        info_RNsType=@"first";
    }else  if ([@"both" isEqualToString:type]) {
        info_RNsType=@"both";
    }else  if ([@"reply" isEqualToString:type]) {
        info_RNsType=@"reply";
    }
}


@end









