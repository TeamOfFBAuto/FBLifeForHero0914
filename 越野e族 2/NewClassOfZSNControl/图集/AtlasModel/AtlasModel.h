//
//  AtlasModel.h
//  越野e族
//
//  Created by soulnear on 14-7-15.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AtlasModelFinished)(NSMutableArray * array);

typedef void(^AtlasModelFailed)(NSString * string);



@interface AtlasModel : NSObject
{
    AtlasModelFinished atlasFinishedBlock;
    
    AtlasModelFailed atlasFailedBlock;
}


@property(nonatomic,strong)NSString * atlas_id;

@property(nonatomic,strong)NSString * atlas_pid;

@property(nonatomic,strong)NSString * atlas_photo;

@property(nonatomic,strong)NSString * atlas_name;

@property(nonatomic,strong)NSString * atlas_content;

@property(nonatomic,strong)NSString * atlas_photocontent;

@property(nonatomic,strong)NSString * atlas_iscommend;//是否被推荐

@property(nonatomic,strong)NSString * atlas_likes;//赞数

@property(nonatomic,strong)NSString * atlas_comment;//评论数


-(AtlasModel *)initWithDictionary:(NSDictionary *)dic;


-(void)loadAtlasDataWithId:(NSString *)theId WithCompleted:(AtlasModelFinished)theFinished WithFailedBlock:(AtlasModelFailed)theFailed;




@end











