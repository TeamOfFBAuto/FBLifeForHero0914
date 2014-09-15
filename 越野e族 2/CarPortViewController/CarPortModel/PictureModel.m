//
//  PictureModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "PictureModel.h"
#import "JSONKit.h"
@implementation PictureModel
@synthesize delegate;
-(void)startloadimageWithtype:(int)____type  words:(NSString *)str_words{
  //type=1外观，2内饰，3细节
        NSString * fullURL= [NSString stringWithFormat:@"http://carport.fblife.com/carapi/getphotolist.php?words=%@&datatype=json&page=1&pagesize=200&type=%d",str_words,____type];
    
    NSString *newUrlStr=[NSString stringWithFormat:@"http://carport.fblife.com/carapi/getphotolist.php?words=%@&datatype=json&page=1&pagesize=100&type=9",str_words];
    
    
        NSLog(@"1请求的url = %@",newUrlStr);
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrlStr]];
        
        __block ASIHTTPRequest * _requset = request;
        
        _requset.delegate = self;
        
        [_requset setCompletionBlock:^{
            NSDictionary * dic = [request.responseData objectFromJSONData];
            NSLog(@"imagedic -=-=  %@",request.responseString);
            NSMutableArray *bigarr=[[NSMutableArray alloc]init];
            NSMutableArray *smallarr=[[NSMutableArray alloc]init];
              
            
            @try {
                if ([[dic objectForKey:@"error"] intValue] ==0)
                {
                    NSLog(@"huoquchenggong");
                    
                    NSArray *arrayinfo=[dic objectForKey:@"photo"];
                    
                    for (int i=0; i<arrayinfo.count; i++) {
                        NSDictionary *dicinfo=[arrayinfo objectAtIndex:i];
                        NSString *string_middle=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"photourl"]];
                        NSString *string_big=[string_middle stringByReplacingOccurrencesOfString:@"_m" withString:@"_b"];
                        [bigarr addObject:string_big];
                        [smallarr addObject:string_middle];
                    }


                }

            }
            @catch (NSException *exception) {
                
            }
            @finally {
                [self.delegate finishloadWithsmallarray:smallarr bigimagearray:bigarr];

                
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
