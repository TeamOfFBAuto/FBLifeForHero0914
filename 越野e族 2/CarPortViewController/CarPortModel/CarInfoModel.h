//
//  CarInfoModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-10-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CarInfoModel;
@protocol CarInfoModelDelegate <NSObject>

-(void)finishloadCarinfowitharray:(NSArray*)carinfoarray;

@end
@interface CarInfoModel : NSObject
{
    ASIHTTPRequest * request;
}
-(void)stop;
-(void)startloadcarinfoWithcid:(NSString *)_cid;
@property(assign,nonatomic)id<CarInfoModelDelegate>delegate;
@end
