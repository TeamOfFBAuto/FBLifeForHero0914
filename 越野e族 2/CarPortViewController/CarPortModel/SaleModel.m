//
//  SaleModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SaleModel.h"

@implementation SaleModel
@synthesize delegate;
-(void)startloadbbswithwords:(NSString *)worlds{
    NSString * fullURL= [NSString stringWithFormat:@"http://carport.fblife.com/carapi/getbrandfid.php?words=%@&datatype=json",worlds];
    NSLog(@"1请求的url = %@",fullURL);
     request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        NSDictionary * dic = [request.responseData objectFromJSONData];
        NSString *fid;
        
        
        @try {
            if ([[dic objectForKey:@"errno"] intValue] ==0)
            {
                fid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"fid"]];
                
                
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
           [ self.delegate finishloadwithid:fid];
            
            
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
