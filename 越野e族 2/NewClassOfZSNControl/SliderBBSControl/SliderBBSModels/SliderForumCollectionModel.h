//
//  SliderForumCollectionModel.h
//  越野e族
//
//  Created by soulnear on 14-7-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ForumCollectionFinishedBlock)(NSMutableArray * array);

typedef void(^ForumCollectionFailedBlock)(NSString * string);


@interface SliderForumCollectionModel : NSObject
{
    ForumCollectionFinishedBlock collection_finished_block;
    
    ForumCollectionFailedBlock collection_failed_block;
}


@property(nonatomic,strong)NSString * collect_tid;//收藏版块id

@property(nonatomic,strong)NSString * collect_dateline;//收藏版块时间

@property(nonatomic,strong)NSString * collect_forumname;//收藏版块名称

@property(nonatomic,strong)NSString * collect_subject;//收藏版块标题


@property(nonatomic,strong)NSMutableArray * collect_id_array;//保存所有收藏版块的id



-(SliderForumCollectionModel *)initWithDictionary:(NSDictionary *)dic;


-(void)loadCollectionDataWith:(int)page WithPageSize:(int)pagesize WithFinishedBlock:(ForumCollectionFinishedBlock)finished_Block WithFailedBlock:(ForumCollectionFailedBlock)failed_block;




@end



















