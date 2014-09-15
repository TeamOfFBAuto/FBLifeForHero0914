//
//  AllMessageModel.m
//  FbLife
//
//  Created by 史忠坤 on 13-8-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "AllMessageModel.h"

@implementation AllMessageModel
@synthesize string_alertnum=_string_alertnum,string_errcode=_string_errcode,delegate,string_errorinfo;
-(void)startloadallnotification{
    if (!allnotificationtool) {
        allnotificationtool=[[downloadtool alloc]init];
        
    }
    [allnotificationtool setUrl_string:@"http://t.fblife.com/openapi/index.php?mod=alert&code=alertnum&fromtype=b5eeec0b&authkey=XmoGYgVjUTNUagRuBX5T5wHHAMULtQ==&fbtype=json"];
    allnotificationtool.delegate=self;
    [allnotificationtool start];

}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        NSLog(@"dic==%@",dic);
        NSString *string_error=[NSString stringWithFormat:@"%@",[dic objectForKey:@"errcode"]];
        if ([string_error isEqualToString:@"0"]) {
            self.string_alertnum=[NSString stringWithFormat:@"%@",[dic objectForKey:@"alertnum"]];
            [self.delegate successdownloadallmessage];
        }else{
            self.string_errorinfo=[NSString stringWithFormat:@"%@",[dic objectForKey:@"data"]];
            [self.delegate errortoload];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(void)downloadtoolError{
    [self.delegate failedtodownloaddata];
}


-(void)stoploadnotifiacaton{
    [allnotificationtool stop];
    allnotificationtool.delegate=nil;
    
}

@end
