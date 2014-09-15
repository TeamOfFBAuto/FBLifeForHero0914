//
//  downloadtool.m
//  delegatestudy
//
//  Created by 史忠坤 on 13-2-18.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "downloadtool.h"
#import "Reachability.h"
@implementation downloadtool
@synthesize url_string=_url_string,connectin=_connectin,delegate,tag=_tag;
-(void)setUrl_string:(NSString *)url_string{
    _url_string=url_string;
    NSURL *url=[NSURL URLWithString:url_string];
    _connectin = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
}
-(void)setTag:(int)tag{
    _tag=tag;
}
-(void)start{
    
//    NSString *stringnetwork=[Reachability checkNetWork ];
    
    // NSLog(@"当前的网络为%@",stringnetwork);
//    if ([stringnetwork isEqualToString:@"NONetWork"]) {
//        //[self getdatafromcache];
//        [self HaveNoNetWork];
//        
//    }else{
    
        [_connectin start];
//    }
    
}



#pragma mark-提示没有网络
-(void)HaveNoNetWork{
    
    
    [_replaceAlertView removeFromSuperview];
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"检测到您的手机没有网络连接，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=NO;
//    for (AlertRePlaceView *aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
//        [aviewp removeFromSuperview];
//    }
    for (id aviewp in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([aviewp isEqual:[AlertRePlaceView class]])
        {
            [aviewp removeFromSuperview];
        }
    }
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    [_replaceAlertView hide];
    
}
-(void)hidefromview{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2 ];
    NSLog(@"?????");
}
-(void)hidealert{
    _replaceAlertView.hidden=YES;
    
}

-(void)stop{
    [_connectin cancel];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    _mutabledata = [NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_mutabledata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    @try {
        [self.delegate downloadtool:self didfinishdownloadwithdata:_mutabledata];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前网络不稳定" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert show];
    @try {
        [self.delegate downloadtoolError];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
@end
