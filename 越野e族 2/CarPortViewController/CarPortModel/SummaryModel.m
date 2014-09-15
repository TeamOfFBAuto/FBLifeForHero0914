//
//  SummaryModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SummaryModel.h"

@implementation SummaryModel
@synthesize delegate;
-(void)startloaddatawithwords:(NSString *)_words{
    
    NSString * fullURL= [NSString stringWithFormat:@"http://carport.fblife.com/carapi/getmodelalllist.php?words=%@&datatype=json",_words];
    NSLog(@"综述请求的url = %@",fullURL);
    
    
     request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        
        NSDictionary * dic = [request.responseData objectFromJSONData];
        NSLog(@"suminfo -=-=  %@",dic);
        NSArray *arrayinfo;
        
        @try {
            if ([[dic objectForKey:@"errno"] intValue] ==0)
            {
                NSLog(@"huoquchenggong");
                
               arrayinfo=[dic objectForKey:@"model"];
                NSLog(@"arrayofsummary=%@",arrayinfo);
                
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            [self.delegate finishloaddatawitharray:arrayinfo];
            
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
