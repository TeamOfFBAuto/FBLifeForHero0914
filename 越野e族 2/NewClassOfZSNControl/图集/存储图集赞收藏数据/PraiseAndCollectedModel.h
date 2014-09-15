//
//  PraiseAndCollectedModel.h
//  越野e族
//
//  Created by soulnear on 14-7-18.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PraiseAndCollectedModel : NSManagedObject

@property (nonatomic, retain) NSString * atlasid;
@property (nonatomic, retain) NSNumber * praise;



//插入数据
+(void)addIntoDataSourceWithId:(NSString *)sender WithPraise:(NSNumber *)thePraise;

//查询
+(NSMutableArray *)findQueryWithId:(NSString *)theId;

+(PraiseAndCollectedModel *)getTeamInfoById:(NSString *)theId;

//更新
+(void)update:(PraiseAndCollectedModel *)sender;

//删除
+(void)deleteWithId:(NSString *)theId;
@end
