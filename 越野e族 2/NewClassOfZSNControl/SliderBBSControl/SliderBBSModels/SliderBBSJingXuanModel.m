//
//  SliderBBSJingXuanModel.m
//  越野e族
//
//  Created by soulnear on 14-7-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SliderBBSJingXuanModel.h"

@implementation SliderBBSJingXuanModel
@synthesize jx_comment = _jx_comment;
@synthesize jx_id = _jx_id;
@synthesize jx_link = _jx_link;
@synthesize jx_photo = _jx_photo;
@synthesize jx_publishtime = _jx_publishtime;
@synthesize jx_stitle = _jx_stitle;
@synthesize jx_summary = _jx_summary;
@synthesize jx_title = _jx_title;

@synthesize data_array = _data_array;


-(SliderBBSJingXuanModel *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        self.jx_comment = [NSString stringWithFormat:@"%@",[dic objectForKey:@"comment"]];
        
        self.jx_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        
        self.jx_link = [NSString stringWithFormat:@"%@",[dic objectForKey:@"link"]];
        
        self.jx_photo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"photo"]];
        
        self.jx_publishtime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"publishtime"]];
        
        self.jx_stitle = [NSString stringWithFormat:@"%@",[dic objectForKey:@"stitle"]];
        
        self.jx_summary = [NSString stringWithFormat:@"%@",[dic objectForKey:@"summary"]];
        
        self.jx_title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    }
    
    return self;
}


-(void)loadJXDataWithPage:(int)thePage withBlock:(SliderBBSJingXuanModelBlock)theBlock
{
    jxModelBlock = theBlock;
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:BBS_JINGXUAN_URL,thePage]];
    NSLog(@"查找论坛精选接口 ---  %@",url);
    
    if (!_data_array) {
        _data_array = [NSMutableArray array];
    }else
    {
        [_data_array removeAllObjects];
    }
    
    ASIHTTPRequest * jx_request = [[ASIHTTPRequest alloc] initWithURL:url];
    
    __block ASIHTTPRequest * request = jx_request;
    
    [request setCompletionBlock:^{
        
        NSDictionary * allDic = [jx_request.responseString objectFromJSONString];
        
        int allCount = [[allDic objectForKey:@"pages"] intValue];
        
        if ([[allDic objectForKey:@"errno"] intValue]==0) {
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                NSArray * array = [allDic objectForKey:@"news"];
                
                for (NSDictionary * dic in array)
                {
                    SliderBBSJingXuanModel * model = [[SliderBBSJingXuanModel alloc] initWithDictionary:dic];
                    
                    [_data_array addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    jxModelBlock(_data_array);
                });
            });
        }
    }];
    
    [request setFailedBlock:^{
        
    }];
    
    
    [jx_request startAsynchronous];
}




@end



























