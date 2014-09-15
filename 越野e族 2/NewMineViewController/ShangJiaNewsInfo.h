//
//  ShangJiaNewsInfo.h
//  FbLife
//
//  Created by soulnear on 13-12-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShangJiaNewsInfo : NSObject
{
    
}

@property(nonatomic,strong)NSString * link;
@property(nonatomic,strong)NSString * photo;
@property(nonatomic,strong)NSString * title;


-(ShangJiaNewsInfo *)initWithDic:(NSDictionary *)dictionary;



@end
