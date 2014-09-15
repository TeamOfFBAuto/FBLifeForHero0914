//
//  SzkLoadData.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-8.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myBlock)(NSArray *arrayinfo,NSString *errorindo,int errcode);


typedef void(^heibloc)(NSDictionary *dicinfo,int errcode);




@interface SzkLoadData : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSString *string_url;

-(void)SeturlStr:(NSString *)str block:(myBlock)block;


-(void)SeturlStr:(NSString *)str mytest:(heibloc)xblock;


@property(nonatomic,copy)myBlock testBlocksbl;

@property(nonatomic,copy)heibloc xxxxbloc;

@property(nonatomic,strong)NSDictionary *mydicinfo;


@end
