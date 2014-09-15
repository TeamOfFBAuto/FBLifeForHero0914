//
//  NewsModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
@synthesize delegate;
-(void)startloaddatawithpage:(int)page words:(NSString *)thewords{
    //type=1外观，2内饰，3细节
    NSString * fullURL= [NSString stringWithFormat:@"http://carport.fblife.com/carapi/getnewslist.php?words=%@&datatype=json&page=%d&pagesize=20",thewords,page];
    NSLog(@"news请求的url = %@",fullURL);
     request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        
        
        NSDictionary * dic = [request.responseData objectFromJSONData];
        NSLog(@"imagedic -=-=  %@",dic);
        NSMutableArray *imgarray=[[NSMutableArray alloc]init];
        NSMutableArray *datearray=[[NSMutableArray alloc]init];
        NSMutableArray *titlearray=[[NSMutableArray alloc]init];
        NSMutableArray *discriptionarray=[[NSMutableArray alloc]init];
        NSMutableArray *idarray=[[NSMutableArray alloc]init];

        
        
        @try {
            if ([[dic objectForKey:@"errno"] intValue] ==0)
            {
                NSLog(@"huoquchenggong");
                
                NSArray *arrayinfo=[dic objectForKey:@"news"];
                NSLog(@"arrayofnews=%@",arrayinfo);
                
                for (int i=0; i<arrayinfo.count; i++) {
                    NSDictionary *dicinfo=[arrayinfo objectAtIndex:i];
                    NSString *string_id=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"id"]];
                    NSString *string_img=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"photo"]];
                    NSString *string_date=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"publishtime"]];
                    NSString *string_title=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"stitle"]];
                    NSString *string_discription=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"description"]];
                    
                    [idarray addObject:string_id];
                    [titlearray addObject:string_title];
                    [datearray addObject:string_date];
                    [discriptionarray addObject:string_discription];
                    [imgarray addObject:string_img];
                

                }
                
                
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            [self.delegate finishloadwithimagearray:imgarray datearray:datearray discriptionarray:discriptionarray titlearray:titlearray newsidarray:idarray];
            
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
