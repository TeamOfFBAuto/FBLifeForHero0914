//
//  AllMessageModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-8-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AllMessageModel;
@protocol AllMessageModelDlegate <NSObject>

-(void)successdownloadallmessage;
-(void)failedtodownloaddata;
-(void)errortoload;

@end
#import "downloadtool.h"
@interface AllMessageModel : NSObject<downloaddelegate>{
    downloadtool *allnotificationtool;
}

@property(nonatomic,strong)NSString *string_errcode;
@property(nonatomic,strong)NSString *string_alertnum;
@property(nonatomic,strong)NSString *string_errorinfo;

@property(assign,nonatomic)id<AllMessageModelDlegate>delegate;

-(void)startloadallnotification;
-(void)stoploadnotifiacaton;

@end
