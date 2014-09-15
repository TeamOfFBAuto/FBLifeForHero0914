//
//  SaleModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SaleModel;
@protocol SaleModelDelegate <NSObject>

-(void)finishloadwithid:(NSString *)str_fid;

@end
@interface SaleModel : NSObject
{
    ASIHTTPRequest * request;
}
-(void)stop;
-(void)startloadbbswithwords:(NSString *)worlds;
@property(nonatomic,assign)id<SaleModelDelegate>delegate;
@end
