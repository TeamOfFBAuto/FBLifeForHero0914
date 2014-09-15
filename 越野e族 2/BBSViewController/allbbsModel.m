//
//  allbbsModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-4.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "allbbsModel.h"
#import "JSONKit.h"
@implementation allbbsModel
@synthesize delegate;
-(void)startloadallbbs{
    ASIHTTPRequest *    _request;
    NSString *string_authcode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    if ([string_authcode isEqualToString:@"(null)"]) {
        string_authcode=@"";
    }
    _request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforums.php?type=all&formattype=json&authcode=%@",string_authcode]]];
    
     
    _request.tag=1024;
    _request.delegate=self;
    [_request startAsynchronous];
    
    
    
    
 ASIHTTPRequest *   _request1=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"diqu",string_authcode]]];
    
    _request1.tag=1025;
    _request1.delegate=self;
    [_request1 startAsynchronous];
    
 ASIHTTPRequest *   _request2=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"chexing",string_authcode]]];
    
    _request2.tag=1026;
    _request2.delegate=self;
    [_request2 startAsynchronous];
    
 ASIHTTPRequest *   _request3=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"zhuti",string_authcode]]];
    
    _request3.tag=1027;
    _request3.delegate=self;
    [_request3 startAsynchronous];
    
 ASIHTTPRequest *   _request4=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getforumsbycategory.php?categorytype=%@&formattype=json&authocode=%@",@"jiaoyi",string_authcode]]];
    
    _request4.tag=1028;
    _request4.delegate=self;
    [_request4 startAsynchronous];
    
  
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    @try
    {
        NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
        array_section=[[NSMutableArray alloc]init];
        array_row=[[NSMutableArray alloc]init];
        array_detail=[[NSMutableArray alloc]init];
        array_IDrow=[[NSMutableArray alloc]init];
        array_IDdetail=[[NSMutableArray alloc]init];
        
        
        
        NSData *data=[request responseData];
        NSDictionary *dic_test=[[NSDictionary alloc]init];
        dic_test = [data objectFromJSONData];
        NSLog(@"alldic==%@",dic_test);
        [array_section removeAllObjects];
        NSArray *bbsinfo_array=[dic_test objectForKey:@"bbsinfo"];
        for (int i=0; i<bbsinfo_array.count; i++) {
            NSDictionary *section_dic=[bbsinfo_array objectAtIndex:i];
            NSString *string_section=[section_dic objectForKey:@"name"];
            [array_section addObject:string_section];//找到了所有的section的header;
            
            NSArray *sub1_array=[section_dic objectForKey:@"sub"];//可以找到所有section里面的内容
            NSMutableArray *row_array=[[NSMutableArray alloc]init];
            NSMutableArray *idrow_array=[[NSMutableArray alloc]init];
            NSMutableArray *array_zuixiao=[[NSMutableArray alloc]init];
            NSMutableArray *array_zuixiaoid=[[NSMutableArray alloc]init];
            
            for (int i=0; i<sub1_array.count; i++) {
                NSDictionary *row_dic=[sub1_array objectAtIndex:i];
                NSString *row_string=[row_dic objectForKey:@"name"];
                [row_array addObject:row_string];//某一个section里面的row的具体内容
                NSString *idrowstring=[row_dic objectForKey:@"fid"];
                [idrow_array addObject:idrowstring];
                
                
                NSArray *sub2=[row_dic objectForKey:@"sub"];//找到所有的row里面的对应的具体分队
                NSMutableArray *array_lu=[[NSMutableArray alloc]init];
                NSMutableArray *array_idlu=[[NSMutableArray alloc]init];
                for (int i=0; i<sub2.count; i++) {
                    NSDictionary *zuixiao_dic=[sub2 objectAtIndex:i];
                    NSString *zuixiaostring=[zuixiao_dic objectForKey:@"name"];
                    [array_lu addObject:zuixiaostring];
                    
                    NSString *zuixiaostringid=[zuixiao_dic objectForKey:@"fid"];
                    [array_idlu addObject:zuixiaostringid];
                }
                [array_zuixiao addObject:array_lu];
                [array_zuixiaoid addObject:array_idlu];
            }
            [array_row addObject:row_array];//这样就可以取到所有的section里面的row的具体内容
            [array_IDrow addObject:idrow_array];//这样就可以取到所有的section里面的row的id
            
            
            [array_detail addObject:array_zuixiao];
            [array_IDdetail addObject:array_zuixiaoid];
        }
        switch (request.tag) {
            case 1024:
            {
                [standarduser setObject:array_section forKey:@"quanbusection"];
                [standarduser setObject:array_row forKey:@"quanburow"];
                [standarduser setObject:array_IDrow forKey:@"quanbuidrow"];
                [standarduser setObject:array_detail forKey:@"quanbudetail"];
                [standarduser setObject:array_IDdetail forKey:@"quanbuiddetail"];
                [standarduser synchronize];
                isloadsuccess[0]=1;
                break;
            case 1025:
                {
                    [standarduser setObject:array_section forKey:@"diqusection"];
                    [standarduser setObject:array_row forKey:@"diqurow"];
                    [standarduser setObject:array_IDrow forKey:@"diquidrow"];
                    [standarduser setObject:array_detail forKey:@"diqudetail"];
                    [standarduser setObject:array_IDdetail forKey:@"diquiddetail"];
                    
                    [standarduser synchronize];
                    isloadsuccess[1]=1;
                    
                }
                break;
            case 1026:
                {
                    [standarduser setObject:array_section forKey:@"chexingsection"];
                    [standarduser setObject:array_row forKey:@"chexingrow"];
                    [standarduser setObject:array_IDrow forKey:@"chexingidrow"];
                    [standarduser setObject:array_detail forKey:@"chexingdetail"];
                    [standarduser setObject:array_IDdetail forKey:@"chexingiddetail"];
                    [standarduser synchronize];
                    isloadsuccess[2]=1;
                }
                break;
            case 1027:
                {
                    [standarduser setObject:array_section forKey:@"zhutisection"];
                    [standarduser setObject:array_row forKey:@"zhutirow"];
                    [standarduser setObject:array_IDrow forKey:@"zhutiidrow"];
                    [standarduser setObject:array_detail forKey:@"zhutidetail"];
                    [standarduser setObject:array_IDdetail forKey:@"zhutiiddetail"];
                    [standarduser synchronize];
                    isloadsuccess[3]=1;
                }
                break;
            case 1028:
                {
                    [standarduser setObject:array_section forKey:@"jiaoyisection"];
                    [standarduser setObject:array_row forKey:@"jiaoyirow"];
                    [standarduser setObject:array_IDrow forKey:@"jiaoyiidrow"];
                    [standarduser setObject:array_detail forKey:@"jiaoyidetail"];
                    [standarduser setObject:array_IDdetail forKey:@"jiaoyiiddetail"];
                    [standarduser synchronize];
                    isloadsuccess[4]=1;
                    
                    
                }
                break;
                
                
            default:
                break;
            }
                
                
                //
                
                //
                //        NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
                
        }
        if (isloadsuccess[0]==1&isloadsuccess[1]==1&isloadsuccess[2]==1&isloadsuccess[3]==1&isloadsuccess[4]==1)
        {
            
            [standarduser setObject:@"yijingyoushujule" forKey:@"youshuju"];
            //[self.delegate loadsuccess];
        }

    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
    
      
}
-(void)requestFailed:(ASIHTTPRequest *)request{
   // [self.delegate loadsuccesserror];
}
@end
