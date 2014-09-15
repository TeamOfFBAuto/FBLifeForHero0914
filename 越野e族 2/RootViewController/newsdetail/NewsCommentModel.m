//
//  NewsCommentModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-21.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NewsCommentModel.h"

@implementation NewsCommentModel
@synthesize array=_array,total=_total,delegate;
//-(NewsCommentModel*)initWithtotal:(NSString *)thetotal themuarray:(NSMutableArray *)thearray{
//    self = [super init];
//    if (self) {
//        self.array=thearray;
//        self.total=_total;
//    }
//    return self;
//
//}
-(void)startloaddata{
    downloadtool *tool=[[downloadtool alloc]init];
    [tool setUrl_string:[NSString stringWithFormat:@"http://cmstest.fblife.com/ajax.php?c=news&a=newscomment&id=2&type=json"]];
    tool.delegate=self;
    [tool start];
}
-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
   NSDictionary *_dic = [data objectFromJSONData];
    NSLog(@"_dic======%@",_dic);
    self.total=[_dic objectForKey:@"total"];
    if (_dic!=NULL) {
        [self.delegate downloadsuccess];
    }
    
    
    
//    [array_name removeAllObjects];
//    [array_time removeAllObjects];
//    [array_tid removeAllObjects];
//    [array_content removeAllObjects];
//    array_weiboinfo=[[NSMutableArray alloc]init];
//    array_weiboinfo= [_dic objectForKey:@"weiboinfo"];
//    if (allcount==0) {
//        NSLog(@"jiutama0ge");
//        [_loadingview hide];
//        tab_pinglunliebiao.tableFooterView=label_noneshuju;
//        
//    }else{
//        NSLog(@"weiboinfo===%@",array_weiboinfo);
//        if ([array_weiboinfo count]!=0)
//            
//        {
//            
//            for (int i=0; i<[array_weiboinfo count]; i++) {
//                NSMutableDictionary *dic_3ge=[array_weiboinfo objectAtIndex:i];
//                NSString *string_name=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"username"]];
//                [array_name addObject:string_name];
//                
//                NSString *string_time=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"dateline"]];
//                [array_time addObject:string_time];
//                
//                NSString *string_tid=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"tid"]];
//                [array_tid addObject:string_tid];
//                
//                NSString *string_neirong=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"content"]];
//                NSString *stringtest=[string_neirong stringByReplacingOccurrencesOfString:@"[" withString:@" ["];
//                NSArray *arraytest = [stringtest componentsSeparatedByString:@" "];
//                
//                [array_content addObject:arraytest];
    
}
-(void)downloadtoolError{
}
@end
