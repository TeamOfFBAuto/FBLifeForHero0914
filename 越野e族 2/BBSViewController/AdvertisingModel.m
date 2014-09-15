//
//  AdvertisingModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-8-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "AdvertisingModel.h"

@implementation AdvertisingModel
@synthesize string_url;
@synthesize str_bbsdetail,str_bbsfendui,str_bbshomepage,
str_newsdetail,str_urlbbsdetail,str_urlbbsfendui,
str_urlbbshomepage,str_urlnewsdetail,str_urlwbhomepage,str_wbhomepage;
-(void)startload{
    NSArray *array_url=[NSArray arrayWithObjects:@"http://cast.aim.yoyi.com.cn/afp/door/;ap=h20af541d85e6f6a0001;ct=js;pu=n1428243fc09e7230001;/?",@"http://cast.aim.yoyi.com.cn/afp/door/;ap=u20af583df9a9dcf0001;ct=js;pu=n1428243fc09e7230001;/?",@"http://cast.aim.yoyi.com.cn/afp/door/;ap=h20afdc331991d5d0001;ct=js;pu=n1428243fc09e7230001;/?",@"http://cast.aim.yoyi.com.cn/afp/door/;ap=c20afb9f618bbb2b0001;ct=js;pu=n1428243fc09e7230001;/?",@"http://cast.aim.yoyi.com.cn/afp/door/;ap=v20af5c5200ad0800001;ct=js;pu=n1428243fc09e7230001;/?", nil];
    for (int i=0; i<5; i++) {
        downloadtool *tool=[[downloadtool alloc]init];
        tool.tag=1000+i;
        [tool setUrl_string:[NSString stringWithFormat:@"%@",[array_url objectAtIndex:i]]];
        [tool start];
        tool.delegate=self;
        
        
        
    }
    
}
-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    @try {
        m[tool.tag-1000]=1;
        NSDictionary *dic;
        NSArray *array=[data objectFromJSONData];
        if (array.count>0) {
            dic=[array objectAtIndex:0];
            
            switch (tool.tag) {
                case 1000:
                    NSLog(@"获取到bbshompage的广告图");
                    self.str_bbshomepage=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
                    self.str_urlbbshomepage=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
                    break;
                case 1001:
                    NSLog(@"获取到bbsfen的广告图");
                    self.str_bbsfendui=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
                    self.str_urlbbsfendui=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
                    break;
                    
                case 1002:
                    
                    NSLog(@"获取到bbsdetail的广告图");
                    self.str_bbsdetail=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
                    self.str_urlbbsdetail=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
                    break;
                    
                case 1003:
                    NSLog(@"获取到news的广告图");
                    self.str_newsdetail=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
                    self.str_urlnewsdetail=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
                    break;
                    
                case 1004:
                    NSLog(@"获取到wb的广告图");
                    self.str_wbhomepage=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
                    self.str_urlwbhomepage=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
                    break;
                    
                default:
                    break;
            }
            
            
        }
        
        NSLog(@"dic=======ss====s==s====s==%@",dic);
        
        NSLog(@"%sdic==%@",__FUNCTION__,dic);
        
        if (m[0]==1&&m[1]==1&&m[1]==1&&m[2]==1&&m[3]==1&&m[4]==1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"guanggaoimg" object:self];
            [self.delegate finishload];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
   
    
//    [_asyimgv loadImageFromURL:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]]];
//    string_linkofimg=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
}

-(void)downloadtoolError{
    NSLog(@"读取照片失败");
    [self.delegate failedload];
}

-(void)stopload{
}
-(void)handleImageLayout:(AsyncImageView *)tag{
    NSLog(@"%s成功",__FUNCTION__);
    [self.delegate finishload];
}
@end
