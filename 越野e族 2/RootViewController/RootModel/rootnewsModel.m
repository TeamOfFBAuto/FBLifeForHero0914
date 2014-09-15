//
//  newsModel.m
//  越野e族
//
//  Created by 史忠坤 on 13-12-25.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "rootnewsModel.h"

@implementation rootnewsModel

@synthesize delegate,tag,type;

-(void)startloadcommentsdatawithtag:(int)_tag thetype:(NSString *)_type{
    
    //推荐新闻的
    
    for (int i=0; i<3; i++) {
        twosuccess[i]=0;
    }
    self.tag=_tag;
    self.type=_type;
    
    
    
    NSString * fullURL= [NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=newsslide&classname=%@&type=json",self.type];
    NSLog(@"newmodel数据级请求的推荐新闻url = %@",fullURL);
    requestcomment = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = requestcomment;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        dic_comment = [requestcomment.responseData objectFromJSONData];
        NSLog(@"推荐的？？？？？？？===dic====%@",dic_comment);

        @try {
            if ([[dic_comment objectForKey:@"errno"] intValue] ==0)
            {
                twosuccess[0]=1;
            }
            
        }
        @catch (NSException *exception) {
            
            
        }
        @finally {
            if (twosuccess[0]==1&&twosuccess[1]==1) {
                NSLog(@"%@普通新闻和推荐新闻都下载成功了",self.type);
                
                
                [self.delegate successloadcommentdic:dic_comment mormaldic:dic_normal tag:self.tag];
                
                
                
            }

            
            
        }
        
        
        
    }];
    
    [_requset setFailedBlock:^{
        
        
        [requestcomment cancel];
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
    
    
    //普通新闻的
    
    NSString * normalurl=[NSString stringWithFormat:URL_NESTEST,_type, @"0",1,@"10"];;
    NSLog(@"1请求的url = %@",normalurl);
    requestnomal = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:normalurl]];
    
    __block ASIHTTPRequest * _requsetnormal = requestnomal;
    
    _requsetnormal.delegate = self;
    
    [_requsetnormal setCompletionBlock:^{
        dic_normal = [requestnomal.responseData objectFromJSONData];
        NSLog(@"普通的？？？？？？？===dic====%@",dic_normal);
        
        
        @try {
            if ([[dic_normal objectForKey:@"errno"] intValue] ==0)
            {
                
                twosuccess[1]=1;
            }
            
        }
        @catch (NSException *exception) {
            
            
        }
        @finally {
            if (twosuccess[0]==1&&twosuccess[1]==1) {
                NSLog(@"%@普通新闻和推荐新闻都下载成功了",self.type);
                
                [self.delegate successloadcommentdic:dic_comment mormaldic:dic_normal tag:self.tag];

                
                
                
                
            }

            
        }
        
        
        
    }];
    
    [_requsetnormal setFailedBlock:^{
        
        
        [requestnomal cancel];
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requsetnormal startAsynchronous];


    

  
}





-(void)loadmorewithtag:(int)_tag thetype:(NSString *)_type page:(int)_page{
    
    //推荐新闻的
    
    self.tag=_tag;
    
    //普通新闻的
    
    NSString * normalurl=[NSString stringWithFormat:URL_NESTEST,_type, @"0",_page,@"10"];;
    NSLog(@"1请求的url = %@",normalurl);
    requestnomal = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:normalurl]];
    
    __block ASIHTTPRequest * _requsetnormal = requestnomal;
    
    _requsetnormal.delegate = self;
    
    [_requsetnormal setCompletionBlock:^{
        dic_normal = [requestnomal.responseData objectFromJSONData];
        NSLog(@"普通的？？？？？？？===dic====%@",dic_normal);
        
        
        @try {
            if ([[dic_normal objectForKey:@"errno"] intValue] ==0)
            {
                
                twosuccess[1]=1;
            }
            
        }
        @catch (NSException *exception) {
            
            
        }
        @finally {
            
            [self.delegate doneloadmoremornormal:dic_normal tag:self.tag];
                
            
                
                
                
                
            
            
        }
        
        
        
    }];
    
    [_requsetnormal setFailedBlock:^{
        
        
        [requestnomal cancel];
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requsetnormal startAsynchronous];
    
    
    

    
}


-(void)stopload{
    
}











@end
