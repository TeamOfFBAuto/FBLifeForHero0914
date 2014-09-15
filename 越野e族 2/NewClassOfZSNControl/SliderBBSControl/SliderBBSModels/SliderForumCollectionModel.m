
//
//  SliderForumCollectionModel.m
//  越野e族
//
//  Created by soulnear on 14-7-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SliderForumCollectionModel.h"





@implementation SliderForumCollectionModel
@synthesize collect_dateline = _collect_dateline;
@synthesize collect_forumname = _collect_forumname;
@synthesize collect_subject = _collect_subject;
@synthesize collect_tid = _collect_tid;
@synthesize collect_id_array = _collect_id_array;


-(SliderForumCollectionModel *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        _collect_tid = [zsnApi exchangeStringForDeleteNULL:[dic objectForKey:@"tid"]];
        
        _collect_dateline = [zsnApi exchangeStringForDeleteNULL:[dic objectForKey:@"dateline"]];
        
        _collect_forumname = [zsnApi exchangeStringForDeleteNULL:[dic objectForKey:@"forumname"]];
        
        _collect_subject = [zsnApi exchangeStringForDeleteNULL:[dic objectForKey:@"subject"]];
        
    }
    
    return self;
}


-(void)loadCollectionDataWith:(int)page WithPageSize:(int)pagesize WithFinishedBlock:(ForumCollectionFinishedBlock)finished_Block WithFailedBlock:(ForumCollectionFailedBlock)failed_block
{
    
    collection_finished_block = finished_Block;
    
    collection_failed_block = failed_block;
    
    //张少南 这里需要autherkey  这是新的接口里边是测试数据
//    NSString * fullUrl = [NSString stringWithFormat:GET_ALL_COLLECTION_SECTION,@"U2VRMgdnVzVQZlc8AnkKelo7A25fd1JhCWEANw",page,pagesize];
    
    
    //这是老接口
    
    NSString * fullUrl = [NSString stringWithFormat:GET_ALL_COLLECTION_SECTION,AUTHKEY,pagesize];
    
    
    NSLog(@"请求论坛版块收藏 ---  %@",fullUrl);
    
    ASIHTTPRequest * collection_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    __block typeof(collection_request) request = collection_request;
    
    [request setCompletionBlock:^{
        
        @try {
            
            NSMutableArray * data_array = [NSMutableArray array];
            
            _collect_id_array = [NSMutableArray array];
            
            NSDictionary * allDic = [collection_request.responseString objectFromJSONString];
            
            if ([[allDic objectForKey:@"errcode"] intValue] == 0)
            {
                NSArray * array = [allDic objectForKey:@"bbsinfo"];
                
                for (NSDictionary * dic in array)
                {
                    
                    SliderForumCollectionModel * model = [[SliderForumCollectionModel alloc] initWithDictionary:dic];
                    
                    [_collect_id_array addObject:[dic objectForKey:@"fid"]];
                    
                    [data_array addObject:model];
                }
                
                collection_finished_block(data_array);
            }else
            {
                collection_failed_block(@"获取失败");
            }
            
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    [request setFailedBlock:^{
        collection_failed_block(@"获取失败");
    }];
    
    [collection_request startAsynchronous];
}



@end

















