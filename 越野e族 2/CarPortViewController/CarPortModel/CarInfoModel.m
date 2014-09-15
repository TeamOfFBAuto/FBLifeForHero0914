//
//  CarInfoModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-10-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "CarInfoModel.h"

@implementation CarInfoModel
@synthesize delegate;
-(void)startloadcarinfoWithcid:(NSString *)_cid{

    NSString * fullURL= [NSString stringWithFormat:@"http://carport.fblife.com/carapi/getmodelinfobycid2.php?cid=%@&datatype=json",_cid];
    

    NSLog(@"详细参数url===%@",fullURL);
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        NSDictionary * dic = [request.responseData objectFromJSONData];
        NSLog(@"dic=======%@",dic);
        NSArray *arrayinfo=[[NSArray alloc]init];
        @try {
            if ([[dic objectForKey:@"errno"] intValue] ==0)
            {
                arrayinfo=[dic objectForKey:@"info"];
                
                
            }
            
            
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            [self.delegate finishloadCarinfowitharray:arrayinfo];
            
            
        }
        
        
    }];
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
    
    
}
-(void)stop{
    request.delegate=nil;
    [request cancel];
}
@end
