//
//  FBModel.h
//  FbLife
//
//  Created by soulnear on 13-11-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

@protocol FBModelDelegate <NSObject>

-(void)returnRequestFinishedData:(NSMutableArray *)array Request:(ASIHTTPRequest *)req;

-(void)returnrequestFaildData:(ASIHTTPRequest *)req;

@end

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface FBModel : NSObject<ASIHTTPRequestDelegate>
{
    
}

@property(nonatomic,strong)NSString * theUrl;

@property(nonatomic,assign)id<FBModelDelegate>delegate;

@property(nonatomic,strong)ASIHTTPRequest * myRequest;


-(ASIHTTPRequest *)loadDataWithUrl:(NSString *)url;


@end
