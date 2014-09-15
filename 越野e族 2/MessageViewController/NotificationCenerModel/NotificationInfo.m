//
//  NotificationInfo.m
//  FbLife
//
//  Created by 史忠坤 on 13-8-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NotificationInfo.h"

@implementation NotificationInfo
@synthesize string_errcode=_string_errcode,string_errdata=_string_errdata,array_info=_array_info,delegate;
-(void)startloadnotificationwithpage:(int)page pagenumber:(NSString *)pagen withUrl:(NSString *)theUrl
{
    if (!allnotificationtool)
    {
        allnotificationtool=[[downloadtool alloc]init];
    }
    
    the_url = theUrl;
    
    NSString *string_authkey=[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD];
    // [allnotificationtool setUrl_string:[NSString stringWithFormat:@"http://t.fblife.com/openapi/index.php?mod=alert&code=alertnum&fromtype=b5eeec0b&authkey=%@&fbtype=json&page=%@&numpage=%@",string_authkey,page,pagen]];
    //    [allnotificationtool setUrl_string:[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertlist&fromtype=b5eeec0b&authkey=%@&page=1&numpage=20&fbtype=json",string_authkey ]];
    
    
    NSString * fullUrl = [NSString stringWithFormat:theUrl,string_authkey,page];
    NSLog(@"fullUrl -----  %@",fullUrl);
    [allnotificationtool setUrl_string:fullUrl];
    
    allnotificationtool.delegate=self;
    
    [allnotificationtool start];
    
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data
{
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        NSLog(@"dic==%@",dic);
        
        NSString *string_error=[NSString stringWithFormat:@"%@",[dic objectForKey:@"errcode"]];
        
        self.array_info =[[NSMutableArray alloc]init];
        
        NSLog(@"sringerr====%@",string_error);
        if ([string_error isEqualToString:@"0"])
        {
            NSString *string_test=[NSString stringWithFormat:@"%@",[dic objectForKey:@"alertlist"]];
            
            if ([string_test isEqualToString:@"<null>"])
            {
                if (!self.array_info.count)
                {
                    self.array_info = [[NSMutableArray alloc] init];
                }
                [self.delegate finishloadNotificationInfo:self.array_info errcode:@"1" errordata:@"没有返回正常的数据" withUrl:the_url];
            }
            
            else
            {
                
                
                
                
                
                self.array_info=[dic objectForKey:@"alertlist"];
                //            NSLog(@"====%@",self.array_info);
                [self.delegate finishloadNotificationInfo:self.array_info errcode:@"0" errordata:@"" withUrl:the_url];
                
                
                
                
                
            }
        }else
        {
            
            [self.delegate finishloadNotificationInfo:nil  errcode:@"0" errordata:@"" withUrl:the_url];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
   
}

-(void)downloadtoolError
{
    NSLog(@"网络不好");
    
}

-(void)stoploadnotification
{
    [allnotificationtool stop];
    allnotificationtool.delegate=nil;
}
@end
