//
//  RankingListModel.h
//  越野e族
//
//  Created by soulnear on 14-7-9.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^RankingListModelComplicationBlock)(NSMutableArray * array);

typedef void(^RankingListModelFailedBlock)(NSString * errinfo);



@interface RankingListModel : NSObject
{
    RankingListModelComplicationBlock ranking_model_complication_block;
    
    RankingListModelFailedBlock ranking_model_failed_block;
}

@property(nonatomic,strong)NSString * ranking_id;

@property(nonatomic,strong)NSString * ranking_num;

@property(nonatomic,strong)NSString * ranking_title;

@property(nonatomic,strong)ASIHTTPRequest * myRequest;


-(RankingListModel *)initWithDictionary:(NSDictionary *)dic;


-(void)loadRankingListDataWithType:(int)theType WithComplicationBlock:(RankingListModelComplicationBlock)complicationBlock WithFailedBlock:(RankingListModelFailedBlock)failedBlock;



@end
