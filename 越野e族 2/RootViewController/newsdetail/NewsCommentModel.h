//
//  NewsCommentModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-21.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "downloadtool.h"
#import "JSONKit.h"
//errcode = 0;
//total = 14;
//weiboinfo =     (
//                 {
//                     content = ttttt;
//                     dateline = 1359632466;
//                     "face_original" = "<null>";
//                     "face_small" = "<null>";
//                     forwards = 0;
//                     from = web;
//                     "image_original" = "<null>";
//                     "image_small" = "http://t.fblife.com/";
//                     imageid = 0;
//                     "jing_lng" = "0.000000";
//                     locality = "";
//                     replys = 2;
//                     roottid = 0;
//                     sort = 7;
//                     sortid = 511;
//                     tid = 6418;
//                     totid = 0;
//                     touid = 0;
//                     tousername = "";
//                     type = first;
//                     uid = 887666;
//                     username = "\U5f20\U4fe1\U597d";
//                     "wei_lat" = "0.000000";
//                 },
@class NewsCommentModel;
@protocol NewsCommentModelDelegate <NSObject>

-(void)downloadsuccess;

@end

@interface NewsCommentModel : NSObject<downloaddelegate>
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,assign)id<NewsCommentModelDelegate>delegate;
//-(NewsCommentModel*)initWithtotal:(NSString *)thetotal  themuarray:(NSMutableArray*)thearray;
-(void)startloaddata;



@end
