//
//  allbbsModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-6-4.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "downloadtool.h"
@class allbbsModel;
@protocol allbbsModeldelegate <NSObject>

//-(void)loadsuccess;
//-(void)loadsuccesserror;

@end
@interface allbbsModel : NSObject<ASIHTTPRequestDelegate>{
    NSMutableArray *array_section;//这个是公益，e族大队等，section的信息
    NSMutableArray *array_row;//2维数组，存放每一个section里面的row的内容，比如山东、北京等
    NSMutableArray *array_detail;
    
    NSMutableArray *array_IDrow;
    NSMutableArray *array_IDdetail;
    int isloadsuccess[5];
    

}
@property(assign,nonatomic)id <allbbsModeldelegate>delegate;
-(void)startloadallbbs;

@end
